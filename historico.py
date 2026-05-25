"""
historico.py - Endpoints de mundiales históricos con clasificación de grupos calculada
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

def _calcular_clasificacion(partidos):
    """Calcula la clasificación a partir de una lista de partidos de grupo."""
    tabla = {}
    for p in partidos:
        for sel, gf, gc in [
            (p['local'], p['goles_local'], p['goles_visitante']),
            (p['visitante'], p['goles_visitante'], p['goles_local'])
        ]:
            if sel not in tabla:
                tabla[sel] = {'seleccion': sel, 'pj': 0, 'pg': 0, 'pe': 0, 'pp': 0, 'gf': 0, 'gc': 0, 'dg': 0, 'pts': 0}
            if gf is None:
                continue
            tabla[sel]['pj'] += 1
            tabla[sel]['gf'] += gf
            tabla[sel]['gc'] += gc
            tabla[sel]['dg'] = tabla[sel]['gf'] - tabla[sel]['gc']
            if gf > gc:
                tabla[sel]['pg'] += 1
                tabla[sel]['pts'] += 3
            elif gf == gc:
                tabla[sel]['pe'] += 1
                tabla[sel]['pts'] += 1
            else:
                tabla[sel]['pp'] += 1

    clasificacion = sorted(tabla.values(), key=lambda x: (-x['pts'], -x['dg'], -x['gf']))
    for i, s in enumerate(clasificacion):
        s['pos'] = i + 1
    return clasificacion

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

        fases_result = []
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

            partidos_list = [dict(p) for p in partidos]
            if not partidos_list:
                continue

            fase_data = {
                'nombre': fase['nombre'],
                'orden': fase['orden'],
                'partidos': partidos_list,
            }

            # Calcular clasificación para fases de grupo
            nombre_lower = fase['nombre'].lower()
            es_grupo = (
                'group' in nombre_lower or
                'pool' in nombre_lower or
                nombre_lower == 'final round'
            ) and 'knockout' not in nombre_lower and 'stage' not in nombre_lower

            if es_grupo and len(partidos_list) >= 2:
                fase_data['clasificacion'] = _calcular_clasificacion(partidos_list)

            fases_result.append(fase_data)

    result = {
        **dict(torneo),
        'fases': fases_result,
    }
    cache.set(key, result, TTL_HISTORICO)
    return result
