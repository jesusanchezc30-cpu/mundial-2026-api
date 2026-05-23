"""
routers/selecciones.py
"""
from fastapi import APIRouter, HTTPException
from database import get_conn

router = APIRouter(prefix="/selecciones", tags=["selecciones"])

@router.get("/")
async def lista_selecciones():
    """Selecciones del Mundial 2026."""
    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT DISTINCT sl.id, sl.nombre, sl.codigo_fifa,
                   p.grupo, sl.confederation
            FROM selecciones sl
            JOIN partidos p ON sl.id IN (p.seleccion_local_id, p.seleccion_visitante_id)
            JOIN torneos t ON t.id = p.torneo_id
            WHERE t.anyo = 2026 AND p.grupo IS NOT NULL
            ORDER BY p.grupo, sl.nombre
        """)
    return [dict(r) for r in rows]

@router.get("/{sel_id}")
async def detalle_seleccion(sel_id: int):
    """Detalle de una seleccion con sus partidos."""
    async with get_conn() as conn:
        sel = await conn.fetchrow(
            "SELECT id, nombre, codigo_fifa, confederation FROM selecciones WHERE id = $1",
            sel_id
        )
        if not sel:
            raise HTTPException(404, "Seleccion no encontrada")

        partidos = await conn.fetch("""
            SELECT p.id, p.fecha, p.hora_espana::text AS hora_espana,
                   sl.nombre AS local, sv.nombre AS visitante,
                   p.goles_local, p.goles_visitante, p.estado, p.grupo,
                   f.nombre AS fase
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            JOIN fases f ON f.id = p.fase_id
            LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
            LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
            WHERE t.anyo = 2026
              AND (p.seleccion_local_id = $1 OR p.seleccion_visitante_id = $1)
            ORDER BY p.fecha, p.hora_local
        """, sel_id)

    return {
        **dict(sel),
        "partidos": [dict(p) for p in partidos]
    }
