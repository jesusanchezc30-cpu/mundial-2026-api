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

@app.post("/admin/update-estados")
async def update_estados():
    """Consulta Sofascore y actualiza estado + marcador de partidos de hoy y ayer"""
    hoy = date.today()
    actualizados = 0
    errores = 0

    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT id, sofascore_id, estado
            FROM partidos
            WHERE sofascore_id IS NOT NULL
            AND fecha_espana >= ($1::date - INTERVAL '1 day')::date
            AND fecha_espana <= ($1::date + INTERVAL '1 day')::date
            AND torneo_id = (SELECT id FROM torneos WHERE anyo = 2026)
        """, hoy)

        for row in rows:
            sofa_id = row['sofascore_id']
            partido_id = row['id']
            try:
                async with httpx.AsyncClient(timeout=5) as client:
                    resp = await client.get(
                        f"{SOFA_BASE}/{sofa_id}",
                        headers=SOFA_HEADERS
                    )
                if resp.status_code != 200:
                    continue

                event = resp.json().get("event", {})
                status = event.get("status", {})
                status_type = status.get("type", "")
                status_desc = status.get("description", "")

                # Mapear estado Sofascore → nuestro estado
                if status_type == "finished":
                    nuevo_estado = "finalizado"
                elif status_type == "inprogress":
                    nuevo_estado = "en_juego"
                elif status_type == "notstarted":
                    nuevo_estado = "pendiente"
                else:
                    nuevo_estado = "pendiente"

                # Marcador
                gl = event.get("homeScore", {}).get("current")
                gv = event.get("awayScore", {}).get("current")

                await conn.execute("""
                    UPDATE partidos
                    SET estado = $1,
                        goles_local = COALESCE($2, goles_local),
                        goles_visitante = COALESCE($3, goles_visitante)
                    WHERE id = $4
                """, nuevo_estado, gl, gv, partido_id)

                actualizados += 1
            except Exception:
                errores += 1
                continue

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
