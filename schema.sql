-- PROYECTO MUNDIAL 2026 - Schema PostgreSQL

CREATE TABLE torneos (
    id SERIAL PRIMARY KEY,
    anyo INTEGER NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    pais_sede VARCHAR(100),
    paises_sede TEXT[],
    fecha_inicio DATE,
    fecha_fin DATE,
    num_equipos INTEGER,
    num_partidos INTEGER,
    goles_totales INTEGER,
    media_goles DECIMAL(4,2),
    campeon VARCHAR(100),
    subcampeon VARCHAR(100),
    tercer_puesto VARCHAR(100),
    cuarto_puesto VARCHAR(100),
    maximo_goleador VARCHAR(150),
    curiosidades TEXT,
    narrativa TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE selecciones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    nombre_fifa VARCHAR(100),
    codigo_fifa CHAR(3) UNIQUE,
    confederacion VARCHAR(10),
    bandera_url TEXT,
    color_principal VARCHAR(7),
    color_secundario VARCHAR(7),
    mundiales_jugados INTEGER DEFAULT 0,
    mundiales_ganados INTEGER DEFAULT 0,
    partidos_jugados INTEGER DEFAULT 0,
    partidos_ganados INTEGER DEFAULT 0,
    partidos_empatados INTEGER DEFAULT 0,
    partidos_perdidos INTEGER DEFAULT 0,
    goles_favor INTEGER DEFAULT 0,
    goles_contra INTEGER DEFAULT 0,
    ficha_narrativa TEXT,
    curiosidades TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE estadios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    nombre_alternativo VARCHAR(150),
    ciudad VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    latitud DECIMAL(9,6),
    longitud DECIMAL(9,6),
    capacidad INTEGER,
    anyo_construccion INTEGER,
    anyo_renovacion INTEGER,
    superficie VARCHAR(50),
    techo BOOLEAN DEFAULT FALSE,
    foto_url TEXT,
    wikipedia_url TEXT,
    temp_media_junio DECIMAL(4,1),
    temp_max_junio DECIMAL(4,1),
    humedad_media INTEGER,
    descripcion_narrativa TEXT,
    curiosidades TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO estadios (nombre, ciudad, pais, capacidad, latitud, longitud) VALUES
('MetLife Stadium', 'Nueva York / Nueva Jersey', 'Estados Unidos', 82500, 40.8135, -74.0745),
('SoFi Stadium', 'Los Angeles', 'Estados Unidos', 70240, 33.9535, -118.3392),
('AT&T Stadium', 'Dallas', 'Estados Unidos', 80000, 32.7480, -97.0928),
('Levis Stadium', 'San Francisco', 'Estados Unidos', 68500, 37.4033, -121.9694),
('Hard Rock Stadium', 'Miami', 'Estados Unidos', 65326, 25.9580, -80.2389),
('Gillette Stadium', 'Boston', 'Estados Unidos', 65878, 42.0909, -71.2643),
('Lincoln Financial Field', 'Filadelfia', 'Estados Unidos', 69796, 39.9008, -75.1675),
('Arrowhead Stadium', 'Kansas City', 'Estados Unidos', 76416, 39.0489, -94.4839),
('Lumen Field', 'Seattle', 'Estados Unidos', 72000, 47.5952, -122.3316),
('Rose Bowl Stadium', 'Los Angeles (Pasadena)', 'Estados Unidos', 90888, 34.1614, -118.1676),
('Estadio Azteca', 'Ciudad de Mexico', 'Mexico', 87523, 19.3030, -99.1500),
('Estadio BBVA', 'Monterrey', 'Mexico', 53500, 25.6694, -100.2436),
('Estadio Akron', 'Guadalajara', 'Mexico', 49850, 20.6866, -103.4670),
('BC Place', 'Vancouver', 'Canada', 54500, 49.2768, -123.1118),
('BMO Field', 'Toronto', 'Canada', 45736, 43.6333, -79.4187),
('Stade Olympique', 'Montreal', 'Canada', 61004, 45.5632, -73.5515);

CREATE TABLE participaciones (
    id SERIAL PRIMARY KEY,
    torneo_id INTEGER REFERENCES torneos(id),
    seleccion_id INTEGER REFERENCES selecciones(id),
    grupo VARCHAR(5),
    posicion_grupo INTEGER,
    fase_eliminada VARCHAR(50),
    entrenador VARCHAR(150),
    goles_favor INTEGER DEFAULT 0,
    goles_contra INTEGER DEFAULT 0,
    puntos INTEGER DEFAULT 0,
    valor_mercado_millones DECIMAL(8,2),
    UNIQUE(torneo_id, seleccion_id)
);

CREATE TABLE jugadores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    nombre_completo VARCHAR(200),
    seleccion_id INTEGER REFERENCES selecciones(id),
    fecha_nacimiento DATE,
    posicion VARCHAR(30),
    dorsal INTEGER,
    foto_url TEXT,
    transfermarkt_id VARCHAR(20),
    mundiales_jugados INTEGER DEFAULT 0,
    partidos_jugados INTEGER DEFAULT 0,
    goles INTEGER DEFAULT 0,
    asistencias INTEGER DEFAULT 0,
    tarjetas_amarillas INTEGER DEFAULT 0,
    tarjetas_rojas INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE convocatorias (
    id SERIAL PRIMARY KEY,
    torneo_id INTEGER REFERENCES torneos(id),
    jugador_id INTEGER REFERENCES jugadores(id),
    seleccion_id INTEGER REFERENCES selecciones(id),
    dorsal INTEGER,
    posicion VARCHAR(30),
    edad_en_torneo INTEGER,
    valor_mercado_millones DECIMAL(6,2),
    UNIQUE(torneo_id, jugador_id)
);

CREATE TABLE fases (
    id SERIAL PRIMARY KEY,
    torneo_id INTEGER REFERENCES torneos(id),
    nombre VARCHAR(50) NOT NULL,
    orden INTEGER,
    UNIQUE(torneo_id, nombre)
);

CREATE TABLE partidos (
    id SERIAL PRIMARY KEY,
    torneo_id INTEGER REFERENCES torneos(id),
    fase_id INTEGER REFERENCES fases(id),
    estadio_id INTEGER REFERENCES estadios(id),
    seleccion_local_id INTEGER REFERENCES selecciones(id),
    seleccion_visitante_id INTEGER REFERENCES selecciones(id),
    fecha DATE,
    hora_local TIME,
    hora_utc TIMESTAMP,
    zona_horaria VARCHAR(50),
    grupo VARCHAR(5),
    jornada INTEGER,
    goles_local INTEGER,
    goles_visitante INTEGER,
    goles_local_prorroga INTEGER,
    goles_visitante_prorroga INTEGER,
    penaltis_local INTEGER,
    penaltis_visitante INTEGER,
    hubo_prorroga BOOLEAN DEFAULT FALSE,
    hubo_penaltis BOOLEAN DEFAULT FALSE,
    arbitro VARCHAR(150),
    asistencia INTEGER,
    clima_temperatura DECIMAL(4,1),
    clima_descripcion VARCHAR(100),
    clima_humedad INTEGER,
    clima_viento_kmh DECIMAL(5,1),
    estado VARCHAR(20) DEFAULT 'pendiente',
    minuto_actual INTEGER,
    resumen_narrativo TEXT,
    curiosidades TEXT,
    sofascore_id VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE eventos_partido (
    id SERIAL PRIMARY KEY,
    partido_id INTEGER REFERENCES partidos(id),
    tipo VARCHAR(30) NOT NULL,
    minuto INTEGER NOT NULL,
    minuto_adicional INTEGER DEFAULT 0,
    jugador_id INTEGER REFERENCES jugadores(id),
    jugador_secundario_id INTEGER REFERENCES jugadores(id),
    seleccion_id INTEGER REFERENCES selecciones(id),
    descripcion TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE estadisticas_partido (
    id SERIAL PRIMARY KEY,
    partido_id INTEGER REFERENCES partidos(id),
    seleccion_id INTEGER REFERENCES selecciones(id),
    posesion DECIMAL(4,1),
    tiros INTEGER,
    tiros_puerta INTEGER,
    corners INTEGER,
    faltas INTEGER,
    fueras_de_juego INTEGER,
    tarjetas_amarillas INTEGER,
    tarjetas_rojas INTEGER,
    pases INTEGER,
    pases_completados INTEGER,
    precision_pases DECIMAL(4,1),
    UNIQUE(partido_id, seleccion_id)
);

CREATE TABLE goleadores_torneo (
    id SERIAL PRIMARY KEY,
    torneo_id INTEGER REFERENCES torneos(id),
    jugador_id INTEGER REFERENCES jugadores(id),
    seleccion_id INTEGER REFERENCES selecciones(id),
    goles INTEGER DEFAULT 0,
    asistencias INTEGER DEFAULT 0,
    partidos INTEGER DEFAULT 0,
    UNIQUE(torneo_id, jugador_id)
);

CREATE TABLE palmares (
    id SERIAL PRIMARY KEY,
    seleccion_id INTEGER REFERENCES selecciones(id),
    torneo_id INTEGER REFERENCES torneos(id),
    posicion INTEGER NOT NULL,
    UNIQUE(torneo_id, posicion)
);

CREATE TABLE clima_live (
    id SERIAL PRIMARY KEY,
    estadio_id INTEGER REFERENCES estadios(id),
    timestamp TIMESTAMP DEFAULT NOW(),
    temperatura DECIMAL(4,1),
    sensacion_termica DECIMAL(4,1),
    humedad INTEGER,
    viento_kmh DECIMAL(5,1),
    descripcion VARCHAR(100),
    icono VARCHAR(20),
    probabilidad_lluvia INTEGER
);

CREATE TABLE ia_generaciones (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    entidad_id INTEGER NOT NULL,
    modelo VARCHAR(50),
    tokens_input INTEGER,
    tokens_output INTEGER,
    coste_usd DECIMAL(8,6),
    contenido TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_partidos_torneo ON partidos(torneo_id);
CREATE INDEX idx_partidos_fecha ON partidos(fecha);
CREATE INDEX idx_partidos_estado ON partidos(estado);
CREATE INDEX idx_eventos_partido ON eventos_partido(partido_id);
CREATE INDEX idx_eventos_tipo ON eventos_partido(tipo);
CREATE INDEX idx_participaciones_torneo ON participaciones(torneo_id);
CREATE INDEX idx_participaciones_seleccion ON participaciones(seleccion_id);
CREATE INDEX idx_goleadores_torneo ON goleadores_torneo(torneo_id);
CREATE INDEX idx_clima_live_estadio ON clima_live(estadio_id);
CREATE INDEX idx_clima_live_timestamp ON clima_live(timestamp);

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_partidos_updated_at
BEFORE UPDATE ON partidos
FOR EACH ROW EXECUTE FUNCTION update_updated_at();
