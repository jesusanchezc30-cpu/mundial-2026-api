"""
cache.py - Cache en memoria simple con TTL
No requiere Redis ni dependencias externas.
"""
import time
from typing import Any, Optional

class Cache:
    def __init__(self):
        self._store: dict[str, tuple[Any, float]] = {}

    def get(self, key: str) -> Optional[Any]:
        if key not in self._store:
            return None
        value, expires_at = self._store[key]
        if time.time() > expires_at:
            del self._store[key]
            return None
        return value

    def set(self, key: str, value: Any, ttl: int = 60):
        """ttl en segundos."""
        self._store[key] = (value, time.time() + ttl)

    def delete(self, key: str):
        self._store.pop(key, None)

    def clear(self):
        self._store.clear()

# Instancia global
cache = Cache()

# TTLs por tipo de dato
TTL_PARTIDOS_HOY     = 30    # 30s — puede cambiar el marcador
TTL_PARTIDOS_PROXIMOS = 300  # 5min — no cambia tan rapido
TTL_GRUPOS           = 60    # 1min — tabla actualizada tras cada partido
TTL_ESTADIOS         = 3600  # 1h — datos estaticos
TTL_HISTORICO        = 3600  # 1h — datos estaticos
TTL_CLIMA            = 1800  # 30min — Open-Meteo gratuito, sin limite
TTL_SELECCIONES      = 600   # 10min
