"""
historico.py - Endpoints de mundiales históricos
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
        torneo = await conn.fetchrow("SELECT * FROM torneos WHERE anyo = $1", anyo)
        if not torneo:
            raise HTTPException(404, f"Mundial {anyo} no encontrado")

        fases = await conn.fetch("""
            SELECT id, nombre, orden FROM fases
            WHERE torneo_id = $1 ORDER BY orden
        """, torneo['id'])

        partidos_por_fase = {}
        for fase in fases:
            partidos = await conn.fetch("""
                SELECT p.id, p.fecha, p.grupo, p.jornada,
                       sl.nombre AS local, sv.nombre AS visitante,
                       p.goles_local, p.goles_visitante,
                       p.hubo_prorroga, p.hubo_penaltis,
                       p.penaltis_local, p.penaltis_visitante,
                       e.nombre AS estadio, e.ciudad
                FROM partidos p
                LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
                LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
                LEFT JOIN estadios e ON e.id = p.estadio_id
                WHERE p.torneo_id = $1 AND p.fase_id = $2
                ORDER BY p.fecha, p.id
            """, torneo['id'], fase['id'])
            partidos_por_fase[fase['nombre']] = [dict(p) for p in partidos]

    result = {
        **dict(torneo),
        "fases": [
            {
                "nombre": fase['nombre'],
                "orden": fase['orden'],
                "partidos": partidos_por_fase.get(fase['nombre'], [])
            }
            for fase in fases
        ]
    }
    cache.set(key, result, TTL_HISTORICO)
    return result
