"""
scraper_sofascore.py
====================
Scraper de datos en vivo del Mundial 2026 desde Sofascore.
Usa la API interna JSON de Sofascore (no scraping de HTML).

Que recoge:
- Resultado en vivo (marcador + minuto)
- Eventos: goles, tarjetas, sustituciones, penaltis
- Estadisticas: posesion, tiros, corners, faltas
- Alineaciones iniciales

Uso:
    python scraper_sofascore.py --buscar-torneo   # encontrar ID del Mundial 2026
    python scraper_sofascore.py --hoy             # scrape partidos de hoy
    python scraper_sofascore.py --live            # scrape solo partidos en curso
    python scraper_sofascore.py --partido 12345   # scrape un partido concreto
    python scraper_sofascore.py --daemon          # modo continuo cada 2 min
"""

import requests
import psycopg2
import psycopg2.extras
import time
import json
import argparse
import logging
from datetime import datetime, date
from dotenv import load_dotenv
import os

load_dotenv()
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
log = logging.getLogger(__name__)

# ------------------------------------------------------------------
# CONFIGURACION
# ------------------------------------------------------------------

BASE_URL = "https://www.sofascore.com/api/v1"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Accept": "application/json",
    "Accept-Language": "es-ES,es;q=0.9",
    "Referer": "https://www.sofascore.com/",
    "Origin": "https://www.sofascore.com",
}

DELAY = 3  # segundos entre peticiones
DELAY_DAEMON = 120  # segundos entre ciclos en modo daemon

# ID del torneo FIFA World Cup 2026 en Sofascore
# Se obtiene con --buscar-torneo la primera vez
SOFASCORE_TORNEO_ID = None  # Se rellena tras buscar


# ------------------------------------------------------------------
# CONEXION BD
# ------------------------------------------------------------------

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", 5432),
        dbname=os.getenv("DB_NAME", "mundial"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", ""),
    )


# ------------------------------------------------------------------
# CLIENTE SOFASCORE
# ------------------------------------------------------------------

def get_json(endpoint: str, reintentos: int = 3) -> dict | None:
    """Llama a un endpoint de la API de Sofascore y devuelve JSON."""
    url = f"{BASE_URL}{endpoint}"
    for i in range(reintentos):
        try:
            r = requests.get(url, headers=HEADERS, timeout=15)
            if r.status_code == 429:
                log.warning("Rate limit (429). Esperando 30s...")
                time.sleep(30)
                continue
            if r.status_code == 404:
                log.debug(f"404 en {url}")
                return None
            r.raise_for_status()
            time.sleep(DELAY)
            return r.json()
        except requests.RequestException as e:
            log.warning(f"Intento {i+1}/{reintentos} fallido ({url}): {e}")
            time.sleep(DELAY * (i + 1))
    log.error(f"Fallo definitivo: {url}")
    return None


# ------------------------------------------------------------------
# BUSCAR ID DEL MUNDIAL 2026 EN SOFASCORE
# ------------------------------------------------------------------

def buscar_torneo_mundial():
    """
    Busca el ID del Mundial 2026 en Sofascore.
    Ejecutar una sola vez para obtener el ID y guardarlo en .env
    """
    log.info("Buscando FIFA World Cup 2026 en Sofascore...")

    # Buscar por nombre
    data = get_json("/search/all?q=FIFA+World+Cup+2026")
    if not data:
        log.error("No se pudo buscar")
        return

    # Mostrar resultados de torneos
    for resultado in data.get("results", []):
        if resultado.get("type") == "uniqueTournament":
            ent = resultado.get("entity", {})
            log.info(f"Torneo: ID={ent.get('id')} | Nombre={ent.get('name')}")

    # Alternativa: buscar en categorias de futbol
    log.info("\nBuscando en categorias de futbol internacional...")
    data2 = get_json("/sport/football/categories")
    if data2:
        for cat in data2.get("categories", []):
            if "international" in cat.get("name", "").lower() or cat.get("id") == 1:
                log.info(f"Categoria: ID={cat.get('id')} | Nombre={cat.get('name')}")

    log.info("\nNota: Anota el ID del torneo y guardalo en .env como SOFASCORE_TORNEO_ID=XXXXX")


