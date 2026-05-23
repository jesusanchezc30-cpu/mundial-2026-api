"""
schemas.py - Modelos Pydantic para respuestas de la API
"""
from pydantic import BaseModel
from typing import Optional
from datetime import date, time

class PartidoResumen(BaseModel):
    id: int
    fecha: date
    hora_local: Optional[str]
    hora_espana: Optional[str]
    local: str
    visitante: str
    grupo: Optional[str]
    fase: str
    estadio: Optional[str]
    ciudad: Optional[str]
    goles_local: Optional[int]
    goles_visitante: Optional[int]
    estado: Optional[str]
    sofascore_id: Optional[str]

class ClasificacionGrupo(BaseModel):
    grupo: str
    pos: int
    seleccion: str
    codigo_fifa: Optional[str]
    pj: int
    pg: int
    pe: int
    pp: int
    gf: int
    gc: int
    dg: int
    pts: int

class Seleccion(BaseModel):
    id: int
    nombre: str
    codigo_fifa: Optional[str]
    grupo: Optional[str]
    confederation: Optional[str]

class Estadio(BaseModel):
    id: int
    nombre: str
    ciudad: str
    pais: str
    capacidad: Optional[int]
    latitud: Optional[float]
    longitud: Optional[float]

class MundialHistorico(BaseModel):
    anyo: int
    pais_sede: str
    campeon: Optional[str]
    subcampeon: Optional[str]
    tercero: Optional[str]
    cuarto: Optional[str]
    num_equipos: Optional[int]
    num_partidos: Optional[int]
    goles_totales: Optional[int]
