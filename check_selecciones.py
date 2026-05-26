"""
Muestra todas las selecciones históricas únicas para añadirlas al mapa de traducciones.
"""
import psycopg2
from dotenv import load_dotenv
import os

load_dotenv()

conn = psycopg2.connect(
    host=os.getenv("DB_HOST", "localhost"),
    port=int(os.getenv("DB_PORT", 5432)),
    dbname=os.getenv("DB_NAME", "mundial"),
    user=os.getenv("DB_USER", "postgres"),
    password=os.getenv("DB_PASSWORD", ""),
)
cur = conn.cursor()

cur.execute("""
    SELECT DISTINCT s.nombre 
    FROM selecciones s
    JOIN partidos p ON p.seleccion_local_id = s.id OR p.seleccion_visitante_id = s.id
    JOIN torneos t ON t.id = p.torneo_id
    WHERE t.anyo < 2026
    ORDER BY s.nombre
""")

rows = cur.fetchall()
conn.close()

print(f"Total selecciones históricas: {len(rows)}")
print()
for r in rows:
    print(r[0])
