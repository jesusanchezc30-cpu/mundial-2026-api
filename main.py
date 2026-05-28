"""
main.py - API Mundial 2026
"""
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from database import init_db, close_db
import partidos
import grupos
import selecciones
import estadios
import historico
import clima

@asynccontextmanager
async def lifespan(app: FastAPI):
    await init_db()
    yield
    await close_db()

app = FastAPI(
    title="Mundial 2026 API",
    description="API de datos del Mundial 2026",
    version="1.1.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(partidos.router)
app.include_router(grupos.router)
app.include_router(selecciones.router)
app.include_router(estadios.router)
app.include_router(historico.router)
app.include_router(clima.router)

from cache import cache

@app.post("/admin/clear-cache")
async def clear_cache():
    cache.clear()
    return {"status": "ok", "message": "Cache limpiada"}

@app.get("/")
async def root():
    return {
        "api": "Mundial 2026",
        "version": "1.1.0",
        "endpoints": [
            "/partidos/hoy",
            "/partidos/proximos?dias=7",
            "/partidos/fecha/{YYYY-MM-DD}",
            "/partidos/grupo/{letra}",
            "/partidos/{id}",
            "/partidos/{id}/live",
            "/grupos/",
            "/grupos/{letra}",
            "/selecciones/",
            "/selecciones/{id}",
            "/estadios/",
            "/estadios/{id}",
            "/historico/",
            "/historico/{anyo}",
            "/clima/estadio/{id}",
            "/clima/partido/{id}",
        ]
    }
