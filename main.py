"""
main.py - API Mundial 2026
"""
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from database import init_db, close_db, get_conn
import partidos
import grupos
import selecciones
import estadios
import historico
import clima
import httpx
from datetime import date

SOFA_BASE = "https://www.sofascore.com/api/v1/event"
SOFA_HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    "Accept": "application/json",
    "Referer": "https://www.sofascore.com/",
}

@asynccontextmanager
async def lifespan(app: FastAPI):
    await init_db()
    yield
    await close_db()

app = FastAPI(
    title="Mundial 2026 API",
    description="API de datos del Mundial 2026",
    version="1.1.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(partidos.router)
app.include_router(grupos.router)
app.include_router(selecciones.router)
app.include_router(estadios.router)
app.include_router(historico.router)
app.include_router(clima.router)

from cache import cache

@app.post("/admin/clear-cache")
async def clear_cache():
    cache.clear()
    return {"status": "ok", "message": "Cache limpiada"}

FOOTBALL_DATA_KEY = "442f1da323304a9894048f71534cb466"
FOOTBALL_DATA_BASE = "https://api.football-data.org/v4"
FOOTBALL_DATA_HEADERS = {"X-Auth-Token": FOOTBALL_DATA_KEY}

@app.post("/admin/update-estados")
async def update_estados():
    """Consulta football-data.org y actualiza estado + marcador de partidos del Mundial 2026"""
    from datetime import timedelta
    hoy = date.today()
    actualizados = 0
    errores = 0

    try:
        async with httpx.AsyncClient(timeout=10) as client:
            resp = await client.get(
                f"{FOOTBALL_DATA_BASE}/competitions/2000/matches",
                headers=FOOTBALL_DATA_HEADERS,
                params={
                    "dateFrom": str(hoy - timedelta(days=1)),
                    "dateTo": str(hoy + timedelta(days=1)),
                }
            )
        if resp.status_code != 200:
            return {"status": "error", "code": resp.status_code}

        matches = resp.json().get("matches", [])

        async with get_conn() as conn:
            for match in matches:
                status = match.get("status", "")
                score = match.get("score", {})
                home_name = match.get("homeTeam", {}).get("name", "")
                away_name = match.get("awayTeam", {}).get("name", "")

                if status == "FINISHED":
                    nuevo_estado = "finalizado"
                elif status in ("IN_PLAY", "PAUSED", "HALFTIME"):
                    nuevo_estado = "en_juego"
                else:
                    nuevo_estado = "pendiente"

                ft = score.get("fullTime", {})
                ht = score.get("halfTime", {})
                gl = ft.get("home") if ft.get("home") is not None else ht.get("home")
                gv = ft.get("away") if ft.get("away") is not None else ht.get("away")

                row = await conn.fetchrow("""
                    SELECT p.id FROM partidos p
                    JOIN selecciones sl ON sl.id = p.seleccion_local_id
                    JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
                    JOIN torneos t ON t.id = p.torneo_id
                    WHERE t.anyo = 2026
                    AND (sl.nombre ILIKE $1 OR sl.nombre ILIKE $2)
                    AND (sv.nombre ILIKE $3 OR sv.nombre ILIKE $4)
                    LIMIT 1
                """, home_name, f"%{home_name.split()[0]}%",
                    away_name, f"%{away_name.split()[0]}%")

                if not row:
                    continue

                await conn.execute("""
                    UPDATE partidos
                    SET estado = $1,
                        goles_local = COALESCE($2, goles_local),
                        goles_visitante = COALESCE($3, goles_visitante)
                    WHERE id = $4
                """, nuevo_estado, gl, gv, row['id'])

                actualizados += 1

    except Exception as e:
        errores += 1

    cache.clear()
    return {"status": "ok", "actualizados": actualizados, "errores": errores}

@app.post("/admin/update-stats")
async def update_stats():
    async with get_conn() as conn:
        await conn.execute("""
            UPDATE jugadores SET goles = 0, asistencias = 0
            WHERE seleccion_id IN (
                SELECT sel.id FROM selecciones sel
                JOIN partidos p ON (p.seleccion_local_id = sel.id OR p.seleccion_visitante_id = sel.id)
                JOIN torneos t ON t.id = p.torneo_id
                WHERE t.anyo = 2026
            )
        """)
        partidos_rows = await conn.fetch("""
            SELECT id, sofascore_id FROM partidos
            WHERE estado = 'finalizado' AND sofascore_id IS NOT NULL
            AND torneo_id = (SELECT id FROM torneos WHERE anyo = 2026)
        """)
        actualizados = 0
        for partido in partidos_rows:
            sofa_id = partido['sofascore_id']
            try:
                async with httpx.AsyncClient(timeout=5) as client:
                    resp = await client.get(
                        f"{SOFA_BASE}/{sofa_id}/incidents",
                        headers=SOFA_HEADERS
                    )
                if resp.status_code != 200:
                    continue
                incidents = resp.json().get("incidents", [])
                for inc in incidents:
                    if inc.get("incidentType") != "goal":
                        continue
                    if inc.get("incidentClass") == "ownGoal":
                        continue
                    jugador_nombre = inc.get("player", {}).get("name", "")
                    asistente_nombre = (inc.get("assist1") or {}).get("name", "")
                    if jugador_nombre:
                        await conn.execute("""
                            UPDATE jugadores SET goles = goles + 1
                            WHERE nombre ILIKE $1
                        """, jugador_nombre)
                    if asistente_nombre:
                        await conn.execute("""
                            UPDATE jugadores SET asistencias = asistencias + 1
                            WHERE nombre ILIKE $1
                        """, asistente_nombre)
                actualizados += 1
            except Exception:
                continue
    cache.clear()
    return {"status": "ok", "partidos_procesados": actualizados}

@app.get("/goleadores")
async def goleadores():
    key = "goleadores:top20"
    cached = cache.get(key)
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT j.nombre, j.goles, j.asistencias, s.nombre AS seleccion
            FROM jugadores j
            JOIN selecciones s ON s.id = j.seleccion_id
            ORDER BY j.goles DESC, j.asistencias DESC
            LIMIT 20
        """)
    result = [dict(r) for r in rows]
    cache.set(key, result, 60)
    return result

@app.get("/asistentes")
async def asistentes():
    key = "asistentes:top20"
    cached = cache.get(key)
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT j.nombre, j.goles, j.asistencias, s.nombre AS seleccion
            FROM jugadores j
            JOIN selecciones s ON s.id = j.seleccion_id
            ORDER BY j.asistencias DESC, j.goles DESC
            LIMIT 20
        """)
    result = [dict(r) for r in rows]
    cache.set(key, result, 60)
    return result

@app.get("/")
async def root():
    return {
        "api": "Mundial 2026",
        "version": "1.1.0",
        "endpoints": [
            "/partidos/hoy",
            "/partidos/proximos?dias=7",
            "/partidos/fecha/{YYYY-MM-DD}",
            "/partidos/grupo/{letra}",
            "/partidos/{id}",
            "/partidos/{id}/live",
            "/partidos/{id}/eventos",
            "/grupos/",
            "/grupos/{letra}",
            "/selecciones/",
            "/selecciones/{id}",
            "/selecciones/{id}/jugadores",
            "/estadios/",
            "/estadios/{id}",
            "/historico/",
            "/historico/{anyo}",
            "/clima/estadio/{id}",
            "/clima/partido/{id}",
            "/goleadores",
            "/asistentes",
            "/admin/clear-cache",
            "/admin/update-estados",
            "/admin/update-stats",
        ]
    }
