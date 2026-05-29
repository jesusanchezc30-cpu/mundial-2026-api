"""
selecciones.py - Endpoints de selecciones con estadísticas históricas
"""
from fastapi import APIRouter, HTTPException
from database import get_conn
from cache import cache, TTL_SELECCIONES

router = APIRouter(prefix="/selecciones", tags=["selecciones"])

@router.get("/")
async def lista_selecciones():
    cached = cache.get("selecciones:lista")
    if cached:
        return cached
    async with get_conn() as conn:
        rows = await conn.fetch("""
            SELECT DISTINCT s.id, s.nombre, s.codigo_fifa, s.confederacion,
                   p.grupo
            FROM selecciones s
            JOIN partidos p ON p.seleccion_local_id = s.id OR p.seleccion_visitante_id = s.id
            JOIN torneos t ON t.id = p.torneo_id
            WHERE t.anyo = 2026 AND p.grupo IS NOT NULL
            ORDER BY p.grupo, s.nombre
        """)
    result = [dict(r) for r in rows]
    cache.set("selecciones:lista", result, TTL_SELECCIONES)
    return result

@router.get("/{sel_id}")
async def detalle_seleccion(sel_id: int):
    key = f"seleccion:{sel_id}"
    cached = cache.get(key)
    if cached:
        return cached

    async with get_conn() as conn:
        sel = await conn.fetchrow(
            "SELECT * FROM selecciones WHERE id = $1", sel_id
        )
        if not sel:
            raise HTTPException(404, "Selección no encontrada")

        # Grupo en el Mundial 2026
        grupo_row = await conn.fetchrow("""
            SELECT p.grupo FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            WHERE (p.seleccion_local_id = $1 OR p.seleccion_visitante_id = $1)
            AND t.anyo = 2026 AND p.grupo IS NOT NULL
            LIMIT 1
        """, sel_id)
        grupo = grupo_row['grupo'] if grupo_row else None

        # Participaciones en mundiales
        participaciones = await conn.fetch("""
            SELECT DISTINCT t.anyo, t.pais_sede
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            WHERE (p.seleccion_local_id = $1 OR p.seleccion_visitante_id = $1)
            AND t.anyo < 2026
            ORDER BY t.anyo DESC
        """, sel_id)

        # Todos los partidos históricos con resultados
        partidos = await conn.fetch("""
            SELECT p.goles_local, p.goles_visitante,
                   p.seleccion_local_id, p.seleccion_visitante_id,
                   sl.nombre AS local_nombre,
                   sv.nombre AS visitante_nombre,
                   t.anyo
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
            LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
            WHERE (p.seleccion_local_id = $1 OR p.seleccion_visitante_id = $1)
            AND t.anyo < 2026
            AND p.goles_local IS NOT NULL
        """, sel_id)

        # Calcular estadísticas
        stats = {'pj': 0, 'pg': 0, 'pe': 0, 'pp': 0, 'gf': 0, 'gc': 0}
        rivales = {}
        mayor_goleada_dada = None
        mayor_goleada_recibida = None

        for p in partidos:
            es_local = p['seleccion_local_id'] == sel_id
            gf = p['goles_local'] if es_local else p['goles_visitante']
            gc = p['goles_visitante'] if es_local else p['goles_local']
            rival = p['visitante_nombre'] if es_local else p['local_nombre']

            if not rival or rival == sel['nombre']:
                continue

            stats['pj'] += 1
            stats['gf'] += gf
            stats['gc'] += gc

            if gf > gc:
                stats['pg'] += 1
            elif gf == gc:
                stats['pe'] += 1
            else:
                stats['pp'] += 1

            # Stats por rival
            if rival not in rivales:
                rivales[rival] = {'pj': 0, 'pg': 0, 'pe': 0, 'pp': 0}
            rivales[rival]['pj'] += 1
            if gf > gc:
                rivales[rival]['pg'] += 1
            elif gf == gc:
                rivales[rival]['pe'] += 1
            else:
                rivales[rival]['pp'] += 1

            # Mayor goleada dada
            if gf > gc:
                diff = gf - gc
                if mayor_goleada_dada is None or diff > mayor_goleada_dada['diff']:
                    mayor_goleada_dada = {'resultado': f'{gf}-{gc}', 'rival': rival, 'anyo': p['anyo'], 'diff': diff}

            # Mayor goleada recibida
            if gc > gf:
                diff_rec = gc - gf
                if mayor_goleada_recibida is None or diff_rec > mayor_goleada_recibida['diff']:
                    mayor_goleada_recibida = {'resultado': f'{gc}-{gf}', 'rival': rival, 'anyo': p['anyo'], 'diff': diff_rec}

        # Mejor y peor rival (mínimo 2 partidos)
        mejor_rival = None
        peor_rival = None
        rivales_filtrados = {k: v for k, v in rivales.items() if v['pj'] >= 2}
        if rivales_filtrados:
            mejor_rival = max(rivales_filtrados.items(), key=lambda x: (x[1]['pg'], -x[1]['pp']))[0]
            peor_rival = max(rivales_filtrados.items(), key=lambda x: (x[1]['pp'], -x[1]['pg']))[0]

        # Palmarés
        palmares = await conn.fetch("""
            SELECT t.anyo, t.campeon, t.subcampeon, t.tercer_puesto, t.cuarto_puesto
            FROM torneos t
            WHERE t.anyo < 2026
            AND (t.campeon = $1 OR t.subcampeon = $1 OR t.tercer_puesto = $1 OR t.cuarto_puesto = $1)
            ORDER BY t.anyo
        """, sel['nombre'])

        palmares_list = []
        campeonatos = 0
        mejor_puesto = None
        puestos_orden = ['🥇 Campeón', '🥈 Subcampeón', '🥉 3er puesto', '4º puesto']

        for p in palmares:
            if p['campeon'] == sel['nombre']:
                palmares_list.append({'anyo': p['anyo'], 'puesto': '🥇 Campeón'})
                campeonatos += 1
            elif p['subcampeon'] == sel['nombre']:
                palmares_list.append({'anyo': p['anyo'], 'puesto': '🥈 Subcampeón'})
            elif p['tercer_puesto'] == sel['nombre']:
                palmares_list.append({'anyo': p['anyo'], 'puesto': '🥉 3er puesto'})
            elif p['cuarto_puesto'] == sel['nombre']:
                palmares_list.append({'anyo': p['anyo'], 'puesto': '4º puesto'})

        for puesto in puestos_orden:
            if any(p['puesto'] == puesto for p in palmares_list):
                mejor_puesto = puesto
                break

    # Resultado por mundial - basado en la última fase donde aparece
        mundiales_con_resultado = []
        for part in participaciones:
            anyo_part = part['anyo']
            pais_sede = part['pais_sede']

            # Buscar en palmares primero (campeon, sub, 3ro, 4to)
            resultado = None
            for p in palmares_list:
                if p['anyo'] == anyo_part:
                    resultado = p['puesto']
                    break

            if resultado is None:
                # Buscar la última fase donde aparece la selección
                ultima_fase = await conn.fetchrow("""
                    SELECT f.nombre, f.orden
                    FROM partidos p
                    JOIN torneos t ON t.id = p.torneo_id
                    JOIN fases f ON f.id = p.fase_id
                    WHERE t.anyo = $1
                    AND (p.seleccion_local_id = $2 OR p.seleccion_visitante_id = $2)
                    AND p.goles_local IS NOT NULL
                    ORDER BY f.orden DESC
                    LIMIT 1
                """, anyo_part, sel_id)

                if ultima_fase:
                    fn = ultima_fase['nombre'].lower()
                    if 'semi' in fn:
                        resultado = 'Semifinales'
                    elif 'quarter' in fn:
                        resultado = 'Cuartos de final'
                    elif 'round of 16' in fn:
                        resultado = 'Octavos de final'
                    elif 'second round' in fn:
                        resultado = '2ª Ronda'
                    elif 'first round' in fn:
                        resultado = '1ª Ronda'
                    elif 'play-off' in fn:
                        resultado = 'Play-off'
                    else:
                        resultado = 'Fase de grupos'
                else:
                    resultado = 'Fase de grupos'

            mundiales_con_resultado.append({
                'anyo': anyo_part,
                'pais_sede': pais_sede,
                'resultado': resultado,
            })

    result = {
        'id': sel['id'],
        'nombre': sel['nombre'],
        'codigo_fifa': sel['codigo_fifa'],
        'confederacion': sel['confederacion'],
        'grupo': grupo,
        'participaciones': len(participaciones),
        'ultima_participacion': participaciones[0]['anyo'] if participaciones else None,
        'mejor_puesto': mejor_puesto,
        'campeonatos': campeonatos,
        'palmares': palmares_list,
        'stats': stats,
        'mejor_rival': mejor_rival,
        'peor_rival': peor_rival,
        'mayor_goleada_dada': {k: v for k, v in mayor_goleada_dada.items() if k != 'diff'} if mayor_goleada_dada else None,
        'mayor_goleada_recibida': {k: v for k, v in mayor_goleada_recibida.items() if k != 'diff'} if mayor_goleada_recibida else None,
        'mundiales': mundiales_con_resultado,
    }
    cache.set(key, result, TTL_SELECCIONES)
    return result