def buscar_partidos_mundial_hoy(torneo_id: int, fecha: str = None) -> list:
    """
    Obtiene los partidos del Mundial para una fecha dada.
    fecha formato: YYYY-MM-DD (por defecto hoy)
    """
    if not fecha:
        fecha = date.today().isoformat()

    log.info(f"Buscando partidos del Mundial {fecha} en Sofascore...")

    # Endpoint: partidos por deporte y fecha
    data = get_json(f"/sport/football/scheduled-events/{fecha}")
    if not data:
        return []

    partidos_mundial = []
    for evento in data.get("events", []):
        # Filtrar solo partidos del Mundial 2026
        torneo = evento.get("tournament", {})
        unique = torneo.get("uniqueTournament", {})
        if unique.get("id") == torneo_id or "world cup" in unique.get("name", "").lower():
            partidos_mundial.append(evento)
            log.info(f"  Partido encontrado: ID={evento.get('id')} | "
                     f"{evento.get('homeTeam', {}).get('name')} vs "
                     f"{evento.get('awayTeam', {}).get('name')}")

    log.info(f"Total partidos Mundial hoy: {len(partidos_mundial)}")
    return partidos_mundial


def buscar_partidos_live(torneo_id: int) -> list:
    """Obtiene los partidos del Mundial que estan en curso ahora mismo."""
    log.info("Buscando partidos en vivo...")
    data = get_json("/sport/football/events/live")
    if not data:
        return []

    partidos_live = []
    for evento in data.get("events", []):
        torneo = evento.get("tournament", {})
        unique = torneo.get("uniqueTournament", {})
        if unique.get("id") == torneo_id or "world cup" in unique.get("name", "").lower():
            partidos_live.append(evento)
            log.info(f"  EN VIVO: {evento.get('homeTeam', {}).get('name')} "
                     f"{evento.get('homeScore', {}).get('current', 0)}-"
                     f"{evento.get('awayScore', {}).get('current', 0)} "
                     f"{evento.get('awayTeam', {}).get('name')} "
                     f"(min {evento.get('time', {}).get('played', '?')})")

    return partidos_live


# ------------------------------------------------------------------
# SCRAPING DE DATOS DE UN PARTIDO
# ------------------------------------------------------------------

def scrape_partido_completo(sofascore_id: int) -> dict:
    """
    Recoge todos los datos disponibles de un partido en Sofascore.
    Devuelve un dict con resultado, eventos y estadisticas.
    """
    resultado = {"sofascore_id": sofascore_id}

    # 1. Datos basicos del partido
    data = get_json(f"/event/{sofascore_id}")
    if not data:
        return resultado

    evento = data.get("event", {})
    resultado["estado_sofascore"] = evento.get("status", {}).get("type", "")
    resultado["minuto"] = evento.get("time", {}).get("played")
    resultado["goles_local"] = evento.get("homeScore", {}).get("current")
    resultado["goles_visitante"] = evento.get("awayScore", {}).get("current")
    resultado["goles_local_et"] = evento.get("homeScore", {}).get("extra")
    resultado["goles_visitante_et"] = evento.get("awayScore", {}).get("extra")
    resultado["penaltis_local"] = evento.get("homeScore", {}).get("penalties")
    resultado["penaltis_visitante"] = evento.get("awayScore", {}).get("penalties")
    resultado["asistencia"] = evento.get("attendance")
    resultado["arbitro"] = evento.get("referee", {}).get("name")

    # Mapear estado
    estado_map = {
        "inprogress": "en_curso",
        "finished": "finalizado",
        "notstarted": "pendiente",
        "postponed": "aplazado",
        "canceled": "cancelado",
    }
    resultado["estado"] = estado_map.get(resultado["estado_sofascore"], "pendiente")

    log.info(f"  [{sofascore_id}] Estado: {resultado['estado']} | "
             f"Resultado: {resultado.get('goles_local')}-{resultado.get('goles_visitante')} "
             f"(min {resultado.get('minuto')})")

    # 2. Eventos del partido (goles, tarjetas, sustituciones)
    data_eventos = get_json(f"/event/{sofascore_id}/incidents")
    if data_eventos:
        resultado["eventos"] = parsear_eventos(data_eventos.get("incidents", []))
        log.info(f"  [{sofascore_id}] {len(resultado['eventos'])} eventos")

    # 3. Estadisticas
    data_stats = get_json(f"/event/{sofascore_id}/statistics")
    if data_stats:
        resultado["estadisticas"] = parsear_estadisticas(data_stats.get("statistics", []))
        log.info(f"  [{sofascore_id}] Estadisticas OK")

    return resultado


