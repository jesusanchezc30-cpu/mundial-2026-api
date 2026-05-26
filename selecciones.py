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
            SELECT s.id, s.nombre, s.codigo_fifa, s.confederacion, s.grupo
            FROM selecciones s
            JOIN partidos p ON p.seleccion_local_id = s.id OR p.seleccion_visitante_id = s.id
            JOIN torneos t ON t.id = p.torneo_id
            WHERE t.anyo = 2026
            GROUP BY s.id, s.nombre, s.codigo_fifa, s.confederacion, s.grupo
            ORDER BY s.grupo, s.nombre
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

        # Participaciones en mundiales
        participaciones = await conn.fetch("""
            SELECT DISTINCT t.anyo, t.pais_sede
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            WHERE (p.seleccion_local_id = $1 OR p.seleccion_visitante_id = $1)
            AND t.anyo < 2026
            ORDER BY t.anyo DESC
        """, sel_id)

        # Todos los partidos históricos
        partidos = await conn.fetch("""
            SELECT p.goles_local, p.goles_visitante,
                   p.seleccion_local_id, p.seleccion_visitante_id,
                   sv.nombre AS rival_nombre,
                   sl.nombre AS local_nombre,
                   f.nombre AS fase,
                   t.anyo
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            JOIN fases f ON f.id = p.fase_id
            LEFT JOIN selecciones sl ON sl.id = p.seleccion_local_id
            LEFT JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
            WHERE (p.seleccion_local_id = $1 OR p.seleccion_visitante_id = $1)
            AND t.anyo < 2026
            AND p.goles_local IS NOT NULL
        """, sel_id)

        # Calcular estadísticas
        stats = {
            'pj': 0, 'pg': 0, 'pe': 0, 'pp': 0,
            'gf': 0, 'gc': 0,
        }
        rivales = {}
        mayor_goleada_dada = None
        mayor_goleada_recibida = None
        mejor_puesto = None
        campeonatos = 0

        for p in partidos:
            es_local = p['seleccion_local_id'] == sel_id
            gf = p['goles_local'] if es_local else p['goles_visitante']
            gc = p['goles_visitante'] if es_local else p['goles_local']
            rival = p['sv_nombre'] if es_local else p['local_nombre'] if not es_local else None
            # Fix: obtener rival correctamente
            if es_local:
                rival_id_field = 'seleccion_visitante_id'
                rival = p['rival_nombre'] if p['seleccion_visitante_id'] != sel_id else p['local_nombre']
            else:
                rival = p['local_nombre']

            stats['pj'] += 1
            stats['gf'] += gf
            stats['gc'] += gc

            if gf > gc:
                stats['pg'] += 1
            elif gf == gc:
                stats['pe'] += 1
            else:
                stats['pp'] += 1

            # Rival stats
            if rival and rival != sel['nombre']:
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
            diff = gf - gc
            if gf > gc:
                if mayor_goleada_dada is None or diff > mayor_goleada_dada['diff']:
                    mayor_goleada_dada = {
                        'resultado': f'{gf}-{gc}',
                        'rival': rival,
                        'anyo': p['anyo'],
                        'diff': diff,
                    }

            # Mayor goleada recibida
            if gc > gf:
                diff_rec = gc - gf
                if mayor_goleada_recibida is None or diff_rec > mayor_goleada_recibida['diff']:
                    mayor_goleada_recibida = {
                        'resultado': f'{gc}-{gf}',
                        'rival': rival,
                        'anyo': p['anyo'],
                        'diff': diff_rec,
                    }

        # Mejor rival (más victorias)
        mejor_rival = None
        peor_rival = None
        if rivales:
            # Necesitamos al menos 2 partidos contra el rival
            rivales_filtrados = {k: v for k, v in rivales.items() if v['pj'] >= 2}
            if rivales_filtrados:
                mejor_rival = max(rivales_filtrados.items(),
                    key=lambda x: (x[1]['pg'], -x[1]['pp']))[0]
                peor_rival = max(rivales_filtrados.items(),
                    key=lambda x: (x[1]['pp'], -x[1]['pg']))[0]

        # Mejor puesto en mundiales (palmares)
        palmares = await conn.fetch("""
            SELECT t.anyo, t.campeon, t.subcampeon, t.tercer_puesto, t.cuarto_puesto
            FROM torneos t
            WHERE t.anyo < 2026
            AND (t.campeon = $1 OR t.subcampeon = $1 OR t.tercer_puesto = $1 OR t.cuarto_puesto = $1)
            ORDER BY t.anyo
        """, sel['nombre'])

        palmares_list = []
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

        # Mejor puesto
        puestos_orden = ['🥇 Campeón', '🥈 Subcampeón', '🥉 3er puesto', '4º puesto']
        if palmares_list:
            for puesto in puestos_orden:
                if any(p['puesto'] == puesto for p in palmares_list):
                    mejor_puesto = puesto
                    break

    result = {
        'id': sel['id'],
        'nombre': sel['nombre'],
        'codigo_fifa': sel['codigo_fifa'],
        'confederacion': sel['confederacion'],
        'grupo': sel['grupo'],
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
        'mundiales': [dict(p) for p in participaciones],
    }
    cache.set(key, result, TTL_SELECCIONES)
    return result
