"""
corregir_horas.py
Recalcula hora_espana y fecha_espana de todos los partidos del Mundial 2026
usando los timestamps UTC de los JSON de Sofascore.
"""
import psycopg2
import json
import glob
import logging
from datetime import datetime, timezone, timedelta
from dotenv import load_dotenv
import os

load_dotenv()
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
log = logging.getLogger(__name__)

ESPANA = timezone(timedelta(hours=2))

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", 5432),
        dbname=os.getenv("DB_NAME", "mundial"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", ""),
    )

def cargar_eventos():
    archivos = sorted(glob.glob("sofascore_page*.json"))
    todos = []
    for archivo in archivos:
        with open(archivo, encoding="utf-8") as f:
            data = json.load(f)
        todos.extend(data.get("events", []))
    log.info(f"Total eventos: {len(todos)}")
    return todos

def main():
    eventos = cargar_eventos()
    conn = get_db()
    cur = conn.cursor()
    actualizados = 0

    for evento in eventos:
        sofa_id = str(evento.get("id"))
        ts = evento.get("startTimestamp", 0)
        if not ts:
            continue

        dt_utc = datetime.fromtimestamp(ts, tz=timezone.utc)
        dt_espana = dt_utc.astimezone(ESPANA)

        fecha_espana = dt_espana.date()
        hora_espana = dt_espana.strftime("%H:%M:%S")

        cur.execute(
            "SELECT id FROM partidos WHERE sofascore_id = %s",
            (sofa_id,)
        )
        row = cur.fetchone()
        if not row:
            continue

        partido_id = row[0]
        cur.execute(
            "UPDATE partidos SET hora_espana = %s, fecha_espana = %s WHERE id = %s",
            (hora_espana, fecha_espana, partido_id)
        )
        actualizados += 1
        log.info(f"  Partido {partido_id}: fecha_espana={fecha_espana} hora_espana={hora_espana}")

    conn.commit()
    conn.close()
    log.info(f"Actualizados: {actualizados} partidos")

if __name__ == "__main__":
    main()
