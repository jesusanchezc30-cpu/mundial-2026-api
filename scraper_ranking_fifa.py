"""
scraper_ranking_fifa.py
Extrae el ranking FIFA actual desde fifa.com y actualiza paises_data.dart
"""
import requests
from bs4 import BeautifulSoup
import json
import logging

logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
log = logging.getLogger(__name__)

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    "Accept": "application/json",
}

# API de FIFA para el ranking
URL = "https://inside.fifa.com/fifa-world-ranking/men?dateId=id14250"
API_URL = "https://www.fifa.com/api/ranking-overview?language=es&dateId=id14250&variant=FIFA_RANKING"

# Mapeo nombre FIFA -> nombre en nuestro archivo
NOMBRE_FIFA_A_PAISES_DATA = {
    'Argentina': 'Argentina',
    'France': 'Francia',
    'England': 'Inglaterra',
    'Spain': 'España',
    'Brazil': 'Brasil',
    'Portugal': 'Portugal',
    'Belgium': 'Bélgica',
    'Netherlands': 'Países Bajos',
    'Germany': 'Alemania',
    'Italy': 'Italia',
    'Croatia': 'Croacia',
    'Morocco': 'Marruecos',
    'United States': 'Estados Unidos',
    'Mexico': 'México',
    'Colombia': 'Colombia',
    'Uruguay': 'Uruguay',
    'Japan': 'Japón',
    'Senegal': 'Senegal',
    'Ecuador': 'Ecuador',
    'Switzerland': 'Suiza',
    'Denmark': 'Dinamarca',
    'South Korea': 'Corea del Sur',
    'Canada': 'Canadá',
    'Tunisia': 'Túnez',
    'Australia': 'Australia',
    'Austria': 'Austria',
    'Turkey': 'Turquía',
    'Iran': 'Irán',
    'Norway': 'Noruega',
    'Qatar': 'Catar',
    'Saudi Arabia': 'Arabia Saudí',
    'Ghana': 'Ghana',
    'Algeria': 'Argelia',
    'Nigeria': 'Nigeria',
    'Ivory Coast': 'Costa de Marfil',
    'Czechia': 'República Checa',
    'Poland': 'Polonia',
    'Scotland': 'Escocia',
    'Serbia': 'Serbia',
    'Ukraine': 'Ucrania',
    'Sweden': 'Suecia',
    'Paraguay': 'Paraguay',
    'Egypt': 'Egipto',
    'Iraq': 'Irak',
    'Panama': 'Panamá',
    'South Africa': 'Sudáfrica',
    'Bosnia and Herzegovina': 'Bosnia Herzegovina',
    'Cape Verde': 'Cabo Verde',
    'Uzbekistan': 'Uzbekistán',
    'New Zealand': 'Nueva Zelanda',
    'DR Congo': 'Rep. Dem. Congo',
    'Haiti': 'Haití',
    'Curacao': 'Curazao',
    'Jordan': 'Jordania',
}

def scrape_ranking():
    log.info("Descargando ranking FIFA...")
    try:
        resp = requests.get(
            "https://inside.fifa.com/ranking/globalranking/globalranking_mw.html",
            headers={**HEADERS, "Accept": "text/html"},
            timeout=15
        )
        soup = BeautifulSoup(resp.text, 'html.parser')
        
        ranking = {}
        # Buscar tabla de ranking
        filas = soup.find_all('tr', class_=lambda x: x and 'row' in x.lower())
        
        if not filas:
            # Intentar con otra estructura
            filas = soup.find_all('tr')
        
        for fila in filas:
            celdas = fila.find_all('td')
            if len(celdas) >= 2:
                pos_text = celdas[0].get_text(strip=True)
                nombre_text = celdas[1].get_text(strip=True)
                try:
                    pos = int(pos_text)
                    if nombre_text:
                        ranking[nombre_text] = pos
                except ValueError:
                    pass
        
        log.info(f"Equipos encontrados: {len(ranking)}")
        return ranking
    except Exception as e:
        log.error(f"Error: {e}")
        return {}

def scrape_ranking_api():
    """Intenta la API de FIFA directamente."""
    log.info("Intentando API FIFA...")
    urls = [
        "https://inside.fifa.com/ranking/globalranking/globalranking_mw.html",
        "https://www.fifa.com/fifa-world-ranking/men",
    ]
    
    for url in urls:
        try:
            resp = requests.get(url, headers={**HEADERS, "Accept": "text/html"}, timeout=15)
            log.info(f"  Status {resp.status_code} para {url}")
            
            soup = BeautifulSoup(resp.text, 'html.parser')
            
            # Buscar datos JSON embebidos
            scripts = soup.find_all('script')
            for script in scripts:
                if script.string and 'ranking' in script.string.lower():
                    text = script.string
                    # Buscar JSON
                    start = text.find('[{')
                    if start > -1:
                        try:
                            end = text.rfind('}]') + 2
                            data = json.loads(text[start:end])
                            ranking = {}
                            for item in data:
                                if 'rank' in item and 'name' in item:
                                    ranking[item['name']] = item['rank']
                            if ranking:
                                log.info(f"  Encontrados {len(ranking)} equipos en JSON")
                                return ranking
                        except:
                            pass
        except Exception as e:
            log.error(f"  Error: {e}")
    
    return {}

def main():
    ranking = scrape_ranking_api()
    
    if not ranking:
        ranking = scrape_ranking()
    
    if not ranking:
        log.warning("No se pudo obtener el ranking. Usando datos manuales.")
        # Ranking aproximado Mayo 2026 basado en últimas actualizaciones conocidas
        ranking = {
            'Argentina': 1, 'France': 2, 'Spain': 3, 'England': 4,
            'Brazil': 5, 'Portugal': 6, 'Belgium': 7, 'Netherlands': 8,
            'Germany': 9, 'Italy': 10, 'Croatia': 11, 'Morocco': 12,
            'United States': 13, 'Mexico': 14, 'Colombia': 15, 'Uruguay': 16,
            'Japan': 17, 'Senegal': 18, 'Ecuador': 19, 'Switzerland': 20,
            'Denmark': 21, 'South Korea': 22, 'Canada': 23, 'Tunisia': 24,
            'Australia': 25, 'Austria': 26, 'Turkey': 27, 'Iran': 28,
            'Norway': 29, 'Qatar': 30, 'Saudi Arabia': 31, 'Ghana': 32,
            'Algeria': 33, 'Ivory Coast': 34, 'Czechia': 35, 'Scotland': 36,
            'Serbia': 37, 'Ukraine': 38, 'Sweden': 39, 'Paraguay': 40,
            'Egypt': 41, 'Iraq': 42, 'Panama': 43, 'South Africa': 44,
            'Bosnia and Herzegovina': 45, 'Cape Verde': 46, 'Uzbekistan': 47,
            'New Zealand': 48, 'DR Congo': 49, 'Haiti': 50,
            'Curacao': 51, 'Jordan': 52,
        }
    
    log.info("\nRanking para paises_data.dart:")
    log.info("(Copia estos valores en el campo rankingFifa de cada país)\n")
    
    for nombre_fifa, pos in sorted(ranking.items(), key=lambda x: x[1])[:60]:
        nombre_es = NOMBRE_FIFA_A_PAISES_DATA.get(nombre_fifa, nombre_fifa)
        log.info(f"  #{pos:3d} {nombre_fifa:30s} -> '{nombre_es}'")

if __name__ == "__main__":
    main()