def parsear_eventos(incidents: list) -> list:
    """Convierte los incidents de Sofascore a nuestro formato de eventos."""
    eventos = []
    for inc in incidents:
        tipo_sofa = inc.get("incidentType", "")
        tipo = None

        if tipo_sofa == "goal":
            tipo_detalle = inc.get("incidentClass", "")
            if tipo_detalle == "penalty":
                tipo = "gol_penalti"
            elif tipo_detalle == "ownGoal":
                tipo = "gol_propia"
            else:
                tipo = "gol"
        elif tipo_sofa == "card":
            color = inc.get("incidentClass", "")
            if color == "yellow":
                tipo = "tarjeta_amarilla"
            elif color == "red":
                tipo = "tarjeta_roja"
            elif color == "yellowRed":
                tipo = "tarjeta_amarilla_roja"
        elif tipo_sofa == "substitution":
            tipo = "sustitucion"
        elif tipo_sofa == "missedPenalty":
            tipo = "penalti_fallado"
        elif tipo_sofa == "varDecision":
            tipo = "var"

        if not tipo:
            continue

        eventos.append({
            "tipo": tipo,
            "minuto": inc.get("time", 0),
            "minuto_adicional": inc.get("addedTime", 0),
            "jugador_nombre": inc.get("player", {}).get("name"),
            "jugador_sofa_id": inc.get("player", {}).get("id"),
            "jugador2_nombre": inc.get("playerIn", {}).get("name") or inc.get("assist1", {}).get("name"),
            "jugador2_sofa_id": inc.get("playerIn", {}).get("id") or inc.get("assist1", {}).get("id"),
            "equipo": "local" if inc.get("isHome") else "visitante",
            "descripcion": inc.get("description", ""),
        })

    return eventos


def parsear_estadisticas(statistics: list) -> dict:
    """Extrae estadisticas clave de ambos equipos."""
    stats = {"local": {}, "visitante": {}}

    campos_interes = {
        "Ball possession": "posesion",
        "Total shots": "tiros",
        "Shots on target": "tiros_puerta",
        "Corner kicks": "corners",
        "Fouls": "faltas",
        "Offsides": "fueras_de_juego",
        "Yellow cards": "tarjetas_amarillas",
        "Red cards": "tarjetas_rojas",
        "Passes": "pases",
        "Accurate passes": "pases_completados",
    }

    for periodo in statistics:
        for grupo in periodo.get("groups", []):
            for item in grupo.get("statisticsItems", []):
                nombre = item.get("name", "")
                if nombre in campos_interes:
                    campo = campos_interes[nombre]
                    val_local = item.get("home", "0").replace("%", "").strip()
                    val_visitante = item.get("away", "0").replace("%", "").strip()
                    try:
                        stats["local"][campo] = float(val_local)
                        stats["visitante"][campo] = float(val_visitante)
                    except (ValueError, TypeError):
                        pass

    return stats


# ------------------------------------------------------------------
# GUARDAR EN BASE DE DATOS
# ------------------------------------------------------------------

