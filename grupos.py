"""
routers/grupos.py - Clasificacion de grupos
"""
from fastapi import APIRouter, HTTPException
from database import get_conn

router = APIRouter(prefix="/grupos", tags=["grupos"])

SQL_CLASIFICACION = """
    SELECT
        p.grupo,
        sl.nombre        AS seleccion,
        sl.codigo_fifa,
        COUNT(*)                                          AS pj,
        SUM(CASE WHEN p.goles_local > p.goles_visitante  AND p.seleccion_local_id    = sl.id THEN 1
                 WHEN p.goles_visitante > p.goles_local  AND p.seleccion_visitante_id = sl.id THEN 1
                 ELSE 0 END)                              AS pg,
        SUM(CASE WHEN p.goles_local = p.goles_visitante  AND p.goles_local IS NOT NULL THEN 1 ELSE 0 END) AS pe,
        SUM(CASE WHEN p.goles_local < p.goles_visitante  AND p.seleccion_local_id    = sl.id THEN 1
                 WHEN p.goles_visitante < p.goles_local  AND p.seleccion_visitante_id = sl.id THEN 1
                 ELSE 0 END)                              AS pp,
        SUM(CASE WHEN p.seleccion_local_id    = sl.id THEN COALESCE(p.goles_local, 0)
                 WHEN p.seleccion_visitante_id = sl.id THEN COALESCE(p.goles_visitante, 0)
                 ELSE 0 END)                              AS gf,
        SUM(CASE WHEN p.seleccion_local_id    = sl.id THEN COALESCE(p.goles_visitante, 0)
                 WHEN p.seleccion_visitante_id = sl.id THEN COALESCE(p.goles_local, 0)
                 ELSE 0 END)                              AS gc
    FROM partidos p
    JOIN torneos t ON t.id = p.torneo_id
    JOIN selecciones sl ON sl.id IN (p.seleccion_local_id, p.seleccion_visitante_id)
    WHERE t.anyo = 2026
      AND p.grupo IS NOT NULL
      AND p.grupo != ''
      AND p.estado = 'finalizado'
    GROUP BY p.grupo, sl.id, sl.nombre, sl.codigo_fifa
    ORDER BY p.grupo, pts DESC, dg DESC, gf DESC
"""

@router.get("/")
async def todos_los_grupos():
    """Clasificacion de todos los grupos."""
    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT DISTINCT grupo FROM partidos
            JOIN torneos t ON t.id = torneo_id
            WHERE t.anyo = 2026 AND grupo IS NOT NULL AND grupo != ''
            ORDER BY grupo
        """)
        grupos = [r["grupo"] for r in rows]

        # Devuelve selecciones por grupo aunque no haya partidos jugados
        result = {}
        for g in grupos:
            sels = await conn.fetch("""
                SELECT DISTINCT sl.nombre, sl.codigo_fifa
                FROM partidos p
                JOIN torneos t ON t.id = p.torneo_id
                JOIN selecciones sl ON sl.id IN (p.seleccion_local_id, p.seleccion_visitante_id)
                WHERE t.anyo = 2026 AND p.grupo = $1
                ORDER BY sl.nombre
            """, g)
            result[g] = [dict(s) for s in sels]
    return result

@router.get("/{letra}")
async def clasificacion_grupo(letra: str):
    """Clasificacion de un grupo con partidos jugados y pendientes."""
    letra = letra.upper()
    async with get_conn() as conn:
        # Selecciones del grupo
        selecciones = await conn.fetch("""
            SELECT DISTINCT sl.id, sl.nombre, sl.codigo_fifa
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            JOIN selecciones sl ON sl.id IN (p.seleccion_local_id, p.seleccion_visitante_id)
            WHERE t.anyo = 2026 AND p.grupo = $1
            ORDER BY sl.nombre
        """, letra)

        if not selecciones:
            raise HTTPException(404, f"Grupo {letra} no encontrado")

        # Partidos del grupo
        partidos = await conn.fetch("""
            SELECT p.id, p.fecha, p.hora_espana::text AS hora_espana,
                   sl.nombre AS local, sv.nombre AS visitante,
                   p.goles_local, p.goles_visitante, p.estado,
                   p.seleccion_local_id, p.seleccion_visitante_id
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
            LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
            WHERE t.anyo = 2026 AND p.grupo = $1
            ORDER BY p.fecha, p.hora_local
        """, letra)

    # Calcular clasificacion
    tabla = {}
    for s in selecciones:
        tabla[s["id"]] = {
            "seleccion": s["nombre"],
            "codigo_fifa": s["codigo_fifa"],
            "pj": 0, "pg": 0, "pe": 0, "pp": 0,
            "gf": 0, "gc": 0, "dg": 0, "pts": 0
        }

    for p in partidos:
        if p["estado"] != "finalizado" or p["goles_local"] is None:
            continue
        lid = p["seleccion_local_id"]
        vid = p["seleccion_visitante_id"]
        gl = p["goles_local"]
        gv = p["goles_visitante"]

        for sid, gf, gc in [(lid, gl, gv), (vid, gv, gl)]:
            if sid not in tabla:
                continue
            tabla[sid]["pj"] += 1
            tabla[sid]["gf"] += gf
            tabla[sid]["gc"] += gc
            tabla[sid]["dg"] = tabla[sid]["gf"] - tabla[sid]["gc"]
            if gf > gc:
                tabla[sid]["pg"] += 1
                tabla[sid]["pts"] += 3
            elif gf == gc:
                tabla[sid]["pe"] += 1
                tabla[sid]["pts"] += 1
            else:
                tabla[sid]["pp"] += 1

    clasificacion = sorted(
        tabla.values(),
        key=lambda x: (-x["pts"], -x["dg"], -x["gf"])
    )
    for i, s in enumerate(clasificacion):
        s["pos"] = i + 1

    return {
        "grupo": letra,
        "clasificacion": clasificacion,
        "partidos": [dict(p) for p in partidos]
    }
