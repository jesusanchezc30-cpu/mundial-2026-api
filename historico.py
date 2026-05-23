"""
historico.py
"""
from fastapi import APIRouter, HTTPException
from database import get_conn
from cache import cache, TTL_HISTORICO

router = APIRouter(prefix="/historico", tags=["historico"])

@router.get("/")
async def lista_mundiales():
    cached = cache.get("historico:lista")
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT anyo, pais_sede, paises_sede, campeon, subcampeon,
                   tercer_puesto, cuarto_puesto, num_equipos, num_partidos,
                   goles_totales, media_goles, maximo_goleador
            FROM torneos WHERE anyo < 2026 ORDER BY anyo DESC
        """)
    result = [dict(r) for r in rows]
    cache.set("historico:lista", result, TTL_HISTORICO)
    return result

@router.get("/{anyo}")
async def mundial_detalle(anyo: int):
    key = f"historico:{anyo}"
    cached = cache.get(key)
    if cached:
        return cached
    async with get_conn() as conn:
        row = await conn.fetchrow("SELECT * FROM torneos WHERE anyo = $1", anyo)
    if not row:
        raise HTTPException(404, f"Mundial {anyo} no encontrado")
    result = dict(row)
    cache.set(key, result, TTL_HISTORICO)
    return result
