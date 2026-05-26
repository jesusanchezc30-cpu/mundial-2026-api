"""
scraper_historico.py v2
=======================
Extrae partidos históricos de todos los Mundiales desde Wikipedia.
"""

import psycopg2
import requests
from bs4 import BeautifulSoup
import re
import logging
import time
from datetime import datetime
from dotenv import load_dotenv
import os

load_dotenv()
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
log = logging.getLogger(__name__)

HEADERS = {"User-Agent": "Mozilla/5.0 (compatible; MundialBot/1.0)"}

MUNDIALES = {
    1930: "https://en.wikipedia.org/wiki/1930_FIFA_World_Cup",
    1934: "https://en.wikipedia.org/wiki/1934_FIFA_World_Cup",
    1938: "https://en.wikipedia.org/wiki/1938_FIFA_World_Cup",
    1950: "https://en.wikipedia.org/wiki/1950_FIFA_World_Cup",
    1954: "https://en.wikipedia.org/wiki/1954_FIFA_World_Cup",
    1958: "https://en.wikipedia.org/wiki/1958_FIFA_World_Cup",
    1962: "https://en.wikipedia.org/wiki/1962_FIFA_World_Cup",
    1966: "https://en.wikipedia.org/wiki/1966_FIFA_World_Cup",
    1970: "https://en.wikipedia.org/wiki/1970_FIFA_World_Cup",
    1974: "https://en.wikipedia.org/wiki/1974_FIFA_World_Cup",
    1978: "https://en.wikipedia.org/wiki/1978_FIFA_World_Cup",
    1982: "https://en.wikipedia.org/wiki/1982_FIFA_World_Cup",
    1986: "https://en.wikipedia.org/wiki/1986_FIFA_World_Cup",
    1990: "https://en.wikipedia.org/wiki/1990_FIFA_World_Cup",
    1994: "https://en.wikipedia.org/wiki/1994_FIFA_World_Cup",
    1998: "https://en.wikipedia.org/wiki/1998_FIFA_World_Cup",
    2002: "https://en.wikipedia.org/wiki/2002_FIFA_World_Cup",
    2006: "https://en.wikipedia.org/wiki/2006_FIFA_World_Cup",
    2010: "https://en.wikipedia.org/wiki/2010_FIFA_World_Cup",
    2014: "https://en.wikipedia.org/wiki/2014_FIFA_World_Cup",
    2018: "https://en.wikipedia.org/wiki/2018_FIFA_World_Cup",
    2022: "https://en.wikipedia.org/wiki/2022_FIFA_World_Cup",
}

SCORE_RE = re.compile(r'(\d+)\s*[–\-−]\s*(\d+)')
DATE_RE = re.compile(r'(\d{1,2})\s+(January|February|March|April|May|June|July|August|September|October|November|December)\s+(\d{4})')
MONTHS = {'January':1,'February':2,'March':3,'April':4,'May':5,'June':6,
          'July':7,'August':8,'September':9,'October':10,'November':11,'December':12}

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=int(os.getenv("DB_PORT", 5432)),
        dbname=os.getenv("DB_NAME", "mundial"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", ""),
    )

def get_or_create_seleccion(cur, nombre):
    nombre = nombre.strip()
    if not nombre or len(nombre) < 2:
        return None
    cur.execute("SELECT id FROM selecciones WHERE LOWER(nombre) = LOWER(%s)", (nombre,))
    row = cur.fetchone()
    if row:
        return row[0]
    cur.execute("INSERT INTO selecciones (nombre) VALUES (%s) RETURNING id", (nombre,))
    return cur.fetchone()[0]

def get_or_create_fase(cur, torneo_id, nombre, orden):
    cur.execute("SELECT id FROM fases WHERE torneo_id = %s AND nombre = %s", (torneo_id, nombre))
    row = cur.fetchone()
    if row:
        return row[0]
    cur.execute(
        "INSERT INTO fases (torneo_id, nombre, orden) VALUES (%s, %s, %s) RETURNING id",
        (torneo_id, nombre, orden)
    )
    return cur.fetchone()[0]

def parse_score(text):
    text = text.strip()
    hubo_prorroga = bool(re.search(r'a\.?e\.?t|extra time|after extra', text, re.I))
    hubo_penaltis = bool(re.search(r'pen\.?|penalty|penalties', text, re.I))
    
    pen_local = pen_visitante = None
    pen_match = re.search(r'\((\d+)\s*[–\-−]\s*(\d+)\s*(?:on\s*)?p', text, re.I)
    if pen_match:
        pen_local = int(pen_match.group(1))
        pen_visitante = int(pen_match.group(2))
    
    m = SCORE_RE.search(text)
    if m:
        return int(m.group(1)), int(m.group(2)), hubo_prorroga, hubo_penaltis, pen_local, pen_visitante
    return None, None, False, False, None, None

def parse_date(text):
    m = DATE_RE.search(text)
    if m:
        try:
            return datetime(int(m.group(3)), MONTHS[m.group(2)], int(m.group(1))).date()
        except:
            pass
    return None

