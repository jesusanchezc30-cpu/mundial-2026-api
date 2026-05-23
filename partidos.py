"""
partidos.py - Endpoints de partidos con cache
"""
from fastapi import APIRouter, HTTPException
from datetime import date, timedelta
import httpx
from database import get_conn
from cache import cache, TTL_PARTIDOS_HOY, TTL_PARTIDOS_PROXIMOS

router = APIRouter(prefix="/partidos", tags=["partidos"])

SOFA_BASE = "https://www.sofascore.com/api/v1/event"
SOFA_HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    "Accept": "application/json",
    "Referer": "https://www.sofascore.com/",
}

SQL_PARTIDO = """
    SELECT
        p.id,
        p.fecha,
        p.hora_local::text        AS hora_local,
        p.hora_espana::text       AS hora_espana,
        sl.nombre                 AS local,
        sv.nombre                 AS visitante,
        p.grupo,
        f.nombre                  AS fase,
        e.nombre                  AS estadio,
        e.ciudad,
        p.goles_local,
        p.goles_visitante,
        p.estado,
        p.sofascore_id
    FROM partidos p
    JOIN torneos t   ON t.id = p.torneo_id
    JOIN fases f     ON f.id = p.fase_id
    LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
    LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
    LEFT JOIN estadios e     ON e.id  = p.estadio_id
    WHERE t.anyo = 2026
"""

@router.get("/hoy")
async def partidos_hoy():
    hoy = date.today()
    key = f"partidos:hoy:{hoy}"
    cached = cache.get(key)
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch(SQL_PARTIDO + " AND p.fecha = $1 ORDER BY p.hora_local", hoy)
    result = [dict(r) for r in rows]
    cache.set(key, result, TTL_PARTIDOS_HOY)
    return result

@router.get("/proximos")
async def partidos_proximos(dias: int = 7):
    hoy = date.today()
    hasta = hoy + timedelta(days=dias)
    key = f"partidos:proximos:{hoy}:{dias}"
    cached = cache.get(key)
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch(
            SQL_PARTIDO + " AND p.fecha BETWEEN $1 AND $2 ORDER BY p.fecha, p.hora_local",
            hoy, hasta
        )
    result = [dict(r) for r in rows]
    cache.set(key, result, TTL_PARTIDOS_PROXIMOS)
    return result

@router.get("/fecha/{fecha_str}")
async def partidos_por_fecha(fecha_str: str):
    try:
        fecha = date.fromisoformat(fecha_str)
    except ValueError:
        raise HTTPException(400, "Formato de fecha invalido. Usa YYYY-MM-DD")
    key = f"partidos:fecha:{fecha_str}"
    cached = cache.get(key)
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch(SQL_PARTIDO + " AND p.fecha = $1 ORDER BY p.hora_local", fecha)
    result = [dict(r) for r in rows]
    cache.set(key, result, TTL_PARTIDOS_PROXIMOS)
    return result

@router.get("/grupo/{letra}")
async def partidos_grupo(letra: str):
    letra = letra.upper()
    key = f"partidos:grupo:{letra}"
    cached = cache.get(key)
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch(
            SQL_PARTIDO + " AND p.grupo = $1 ORDER BY p.fecha, p.hora_local", letra
        )
    if not rows:
        raise HTTPException(404, f"Grupo {letra} no encontrado")
    result = [dict(r) for r in rows]
    cache.set(key, result, TTL_GRUPOS)
    return result

@router.get("/{partido_id}/live")
async def partido_live(partido_id: int):
    """Score en vivo desde Sofascore (sin cache — siempre fresco)."""
    async with get_conn() as conn:
        row = await conn.fetchrow(
            "SELECT sofascore_id FROM partidos WHERE id = $1", partido_id
        )
    if not row or not row["sofascore_id"]:
        raise HTTPException(404, "Partido sin ID de Sofascore")
    sofa_id = row["sofascore_id"]
    try:
        async with httpx.AsyncClient(timeout=5) as client:
            resp = await client.get(f"{SOFA_BASE}/{sofa_id}", headers=SOFA_HEADERS)
        if resp.status_code != 200:
            raise HTTPException(503, "Sofascore no disponible")
        data = resp.json().get("event", {})
        return {
            "sofascore_id": sofa_id,
            "estado": data.get("status", {}).get("description"),
            "minuto": data.get("time", {}).get("current"),
            "goles_local": data.get("homeScore", {}).get("current"),
            "goles_visitante": data.get("awayScore", {}).get("current"),
            "local": data.get("homeTeam", {}).get("name"),
            "visitante": data.get("awayTeam", {}).get("name"),
        }
    except httpx.RequestError:
        raise HTTPException(503, "Error conectando con Sofascore")

@router.get("/{partido_id}")
async def partido_detalle(partido_id: int):
    async with get_conn() as conn:
        rows = await conn.fetch(SQL_PARTIDO + " AND p.id = $1", partido_id)
    if not rows:
        raise HTTPException(404, "Partido no encontrado")
    return dict(rows[0])
