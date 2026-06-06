"""
historico.py - Endpoints de mundiales históricos con clasificación de grupos calculada
"""
from fastapi import APIRouter, HTTPException
from database import get_conn
from cache import cache, TTL_HISTORICO

router = APIRouter(prefix="/historico", tags=["historico"])

# Mundiales con dos fases de grupos (usar orden de BD)
DOBLE_FASE_GRUPOS = {1974, 1978}

def _orden_fase(nombre: str, orden_bd: int = 0, anyo: int = 0) -> int:
    """Devuelve un número de orden para ordenar las fases correctamente."""
    # Para mundiales con doble fase de grupos, usar orden de BD directamente
    if anyo in DOBLE_FASE_GRUPOS:
        return orden_bd

    n = nombre.lower()
    if n in ('group stage', 'knockout stage', 'background'):
        return 0
    if n.startswith('group ') or n.startswith('pool') or n == 'final round':
        partes = nombre.split(' ')
        letra = partes[-1] if partes else '1'
        try:
            return 10 + int(letra)
        except ValueError:
            return 10 + (ord(letra[0].upper()) - ord('A')) if letra else 10
    if 'first round' in n: return 100
    if 'second round' in n: return 110
    if 'play-off' in n: return 115
    if 'round of 16' in n or 'octav' in n: return 120
    if 'quarter' in n: return 130
    if 'semi' in n: return 140
    if 'third' in n or 'match for third' in n: return 150
    if n == 'final': return 160
    return 200

def _nombre_fase_display(nombre: str, orden_bd: int, anyo: int) -> str:
    """Para 1974/1978, renombra las fases de grupo para mostrarlas correctamente."""
    if anyo not in DOBLE_FASE_GRUPOS:
        return nombre
    n = nombre.lower()
    if n.startswith('group '):
        letra = nombre.split(' ')[-1]
        try:
            int(letra)
            return f'1ª Fase - {nombre}'
        except ValueError:
            return f'2ª Fase - {nombre}'
    return nombre

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
            WHERE torneo_id = $1
        """, torneo['id'])

        # Ordenar fases correctamente
        fases_ordenadas = sorted(fases, key=lambda f: _orden_fase(f['nombre'], f['orden'], anyo))

        fases_result = []
        for fase in fases_ordenadas:
            nombre_lower = fase['nombre'].lower()
            if nombre_lower in ('group stage', 'knockout stage', 'background'):
                continue

            partidos = await conn.fetch("""
                SELECT p.id, p.fecha, p.grupo, p.jornada,
                       sl.nombre AS local, sv.nombre AS visitante,
                       p.goles_local, p.goles_visitante,
                       p.hubo_prorroga, p.hubo_penaltis,
                       p.penaltis_local, p.penaltis_visitante,
                       e.nombre AS estadio, e.ciudad,
                       p.bracket_pos
                FROM partidos p
                LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
                LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
                LEFT JOIN estadios e ON e.id = p.estadio_id
                WHERE p.torneo_id = $1 AND p.fase_id = $2
                ORDER BY COALESCE(p.bracket_pos, 999), p.fecha, p.id
            """, torneo['id'], fase['id'])

            partidos_list = [dict(p) for p in partidos]
            if not partidos_list:
                continue

            orden_calculado = _orden_fase(fase['nombre'], fase['orden'], anyo)
            nombre_display = _nombre_fase_display(fase['nombre'], fase['orden'], anyo)

            fase_data = {
                'nombre': nombre_display,
                'orden': orden_calculado,
                'partidos': partidos_list,
            }

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