def is_team_name(text):
    """Verifica que el texto parece un nombre de selección."""
    text = text.strip()
    if len(text) < 2 or len(text) > 50:
        return False
    if re.match(r'^\d', text):
        return False
    if re.search(r'\d{4}', text):
        return False
    bad_words = ['group', 'round', 'match', 'venue', 'date', 'referee', 'attendance', 'stadium']
    if any(w in text.lower() for w in bad_words):
        return False
    return True

def scrape_con_infoboxes(soup, torneo_id, conn):
    """Extrae partidos usando las infoboxes de partido de Wikipedia."""
    cur = conn.cursor()
    insertados = 0
    fase_id = None
    fase_orden = 1
    fase_nombre = "Desconocida"

    contenido = soup.find('div', id='mw-content-text')
    if not contenido:
        return 0

    elementos = contenido.find_all(['h2', 'h3', 'h4', 'table', 'div'])

    for elem in elementos:
        # Detectar fase por headings
        if elem.name in ['h2', 'h3', 'h4']:
            texto = elem.get_text(strip=True).replace('[edit]', '').strip()
            if any(k in texto.lower() for k in [
                'group', 'round', 'quarter', 'semi', 'final', 'third', 'knockout',
                'pool', 'first round', 'second round', 'play-off'
            ]):
                fase_nombre = texto
                fase_id = get_or_create_fase(cur, torneo_id, texto, fase_orden)
                fase_orden += 1

        # Detectar tablas de partidos
        if elem.name == 'table' and fase_id:
            filas = elem.find_all('tr')
            fecha_actual = None

            for fila in filas:
                texto_fila = fila.get_text(' ', strip=True)

                # Intentar extraer fecha de la fila
                d = parse_date(texto_fila)
                if d:
                    fecha_actual = d

                celdas = fila.find_all(['td', 'th'])
                if len(celdas) < 3:
                    continue

                textos = [c.get_text(' ', strip=True) for c in celdas]

                # Buscar patrón equipo - marcador - equipo en las celdas
                for i, texto in enumerate(textos):
                    if SCORE_RE.search(texto):
                        # El marcador está en esta celda
                        # Buscar equipo local (celda anterior)
                        local = None
                        visitante = None

                        for j in range(i-1, max(i-4, -1), -1):
                            if is_team_name(textos[j]):
                                local = textos[j].strip()
                                break

                        for j in range(i+1, min(i+4, len(textos))):
                            if is_team_name(textos[j]):
                                visitante = textos[j].strip()
                                break

                        if not local or not visitante or local == visitante:
                            continue

                        gl, gv, prorroga, penaltis, pl, pv = parse_score(texto)
                        if gl is None:
                            continue

                        local_id = get_or_create_seleccion(cur, local)
                        visitante_id = get_or_create_seleccion(cur, visitante)
                        if not local_id or not visitante_id:
                            continue

                        # Evitar duplicados
                        cur.execute("""
                            SELECT id FROM partidos
                            WHERE torneo_id=%s AND seleccion_local_id=%s
                            AND seleccion_visitante_id=%s AND fase_id=%s
                        """, (torneo_id, local_id, visitante_id, fase_id))
                        if cur.fetchone():
                            break

                        cur.execute("""
                            INSERT INTO partidos (
                                torneo_id, fase_id, seleccion_local_id, seleccion_visitante_id,
                                fecha, goles_local, goles_visitante,
                                hubo_prorroga, hubo_penaltis, penaltis_local, penaltis_visitante,
                                estado
                            ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,'finalizado')
                        """, (torneo_id, fase_id, local_id, visitante_id,
                              fecha_actual, gl, gv, prorroga, penaltis, pl, pv))
                        insertados += 1
                        log.debug(f"    {local} {gl}-{gv} {visitante}")
                        break

    conn.commit()
    return insertados

def scrape_mundial(anyo, url, torneo_id, conn):
    log.info(f"Scrapeando Mundial {anyo}...")
    cur = conn.cursor()

    cur.execute("SELECT COUNT(*) FROM partidos WHERE torneo_id = %s", (torneo_id,))
    if cur.fetchone()[0] > 0:
        log.info(f"  Mundial {anyo} ya tiene partidos, saltando...")
        return 0

    try:
        resp = requests.get(url, headers=HEADERS, timeout=20)
        resp.raise_for_status()
    except Exception as e:
        log.error(f"  Error: {e}")
        return 0

    soup = BeautifulSoup(resp.text, 'html.parser')
    n = scrape_con_infoboxes(soup, torneo_id, conn)
    log.info(f"  Mundial {anyo}: {n} partidos insertados")
    return n

def main():
    conn = get_db()
    cur = conn.cursor()
    total = 0

    for anyo, url in MUNDIALES.items():
        cur.execute("SELECT id FROM torneos WHERE anyo = %s", (anyo,))
        row = cur.fetchone()
        if not row:
            log.warning(f"No hay torneo para {anyo}")
            continue
        n = scrape_mundial(anyo, url, row[0], conn)
        total += n
        time.sleep(1)

    conn.close()
    log.info(f"TOTAL: {total} partidos históricos insertados")

if __name__ == "__main__":
    main()
