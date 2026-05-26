"""
vincular_sofascore.py
=====================
Vincula los IDs de Sofascore con los partidos del Mundial 2026 en BD.
Lee los JSON descargados manualmente desde el navegador.

Uso:
    python vincular_sofascore.py --dry-run
    python vincular_sofascore.py
"""

import psycopg2
import json
import argparse
import logging
from datetime import datetime, timezone, timedelta
from dotenv import load_dotenv
import os
import glob

load_dotenv()
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
log = logging.getLogger(__name__)

# Normalizacion de nombres Sofascore -> nuestros nombres en BD
NOMBRE_MAP = {
    "Bosnia & Herzegovina": "Bosnia Herzegovina",
    "Cote d'Ivoire": "Ivory Coast",
    "Cote d'Ivoire": "Ivory Coast",
    "Cabo Verde": "Cape Verde",
    "Turkiye": "Turkey",
    "Turkiye": "Turkey",
    "Curacao": "Curacao",
}

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", 5432),
        dbname=os.getenv("DB_NAME", "mundial"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", ""),
    )

def normalizar(nombre):
    # Limpiar caracteres especiales
    nombre = nombre.replace("\u00e7", "c").replace("\u00f4", "o").replace("\u00fc", "u")
    return NOMBRE_MAP.get(nombre, nombre)

def cargar_eventos_locales():
    archivos = sorted(glob.glob("sofascore_page*.json"))
    if not archivos:
        log.error("No se encontraron archivos sofascore_page*.json")
        return []
    todos = []
    for archivo in archivos:
        try:
            with open(archivo, encoding="utf-8") as f:
                data = json.load(f)
            eventos = data.get("events", [])
            todos.extend(eventos)
            log.info(f"  {archivo}: {len(eventos)} eventos")
        except Exception as e:
            log.error(f"Error leyendo {archivo}: {e}")
    log.info(f"Total eventos cargados: {len(todos)}")
    return todos

def buscar_partido_bd(cur, local_nombre, visitante_nombre, local_code, visitante_code, fecha):
    """Busca partido en BD probando la fecha exacta y +/-1 dia."""
    for delta in [0, -1, 1]:
        fecha_buscar = fecha + timedelta(days=delta)
        cur.execute("""
            SELECT p.id, sl.nombre, sv.nombre
            FROM partidos p
            JOIN torneos t ON t.id = p.torneo_id
            JOIN selecciones sl ON sl.id = p.seleccion_local_id
            JOIN selecciones sv ON sv.id = p.seleccion_visitante_id
            WHERE t.anyo = 2026
            AND p.sofascore_id IS NULL
            AND p.fecha = %s
            AND (
                sl.codigo_fifa = %s
                OR sl.nombre ILIKE %s
                OR sl.nombre = %s
            )
            AND (
                sv.codigo_fifa = %s
                OR sv.nombre ILIKE %s
                OR sv.nombre = %s
            )
            LIMIT 1
        """, (
            fecha_buscar,
            local_code, f"%{local_nombre[:5]}%", local_nombre,
            visitante_code, f"%{visitante_nombre[:5]}%", visitante_nombre,
        ))
        row = cur.fetchone()
        if row:
            return row, delta
    return None, None

def vincular_partido(conn, evento, dry_run=False):
    cur = conn.cursor()
    try:
        sofa_id = str(evento.get("id"))
        local_raw = evento.get("homeTeam", {}).get("name", "")
        visitante_raw = evento.get("awayTeam", {}).get("name", "")
        local_code = evento.get("homeTeam", {}).get("nameCode", "")
        visitante_code = evento.get("awayTeam", {}).get("nameCode", "")
        local_nombre = normalizar(local_raw)
        visitante_nombre = normalizar(visitante_raw)

        timestamp = evento.get("startTimestamp", 0)
        if not timestamp:
            return False

        fecha = datetime.fromtimestamp(timestamp, tz=timezone.utc).date()

        # Saltar partidos TBD (eliminatorias sin equipos definidos)
        if local_code in ("", "TBD") or visitante_code in ("", "TBD"):
            return False
        if len(local_code) > 4 or len(visitante_code) > 4:
            return False

        row, delta = buscar_partido_bd(cur, local_nombre, visitante_nombre,
                                        local_code, visitante_code, fecha)

        if row:
            partido_id, local_bd, visitante_bd = row
            ajuste = f" (fecha +{delta}d)" if delta != 0 else ""
            log.info(f"  OK{ajuste}: {local_nombre} vs {visitante_nombre} ({fecha}) -> Sofa {sofa_id} -> BD {partido_id}")
            if not dry_run:
                cur.execute(
                    "UPDATE partidos SET sofascore_id = %s WHERE id = %s",
                    (sofa_id, partido_id)
                )
                conn.commit()
            return True
        else:
            log.warning(f"  NO ENCONTRADO: {local_nombre} ({local_code}) vs {visitante_nombre} ({visitante_code}) | {fecha}")
            return False

    except Exception as e:
        log.error(f"Error: {e}", exc_info=True)
        conn.rollback()
        return False
    finally:
        cur.close()

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    if args.dry_run:
        log.info("DRY RUN - no se guardara nada en BD")

    eventos = cargar_eventos_locales()
    if not eventos:
        return

    conn = get_db()
    log.info("Conectado a BD.")

    vinculados = 0
    no_encontrados = []

    for evento in eventos:
        ok = vincular_partido(conn, evento, dry_run=args.dry_run)
        if ok:
            vinculados += 1
        else:
            local = evento.get("homeTeam", {}).get("name", "?")
            visit = evento.get("awayTeam", {}).get("name", "?")
            local_code = evento.get("homeTeam", {}).get("nameCode", "")
            if local_code and len(local_code) <= 4 and local_code != "TBD":
                no_encontrados.append(f"{local} vs {visit}")

    conn.close()

    log.info(f"Resultado: {vinculados} vinculados | {len(no_encontrados)} partidos de grupos sin vincular")
    if no_encontrados:
        log.info("Partidos de grupos sin vincular (revisar manualmente):")
        for p in no_encontrados:
            log.info(f"  - {p}")

if __name__ == "__main__":
    main()
