"""
database.py - Conexion a PostgreSQL
"""
import os
from contextlib import asynccontextmanager
import asyncpg
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = (
    f"postgresql://{os.getenv('DB_USER', 'postgres')}:"
    f"{os.getenv('DB_PASSWORD', '')}@"
    f"{os.getenv('DB_HOST', 'localhost')}:"
    f"{os.getenv('DB_PORT', '5432')}/"
    f"{os.getenv('DB_NAME', 'mundial')}"
)

pool = None

async def init_db():
    global pool
    pool = await asyncpg.create_pool(DATABASE_URL, min_size=2, max_size=10)

async def close_db():
    global pool
    if pool:
        await pool.close()

@asynccontextmanager
async def get_conn():
    async with pool.acquire() as conn:
        yield conn
