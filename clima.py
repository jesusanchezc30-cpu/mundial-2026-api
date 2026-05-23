"""
clima.py - Endpoint de clima para estadios usando Open-Meteo (gratuito, sin API key)
"""
from fastapi import APIRouter, HTTPException
import httpx
from cache import cache, TTL_CLIMA
from database import get_conn

router = APIRouter(prefix="/clima", tags=["clima"])

OPEN_METEO_URL = "https://api.open-meteo.com/v1/forecast"

CODIGOS_WMO = {
    0: "Despejado", 1: "Mayormente despejado", 2: "Parcialmente nublado",
    3: "Nublado", 45: "Niebla", 48: "Niebla con escarcha",
    51: "Llovizna ligera", 53: "Llovizna moderada", 55: "Llovizna densa",
    61: "Lluvia ligera", 63: "Lluvia moderada", 65: "Lluvia intensa",
    71: "Nieve ligera", 73: "Nieve moderada", 75: "Nieve intensa",
    80: "Chubascos ligeros", 81: "Chubascos moderados", 82: "Chubascos fuertes",
    95: "Tormenta", 96: "Tormenta con granizo", 99: "Tormenta con granizo intenso",
}

@router.get("/estadio/{estadio_id}")
async def clima_estadio(estadio_id: int):
    """Clima actual y prevision 7 dias para un estadio."""
    key = f"clima:estadio:{estadio_id}"
    cached = cache.get(key)
    if cached:
        return cached

    async with get_conn() as conn:
        estadio = await conn.fetchrow(
            "SELECT nombre, ciudad, latitud, longitud FROM estadios WHERE id = $1",
            estadio_id
        )
    if not estadio:
        raise HTTPException(404, "Estadio no encontrado")
    if not estadio["latitud"]:
        raise HTTPException(404, "Este estadio no tiene coordenadas GPS")

    params = {
        "latitude": estadio["latitud"],
        "longitude": estadio["longitud"],
        "current": "temperature_2m,weathercode,windspeed_10m,relativehumidity_2m",
        "daily": "temperature_2m_max,temperature_2m_min,weathercode,precipitation_sum",
        "timezone": "auto",
        "forecast_days": 7,
    }

    try:
        async with httpx.AsyncClient(timeout=8) as client:
            resp = await client.get(OPEN_METEO_URL, params=params)
        if resp.status_code != 200:
            raise HTTPException(503, "Open-Meteo no disponible")
        data = resp.json()
    except httpx.RequestError:
        raise HTTPException(503, "Error conectando con Open-Meteo")

    current = data.get("current", {})
    daily = data.get("daily", {})

    result = {
        "estadio": estadio["nombre"],
        "ciudad": estadio["ciudad"],
        "actual": {
            "temperatura": current.get("temperature_2m"),
            "descripcion": CODIGOS_WMO.get(current.get("weathercode", -1), "Desconocido"),
            "viento_kmh": current.get("windspeed_10m"),
            "humedad_pct": current.get("relativehumidity_2m"),
        },
        "prevision_7dias": [
            {
                "fecha": daily["time"][i],
                "max": daily["temperature_2m_max"][i],
                "min": daily["temperature_2m_min"][i],
                "descripcion": CODIGOS_WMO.get(daily["weathercode"][i], "Desconocido"),
                "precipitacion_mm": daily["precipitation_sum"][i],
            }
            for i in range(len(daily.get("time", [])))
        ]
    }

    cache.set(key, result, TTL_CLIMA)
    return result

@router.get("/partido/{partido_id}")
async def clima_partido(partido_id: int):
    """Clima del estadio donde se juega un partido."""
    async with get_conn() as conn:
        row = await conn.fetchrow(
            "SELECT estadio_id FROM partidos WHERE id = $1", partido_id
        )
    if not row or not row["estadio_id"]:
        raise HTTPException(404, "Partido sin estadio asignado")
    return await clima_estadio(row["estadio_id"])
