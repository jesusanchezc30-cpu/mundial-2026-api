"""
routers/estadios.py
"""
from fastapi import APIRouter, HTTPException
from database import get_conn

router = APIRouter(prefix="/estadios", tags=["estadios"])

@router.get("/")
async def lista_estadios():
    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT id, nombre, ciudad, pais, capacidad, latitud, longitud
            FROM estadios ORDER BY pais, ciudad
        """)
    return [dict(r) for r in rows]

@router.get("/{estadio_id}")
async def detalle_estadio(estadio_id: int):
    async with get_conn() as conn:
        row = await conn.fetchrow(
            "SELECT * FROM estadios WHERE id = $1", estadio_id
        )
        if not row:
            raise HTTPException(404, "Estadio no encontrado")
        partidos = await conn.fetch("""
            SELECT p.fecha, p.hora_espana::text AS hora_espana,
                   sl.nombre AS local, sv.nombre AS visitante,
                   p.goles_local, p.goles_visitante, p.grupo, f.nombre AS fase
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            JOIN fases f ON f.id = p.fase_id
            LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
            LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
            WHERE t.anyo = 2026 AND p.estadio_id = $1
            ORDER BY p.fecha, p.hora_local
        """, estadio_id)
    return {**dict(row), "partidos": [dict(p) for p in partidos]}