def guardar_partido(conn, partido_bd_id: int, datos: dict):
    """Actualiza los datos de un partido en la BD."""
    cur = conn.cursor()
    try:
        # Actualizar resultado y estado
        cur.execute("""
            UPDATE partidos SET
                goles_local = %s,
                goles_visitante = %s,
                goles_local_prorroga = %s,
                goles_visitante_prorroga = %s,
                penaltis_local = %s,
                penaltis_visitante = %s,
                estado = %s,
                minuto_actual = %s,
                asistencia = COALESCE(%s, asistencia),
                arbitro = COALESCE(%s, arbitro),
                updated_at = NOW()
            WHERE id = %s
        """, (
            datos.get("goles_local"),
            datos.get("goles_visitante"),
            datos.get("goles_local_et"),
            datos.get("goles_visitante_et"),
            datos.get("penaltis_local"),
            datos.get("penaltis_visitante"),
            datos.get("estado", "pendiente"),
            datos.get("minuto"),
            datos.get("asistencia"),
            datos.get("arbitro"),
            partido_bd_id,
        ))

        # Guardar eventos (solo los nuevos)
        for ev in datos.get("eventos", []):
            cur.execute("""
                INSERT INTO eventos_partido (partido_id, tipo, minuto, minuto_adicional, descripcion)
                VALUES (%s, %s, %s, %s, %s)
                ON CONFLICT DO NOTHING
            """, (
                partido_bd_id,
                ev["tipo"],
                ev["minuto"],
                ev.get("minuto_adicional", 0),
                ev.get("descripcion", ""),
            ))

        # Guardar estadisticas
        stats = datos.get("estadisticas", {})
        for lado, seleccion_tipo in [("local", "local"), ("visitante", "visitante")]:
            s = stats.get(lado, {})
            if s:
                cur.execute("""
                    INSERT INTO estadisticas_partido (
                        partido_id, seleccion_id,
                        posesion, tiros, tiros_puerta, corners,
                        faltas, fueras_de_juego, tarjetas_amarillas, tarjetas_rojas,
                        pases, pases_completados)
                    SELECT %s,
                        CASE WHEN %s = 'local' THEN seleccion_local_id
                             ELSE seleccion_visitante_id END,
                        %s,%s,%s,%s,%s,%s,%s,%s,%s,%s
                    FROM partidos WHERE id = %s
                    ON CONFLICT (partido_id, seleccion_id) DO UPDATE SET
                        posesion = EXCLUDED.posesion,
                        tiros = EXCLUDED.tiros,
                        tiros_puerta = EXCLUDED.tiros_puerta,
                        corners = EXCLUDED.corners,
                        faltas = EXCLUDED.faltas,
                        fueras_de_juego = EXCLUDED.fueras_de_juego,
                        pases = EXCLUDED.pases,
                        pases_completados = EXCLUDED.pases_completados
                """, (
                    partido_bd_id, lado,
                    s.get("posesion"), s.get("tiros"), s.get("tiros_puerta"),
                    s.get("corners"), s.get("faltas"), s.get("fueras_de_juego"),
                    s.get("tarjetas_amarillas"), s.get("tarjetas_rojas"),
                    s.get("pases"), s.get("pases_completados"),
                    partido_bd_id,
                ))

        conn.commit()
        log.info(f"  Partido {partido_bd_id} guardado en BD")

    except Exception as e:
        log.error(f"Error guardando partido {partido_bd_id}: {e}", exc_info=True)
        conn.rollback()
    finally:
        cur.close()


def obtener_partido_bd(conn, sofascore_id: int) -> int | None:
    """Busca el partido en nuestra BD por sofascore_id. Devuelve el ID interno."""
    cur = conn.cursor()
    cur.execute("SELECT id FROM partidos WHERE sofascore_id = %s", (str(sofascore_id),))
    row = cur.fetchone()
    cur.close()
    return row[0] if row else None


def vincular_partido_sofascore(conn, sofascore_evento: dict) -> int | None:
    """
    Intenta vincular un evento de Sofascore con un partido de nuestra BD
    usando el nombre de los equipos y la fecha.
    """
    cur = conn.cursor()
    try:
        local_nombre = sofascore_evento.get("homeTeam", {}).get("name", "")
        visitante_nombre = sofascore_evento.get("awayTeam", {}).get("name", "")
        fecha_ts = sofascore_evento.get("startTimestamp", 0)
        fecha = date.fromtimestamp(fecha_ts) if fecha_ts else date.today()
        sofa_id = sofascore_evento.get("id")

        # Buscar por nombre de equipos y fecha
        cur.execute("""
            SELECT p.id FROM partidos p
            JOIN selecciones sl ON sl.id = p.seleccion_local_id
            JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
            JOIN torneos t ON t.id = p.torneo_id
            WHERE t.anyo = 2026
            AND p.fecha = %s
            AND (sl.nombre ILIKE %s OR sl.nombre ILIKE %s)
            AND (sv.nombre ILIKE %s OR sv.nombre ILIKE %s)
            LIMIT 1
        """, (
            fecha,
            f"%{local_nombre[:5]}%", f"%{local_nombre[:5]}%",
            f"%{visitante_nombre[:5]}%", f"%{visitante_nombre[:5]}%",
        ))
        row = cur.fetchone()
        if row:
            partido_id = row[0]
            # Guardar el sofascore_id para futuras consultas
            cur.execute("UPDATE partidos SET sofascore_id = %s WHERE id = %s",
                       (str(sofa_id), partido_id))
            conn.commit()
            log.info(f"  Vinculado: Sofascore {sofa_id} -> BD partido {partido_id}")
            return partido_id
        else:
            log.warning(f"  No encontrado en BD: {local_nombre} vs {visitante_nombre} ({fecha})")
            return None
    finally:
        cur.close()


