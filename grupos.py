"""
grupos.py - Clasificacion de grupos
"""
from fastapi import APIRouter, HTTPException
from database import get_conn
from cache import cache, TTL_GRUPOS

router = APIRouter(prefix="/grupos", tags=["grupos"])

@router.get("/")
async def todos_los_grupos():
    cached = cache.get("grupos:lista")
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT DISTINCT grupo FROM partidos
            JOIN torneos t ON t.id = torneo_id
            WHERE t.anyo = 2026 AND grupo IS NOT NULL AND grupo != ''
            ORDER BY grupo
        """)
        grupos = [r["grupo"] for r in rows]
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
    cache.set("grupos:lista", result, TTL_GRUPOS)
    return result

@router.get("/{letra}")
async def clasificacion_grupo(letra: str):
    letra = letra.upper()
    key = f"grupo:{letra}"
    cached = cache.get(key)
    if cached:
        return cached

    async with get_conn() as conn:
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

        partidos = await conn.fetch("""
            SELECT p.id, p.fecha, p.fecha_espana, p.hora_espana::text AS hora_espana,
                   sl.nombre AS local, sv.nombre AS visitante,
                   p.goles_local, p.goles_visitante, p.estado,
                   p.seleccion_local_id, p.seleccion_visitante_id,
                   e.nombre AS estadio, e.ciudad
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
            LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
            LEFT JOIN estadios e ON e.id = p.estadio_id
            WHERE t.anyo = 2026 AND p.grupo = $1
            ORDER BY p.fecha_espana, p.hora_espana
        """, letra)

    tabla = {}
    for s in selecciones:
        tabla[s["id"]] = {
            "seleccion": s["nombre"],
            "codigo_fifa": s["codigo_fifa"],
            "pj": 0, "pg": 0, "pe": 0, "pp": 0,
            "gf": 0, "gc": 0, "dg": 0, "pts": 0
        }

    for p in partidos:
        if p["estado"] not in ("finalizado", "en_juego") or p["goles_local"] is None:
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

    clasificacion = sorted(tabla.values(), key=lambda x: (-x["pts"], -x["dg"], -x["gf"]))
    for i, s in enumerate(clasificacion):
        s["pos"] = i + 1

    result = {
        "grupo": letra,
        "clasificacion": clasificacion,
        "partidos": [dict(p) for p in partidos]
    }
    cache.set(key, result, TTL_GRUPOS)
    return result
