"""
limpiar_historico.py v2
"""
import psycopg2
from dotenv import load_dotenv
import os

load_dotenv()

PAISES_VALIDOS = {
    'Algeria', 'Angola', 'Argentina', 'Australia', 'Austria', 'Belgium',
    'Bolivia', 'Bosnia and Herzegovina', 'Brazil', 'Bulgaria', 'Cameroon',
    'Canada', 'Chile', 'China', 'Colombia', 'Costa Rica', 'Croatia', 'Cuba',
    'Czech Republic', 'Czechoslovakia', 'Denmark', 'Dutch East Indies',
    'East Germany', 'Ecuador', 'Egypt', 'El Salvador', 'England', 'France',
    'FR Yugoslavia', 'Germany', 'Ghana', 'Greece', 'Haiti', 'Honduras',
    'Hungary', 'Iceland', 'Iran', 'Iraq', 'Israel', 'Italy', 'Ivory Coast',
    'Jamaica', 'Japan', 'Kuwait', 'Mexico', 'Morocco', 'Netherlands',
    'New Zealand', 'Nigeria', 'North Korea', 'Northern Ireland', 'Norway',
    'Panama', 'Paraguay', 'Peru', 'Poland', 'Portugal', 'Qatar', 'Romania',
    'Republic of Ireland', 'Russia', 'Saudi Arabia', 'Scotland', 'Senegal',
    'Serbia', 'Serbia and Montenegro', 'Slovakia', 'Slovenia', 'South Africa',
    'South Korea', 'Soviet Union', 'Spain', 'Sweden', 'Switzerland', 'Togo',
    'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Ukraine',
    'United Arab Emirates', 'United States', 'Uruguay', 'Wales',
    'West Germany', 'Yugoslavia', 'Zaire',
    # Selecciones del Mundial 2026
    'USA', 'Czechia', 'Bosnia Herzegovina', 'Curacao', 'Cape Verde',
    'Jordan', 'DR Congo', 'Uzbekistan', 'South Korea', 'Bosnia and Herzegovina',
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
    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT id, nombre FROM selecciones")
    todas = cur.fetchall()
    
    ids_invalidos = [sid for sid, nombre in todas if nombre not in PAISES_VALIDOS]
    print(f"Selecciones inválidas a eliminar: {len(ids_invalidos)}")

    if ids_invalidos:
        # Eliminar en todas las tablas que referencian selecciones
        tablas = [
            'estadisticas_partido', 'eventos_partido', 'convocatorias',
            'participaciones', 'palmares', 'goleadores_torneo'
        ]
        for tabla in tablas:
            try:
                cur.execute(f"DELETE FROM {tabla} WHERE seleccion_id = ANY(%s)", (ids_invalidos,))
                if cur.rowcount > 0:
                    print(f"  {tabla}: {cur.rowcount} eliminados")
            except Exception as e:
                print(f"  {tabla}: {e}")
                conn.rollback()

        # Eliminar partidos con selecciones inválidas
        cur.execute("""
            DELETE FROM partidos 
            WHERE seleccion_local_id = ANY(%s) 
            OR seleccion_visitante_id = ANY(%s)
        """, (ids_invalidos, ids_invalidos))
        print(f"Partidos eliminados: {cur.rowcount}")

        # Eliminar selecciones inválidas
        cur.execute("DELETE FROM selecciones WHERE id = ANY(%s)", (ids_invalidos,))
        print(f"Selecciones eliminadas: {cur.rowcount}")

    conn.commit()

    cur.execute("SELECT COUNT(*) FROM partidos WHERE torneo_id IN (SELECT id FROM torneos WHERE anyo < 2026)")
    print(f"\nPartidos históricos restantes: {cur.fetchone()[0]}")
    
    conn.close()

if __name__ == "__main__":
    main()
