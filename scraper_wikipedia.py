import requests
from bs4 import BeautifulSoup
import psycopg2
import time
import re
import json
import argparse
import logging
from datetime import datetime, date
from dotenv import load_dotenv
import os

load_dotenv()
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
log = logging.getLogger(__name__)

MUNDIALES = [1930,1934,1938,1950,1954,1958,1962,1966,1970,1974,1978,1982,1986,1990,1994,1998,2002,2006,2010,2014,2018,2022]
HEADERS = {"User-Agent": "ProyectoMundial/1.0 (educativo personal)"}
DELAY = 2

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST","localhost"),
        port=os.getenv("DB_PORT",5432),
        dbname=os.getenv("DB_NAME","mundial"),
        user=os.getenv("DB_USER","postgres"),
        password=os.getenv("DB_PASSWORD",""),
    )

def get_soup(url, reintentos=3):
    for i in range(reintentos):
        try:
            r = requests.get(url, headers=HEADERS, timeout=15)
            r.raise_for_status()
            time.sleep(DELAY)
            return BeautifulSoup(r.text, "lxml")
        except Exception as e:
            log.warning(f"Intento {i+1}/{reintentos} fallido: {e}")
            time.sleep(DELAY * (i+1))
    return None

def limpiar(texto):
    if not texto:
        return ""
    texto = re.sub(r'\[\d+\]', '', texto)
    return re.sub(r'\s+', ' ', texto).strip()

def extraer_int(texto):
    if not texto:
        return None
    nums = re.findall(r'[\d]+', texto.replace(',',''))
    return int(nums[0]) if nums else None

def extraer_float(texto):
    if not texto:
        return None
    nums = re.findall(r'[\d.]+', texto)
    return float(nums[0]) if nums else None

def scrape_torneo(anyo):
    url = f"https://en.wikipedia.org/wiki/{anyo}_FIFA_World_Cup"
    log.info(f"[{anyo}] Scrapeando: {url}")
    soup = get_soup(url)
    if not soup:
        return None

    datos = {"anyo": anyo, "nombre": f"FIFA World Cup {anyo}"}
    infobox = soup.find("table", class_=re.compile(r"infobox"))
    if not infobox:
        log.warning(f"[{anyo}] No se encontro infobox")
        return datos

    for fila in infobox.find_all("tr"):
        th = fila.find("th")
        td = fila.find("td")
        if not th or not td:
            continue
        clave = limpiar(th.get_text()).lower()
        valor = limpiar(td.get_text())

        if "host" in clave or "country" in clave:
            datos["pais_sede"] = valor
        elif "team" in clave:
            datos["num_equipos"] = extraer_int(valor)
        elif "matche" in clave:
            datos["num_partidos"] = extraer_int(valor)
        elif "goal" in clave and "per" not in clave:
            partes = valor.split("(")
            datos["goles_totales"] = extraer_int(partes[0])
            if len(partes) > 1:
                datos["media_goles"] = extraer_float(partes[1])
        elif "champion" in clave or ("winner" in clave and "runner" not in clave):
            datos["campeon"] = valor
        elif "runner" in clave:
            datos["subcampeon"] = valor
        elif "third" in clave:
            datos["tercer_puesto"] = valor
        elif "fourth" in clave:
            datos["cuarto_puesto"] = valor
        elif "scorer" in clave:
            datos["maximo_goleador"] = valor

    log.info(f"[{anyo}] Campeon: {datos.get('campeon','?')} | Partidos: {datos.get('num_partidos','?')}")
    return datos

def upsert_torneo(cur, d):
    cur.execute("""
        INSERT INTO torneos (anyo, nombre, pais_sede, num_equipos, num_partidos,
            goles_totales, media_goles, campeon, subcampeon,
            tercer_puesto, cuarto_puesto, maximo_goleador)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        ON CONFLICT (anyo) DO UPDATE SET
            campeon = EXCLUDED.campeon,
            subcampeon = EXCLUDED.subcampeon,
            tercer_puesto = EXCLUDED.tercer_puesto,
            goles_totales = EXCLUDED.goles_totales,
            num_partidos = EXCLUDED.num_partidos,
            maximo_goleador = EXCLUDED.maximo_goleador
        RETURNING id
    """, (
        d.get("anyo"), d.get("nombre"), d.get("pais_sede"),
        d.get("num_equipos"), d.get("num_partidos"),
        d.get("goles_totales"), d.get("media_goles"),
        d.get("campeon"), d.get("subcampeon"),
        d.get("tercer_puesto"), d.get("cuarto_puesto"),
        d.get("maximo_goleador"),
    ))
    row = cur.fetchone()
    return row[0] if row else None

def upsert_seleccion(cur, nombre):
    cur.execute("""
        INSERT INTO selecciones (nombre)
        VALUES (%s)
        ON CONFLICT (nombre) DO UPDATE SET nombre = EXCLUDED.nombre
        RETURNING id
    """, (nombre,))
    return cur.fetchone()[0]

def procesar_mundial(anyo, conn, solo_torneo=False):
    log.info(f"{'='*50}")
    log.info(f"Procesando Mundial {anyo}")
    log.info(f"{'='*50}")

    cur = conn.cursor()
    try:
        datos = scrape_torneo(anyo)
        if not datos:
            log.error(f"[{anyo}] No se pudo scrapear")
            cur.close()
            return

        torneo_id = upsert_torneo(cur, datos)
        conn.commit()
        log.info(f"[{anyo}] Guardado con ID {torneo_id}")

        for campo, posicion in [("campeon",1),("subcampeon",2),("tercer_puesto",3),("cuarto_puesto",4)]:
            nombre = datos.get(campo)
            if nombre:
                nombre_limpio = re.sub(r'\(.*?\)', '', nombre).strip()
                sel_id = upsert_seleccion(cur, nombre_limpio)
                cur.execute("""
                    INSERT INTO palmares (seleccion_id, torneo_id, posicion)
                    VALUES (%s,%s,%s)
                    ON CONFLICT (torneo_id, posicion) DO NOTHING
                """, (sel_id, torneo_id, posicion))
        conn.commit()
        log.info(f"[{anyo}] Palmares guardado")

    except Exception as e:
        log.error(f"[{anyo}] Error: {e}", exc_info=True)
        conn.rollback()
    finally:
        cur.close()

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--anyo", type=int)
    parser.add_argument("--desde", type=int, default=1930)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    anyos = [args.anyo] if args.anyo else [a for a in MUNDIALES if a >= args.desde]

    if args.dry_run:
        log.info("DRY RUN")
        for anyo in anyos:
            datos = scrape_torneo(anyo)
            if datos:
                log.info(json.dumps(datos, ensure_ascii=False))
        return

    conn = get_db()
    log.info(f"Conectado. Procesando {len(anyos)} mundiales.")

    for anyo in anyos:
        procesar_mundial(anyo, conn)
        time.sleep(DELAY)

    conn.close()
    log.info("Completado")

if __name__ == "__main__":
    main()