# ------------------------------------------------------------------
# CICLO PRINCIPAL
# ------------------------------------------------------------------

def ciclo_scraping(conn, torneo_id: int, solo_live: bool = False):
    """Un ciclo completo de scraping: busca partidos y actualiza BD."""
    log.info(f"Iniciando ciclo ({datetime.now().strftime('%H:%M:%S')})")

    if solo_live:
        eventos = buscar_partidos_live(torneo_id)
    else:
        eventos = buscar_partidos_mundial_hoy(torneo_id)

    if not eventos:
        log.info("No hay partidos para scrapear ahora")
        return

    for evento in eventos:
        sofa_id = evento.get("id")
        if not sofa_id:
            continue

        # Buscar o vincular partido en BD
        partido_bd_id = obtener_partido_bd(conn, sofa_id)
        if not partido_bd_id:
            partido_bd_id = vincular_partido_sofascore(conn, evento)
        if not partido_bd_id:
            log.warning(f"No se pudo vincular partido Sofascore {sofa_id}")
            continue

        # Scrape completo
        datos = scrape_partido_completo(sofa_id)
        guardar_partido(conn, partido_bd_id, datos)


# ------------------------------------------------------------------
# MAIN
# ------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(description="Scraper Sofascore - Mundial 2026")
    parser.add_argument("--buscar-torneo", action="store_true",
                        help="Buscar el ID del torneo Mundial 2026 en Sofascore")
    parser.add_argument("--hoy", action="store_true",
                        help="Scrapear partidos de hoy")
    parser.add_argument("--live", action="store_true",
                        help="Scrapear solo partidos en curso")
    parser.add_argument("--partido", type=int,
                        help="Scrapear un partido concreto por ID de Sofascore")
    parser.add_argument("--daemon", action="store_true",
                        help="Modo continuo: scrape cada 2 minutos")
    parser.add_argument("--fecha", type=str,
                        help="Fecha a scrapear YYYY-MM-DD (default: hoy)")
    args = parser.parse_args()

    # Obtener ID del torneo del .env
    torneo_id = int(os.getenv("SOFASCORE_TORNEO_ID", "0"))

    if args.buscar_torneo:
        buscar_torneo_mundial()
        return

    if args.partido:
        datos = scrape_partido_completo(args.partido)
        log.info(json.dumps(datos, indent=2, ensure_ascii=False, default=str))
        return

    if not torneo_id:
        log.error("Necesitas SOFASCORE_TORNEO_ID en el .env")
        log.error("Ejecuta primero: python scraper_sofascore.py --buscar-torneo")
        return

    conn = get_db()
    log.info("Conectado a PostgreSQL")

    try:
        if args.daemon:
            log.info(f"Modo daemon: ciclo cada {DELAY_DAEMON}s")
            while True:
                ciclo_scraping(conn, torneo_id, solo_live=True)
                log.info(f"Esperando {DELAY_DAEMON}s...")
                time.sleep(DELAY_DAEMON)
        elif args.live:
            ciclo_scraping(conn, torneo_id, solo_live=True)
        elif args.hoy or args.fecha:
            eventos = buscar_partidos_mundial_hoy(torneo_id, args.fecha)
            for evento in eventos:
                sofa_id = evento.get("id")
                partido_bd_id = obtener_partido_bd(conn, sofa_id)
                if not partido_bd_id:
                    partido_bd_id = vincular_partido_sofascore(conn, evento)
                if partido_bd_id:
                    datos = scrape_partido_completo(sofa_id)
                    guardar_partido(conn, partido_bd_id, datos)
        else:
            parser.print_help()
    finally:
        conn.close()


if __name__ == "__main__":
    main()
