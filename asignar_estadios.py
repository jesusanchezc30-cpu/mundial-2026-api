"""
asignar_estadios.py
Asigna estadios a los partidos que no lo tienen usando los JSONs de Sofascore.
"""
import psycopg2
import json
import glob
import logging
from dotenv import load_dotenv
import os

load_dotenv()
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
log = logging.getLogger(__name__)

# Mapeo nombre estadio Sofascore -> id en nuestra BD
ESTADIO_MAP = {
    'MetLife Stadium': 1,
    'SoFi Stadium': 2,
    'AT&T Stadium': 3,
    "Levi's Stadium": 4,
    'Hard Rock Stadium': 5,
    'Gillette Stadium': 6,
    'Lincoln Financial Field': 7,
    'Arrowhead Stadium': 8,
    'Lumen Field': 9,
    'Estadio Azteca': 11,
    'Estadio BBVA': 12,
    'Estadio Akron': 13,
    'BC Place': 14,
    'BMO Field': 15,
    'NRG Stadium': 17,
    'Mercedes-Benz Stadium': 18,
}

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=int(os.getenv("DB_PORT", 5432)),
        dbname=os.getenv("DB_NAME", "mundial"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", ""),
    )

def main():
    archivos = sorted(glob.glob("sofascore_page*.json"))
    eventos = []
    for archivo in archivos:
        with open(archivo, encoding="utf-8") as f:
            data = json.load(f)
        eventos.extend(data.get("events", []))
    
    log.info(f"Total eventos: {len(eventos)}")
    
    conn = get_db()
    cur = conn.cursor()
    actualizados = 0

    for evento in eventos:
        sofa_id = str(evento.get("id"))
        venue = evento.get("venue", {})
        if not venue:
            continue
        
        nombre_estadio = venue.get("name", "")
        estadio_id = ESTADIO_MAP.get(nombre_estadio)
        
        if not estadio_id:
            log.warning(f"  Estadio no mapeado: '{nombre_estadio}' (sofa_id={sofa_id})")
            continue

        cur.execute(
            "SELECT id, estadio_id FROM partidos WHERE sofascore_id = %s",
            (sofa_id,)
        )
        row = cur.fetchone()
        if not row:
            continue
        
        partido_id, estadio_actual = row
        if estadio_actual is None:
            cur.execute(
                "UPDATE partidos SET estadio_id = %s WHERE id = %s",
                (estadio_id, partido_id)
            )
            actualizados += 1
            log.info(f"  Partido {partido_id}: estadio -> {nombre_estadio}")

    conn.commit()
    conn.close()
    log.info(f"Actualizados: {actualizados} partidos")

if __name__ == "__main__":
    main()
