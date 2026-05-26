--
-- PostgreSQL database dump
--

\restrict l6CKPO8XzwBIgwflLjLSSRgd7bUCtnzH7L7lye7DIUPUM7U7AQAZWdV9eI9BI1K

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: update_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clima_live; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clima_live (
    id integer NOT NULL,
    estadio_id integer,
    "timestamp" timestamp without time zone DEFAULT now(),
    temperatura numeric(4,1),
    sensacion_termica numeric(4,1),
    humedad integer,
    viento_kmh numeric(5,1),
    descripcion character varying(100),
    icono character varying(20),
    probabilidad_lluvia integer
);


--
-- Name: clima_live_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clima_live_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clima_live_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clima_live_id_seq OWNED BY public.clima_live.id;


--
-- Name: convocatorias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.convocatorias (
    id integer NOT NULL,
    torneo_id integer,
    jugador_id integer,
    seleccion_id integer,
    dorsal integer,
    posicion character varying(30),
    edad_en_torneo integer,
    valor_mercado_millones numeric(6,2)
);


--
-- Name: convocatorias_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.convocatorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: convocatorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.convocatorias_id_seq OWNED BY public.convocatorias.id;


--
-- Name: estadios; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estadios (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    nombre_alternativo character varying(150),
    ciudad character varying(100) NOT NULL,
    pais character varying(100) NOT NULL,
    latitud numeric(9,6),
    longitud numeric(9,6),
    capacidad integer,
    anyo_construccion integer,
    anyo_renovacion integer,
    superficie character varying(50),
    techo boolean DEFAULT false,
    foto_url text,
    wikipedia_url text,
    temp_media_junio numeric(4,1),
    temp_max_junio numeric(4,1),
    humedad_media integer,
    descripcion_narrativa text,
    curiosidades text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: estadios_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estadios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estadios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estadios_id_seq OWNED BY public.estadios.id;


--
-- Name: estadisticas_partido; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.estadisticas_partido (
    id integer NOT NULL,
    partido_id integer,
    seleccion_id integer,
    posesion numeric(4,1),
    tiros integer,
    tiros_puerta integer,
    corners integer,
    faltas integer,
    fueras_de_juego integer,
    tarjetas_amarillas integer,
    tarjetas_rojas integer,
    pases integer,
    pases_completados integer,
    precision_pases numeric(4,1)
);


--
-- Name: estadisticas_partido_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.estadisticas_partido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: estadisticas_partido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.estadisticas_partido_id_seq OWNED BY public.estadisticas_partido.id;


--
-- Name: eventos_partido; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.eventos_partido (
    id integer NOT NULL,
    partido_id integer,
    tipo character varying(30) NOT NULL,
    minuto integer NOT NULL,
    minuto_adicional integer DEFAULT 0,
    jugador_id integer,
    jugador_secundario_id integer,
    seleccion_id integer,
    descripcion text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: eventos_partido_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.eventos_partido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: eventos_partido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.eventos_partido_id_seq OWNED BY public.eventos_partido.id;


--
-- Name: fases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fases (
    id integer NOT NULL,
    torneo_id integer,
    nombre character varying(50) NOT NULL,
    orden integer
);


--
-- Name: fases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fases_id_seq OWNED BY public.fases.id;


--
-- Name: goleadores_torneo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goleadores_torneo (
    id integer NOT NULL,
    torneo_id integer,
    jugador_id integer,
    seleccion_id integer,
    goles integer DEFAULT 0,
    asistencias integer DEFAULT 0,
    partidos integer DEFAULT 0
);


--
-- Name: goleadores_torneo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.goleadores_torneo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goleadores_torneo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.goleadores_torneo_id_seq OWNED BY public.goleadores_torneo.id;


--
-- Name: ia_generaciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ia_generaciones (
    id integer NOT NULL,
    tipo character varying(50) NOT NULL,
    entidad_id integer NOT NULL,
    modelo character varying(50),
    tokens_input integer,
    tokens_output integer,
    coste_usd numeric(8,6),
    contenido text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: ia_generaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ia_generaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ia_generaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ia_generaciones_id_seq OWNED BY public.ia_generaciones.id;


--
-- Name: jugadores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jugadores (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    nombre_completo character varying(200),
    seleccion_id integer,
    fecha_nacimiento date,
    posicion character varying(30),
    dorsal integer,
    foto_url text,
    transfermarkt_id character varying(20),
    mundiales_jugados integer DEFAULT 0,
    partidos_jugados integer DEFAULT 0,
    goles integer DEFAULT 0,
    asistencias integer DEFAULT 0,
    tarjetas_amarillas integer DEFAULT 0,
    tarjetas_rojas integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: jugadores_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jugadores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jugadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jugadores_id_seq OWNED BY public.jugadores.id;


--
-- Name: palmares; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.palmares (
    id integer NOT NULL,
    seleccion_id integer,
    torneo_id integer,
    posicion integer NOT NULL
);


--
-- Name: palmares_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.palmares_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: palmares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.palmares_id_seq OWNED BY public.palmares.id;


--
-- Name: participaciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.participaciones (
    id integer NOT NULL,
    torneo_id integer,
    seleccion_id integer,
    grupo character varying(5),
    posicion_grupo integer,
    fase_eliminada character varying(50),
    entrenador character varying(150),
    goles_favor integer DEFAULT 0,
    goles_contra integer DEFAULT 0,
    puntos integer DEFAULT 0,
    valor_mercado_millones numeric(8,2)
);


--
-- Name: participaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.participaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: participaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.participaciones_id_seq OWNED BY public.participaciones.id;


--
-- Name: partidos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partidos (
    id integer NOT NULL,
    torneo_id integer,
    fase_id integer,
    estadio_id integer,
    seleccion_local_id integer,
    seleccion_visitante_id integer,
    fecha date,
    hora_local time without time zone,
    hora_utc timestamp without time zone,
    zona_horaria character varying(50),
    grupo character varying(5),
    jornada integer,
    goles_local integer,
    goles_visitante integer,
    goles_local_prorroga integer,
    goles_visitante_prorroga integer,
    penaltis_local integer,
    penaltis_visitante integer,
    hubo_prorroga boolean DEFAULT false,
    hubo_penaltis boolean DEFAULT false,
    arbitro character varying(150),
    asistencia integer,
    clima_temperatura numeric(4,1),
    clima_descripcion character varying(100),
    clima_humedad integer,
    clima_viento_kmh numeric(5,1),
    estado character varying(20) DEFAULT 'pendiente'::character varying,
    minuto_actual integer,
    resumen_narrativo text,
    curiosidades text,
    sofascore_id character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    hora_espana time without time zone
);


--
-- Name: partidos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.partidos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: partidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.partidos_id_seq OWNED BY public.partidos.id;


--
-- Name: selecciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.selecciones (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    nombre_fifa character varying(100),
    codigo_fifa character(3),
    confederacion character varying(10),
    bandera_url text,
    color_principal character varying(7),
    color_secundario character varying(7),
    mundiales_jugados integer DEFAULT 0,
    mundiales_ganados integer DEFAULT 0,
    partidos_jugados integer DEFAULT 0,
    partidos_ganados integer DEFAULT 0,
    partidos_empatados integer DEFAULT 0,
    partidos_perdidos integer DEFAULT 0,
    goles_favor integer DEFAULT 0,
    goles_contra integer DEFAULT 0,
    ficha_narrativa text,
    curiosidades text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: selecciones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.selecciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: selecciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.selecciones_id_seq OWNED BY public.selecciones.id;


--
-- Name: torneos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.torneos (
    id integer NOT NULL,
    anyo integer NOT NULL,
    nombre character varying(100) NOT NULL,
    pais_sede character varying(100),
    paises_sede text[],
    fecha_inicio date,
    fecha_fin date,
    num_equipos integer,
    num_partidos integer,
    goles_totales integer,
    media_goles numeric(4,2),
    campeon character varying(100),
    subcampeon character varying(100),
    tercer_puesto character varying(100),
    cuarto_puesto character varying(100),
    maximo_goleador character varying(150),
    curiosidades text,
    narrativa text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: torneos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.torneos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: torneos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.torneos_id_seq OWNED BY public.torneos.id;


--
-- Name: clima_live id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clima_live ALTER COLUMN id SET DEFAULT nextval('public.clima_live_id_seq'::regclass);


--
-- Name: convocatorias id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.convocatorias ALTER COLUMN id SET DEFAULT nextval('public.convocatorias_id_seq'::regclass);


--
-- Name: estadios id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadios ALTER COLUMN id SET DEFAULT nextval('public.estadios_id_seq'::regclass);


--
-- Name: estadisticas_partido id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadisticas_partido ALTER COLUMN id SET DEFAULT nextval('public.estadisticas_partido_id_seq'::regclass);


--
-- Name: eventos_partido id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.eventos_partido ALTER COLUMN id SET DEFAULT nextval('public.eventos_partido_id_seq'::regclass);


--
-- Name: fases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fases ALTER COLUMN id SET DEFAULT nextval('public.fases_id_seq'::regclass);


--
-- Name: goleadores_torneo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goleadores_torneo ALTER COLUMN id SET DEFAULT nextval('public.goleadores_torneo_id_seq'::regclass);


--
-- Name: ia_generaciones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ia_generaciones ALTER COLUMN id SET DEFAULT nextval('public.ia_generaciones_id_seq'::regclass);


--
-- Name: jugadores id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jugadores ALTER COLUMN id SET DEFAULT nextval('public.jugadores_id_seq'::regclass);


--
-- Name: palmares id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.palmares ALTER COLUMN id SET DEFAULT nextval('public.palmares_id_seq'::regclass);


--
-- Name: participaciones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participaciones ALTER COLUMN id SET DEFAULT nextval('public.participaciones_id_seq'::regclass);


--
-- Name: partidos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos ALTER COLUMN id SET DEFAULT nextval('public.partidos_id_seq'::regclass);


--
-- Name: selecciones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selecciones ALTER COLUMN id SET DEFAULT nextval('public.selecciones_id_seq'::regclass);


--
-- Name: torneos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.torneos ALTER COLUMN id SET DEFAULT nextval('public.torneos_id_seq'::regclass);


--
-- Data for Name: clima_live; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.clima_live (id, estadio_id, "timestamp", temperatura, sensacion_termica, humedad, viento_kmh, descripcion, icono, probabilidad_lluvia) FROM stdin;
\.


--
-- Data for Name: convocatorias; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.convocatorias (id, torneo_id, jugador_id, seleccion_id, dorsal, posicion, edad_en_torneo, valor_mercado_millones) FROM stdin;
\.


--
-- Data for Name: estadios; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estadios (id, nombre, nombre_alternativo, ciudad, pais, latitud, longitud, capacidad, anyo_construccion, anyo_renovacion, superficie, techo, foto_url, wikipedia_url, temp_media_junio, temp_max_junio, humedad_media, descripcion_narrativa, curiosidades, created_at) FROM stdin;
1	MetLife Stadium	\N	Nueva York / Nueva Jersey	Estados Unidos	40.813500	-74.074500	82500	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
2	SoFi Stadium	\N	Los Angeles	Estados Unidos	33.953500	-118.339200	70240	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
3	AT&T Stadium	\N	Dallas	Estados Unidos	32.748000	-97.092800	80000	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
4	Levis Stadium	\N	San Francisco	Estados Unidos	37.403300	-121.969400	68500	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
5	Hard Rock Stadium	\N	Miami	Estados Unidos	25.958000	-80.238900	65326	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
6	Gillette Stadium	\N	Boston	Estados Unidos	42.090900	-71.264300	65878	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
7	Lincoln Financial Field	\N	Filadelfia	Estados Unidos	39.900800	-75.167500	69796	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
8	Arrowhead Stadium	\N	Kansas City	Estados Unidos	39.048900	-94.483900	76416	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
9	Lumen Field	\N	Seattle	Estados Unidos	47.595200	-122.331600	72000	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
10	Rose Bowl Stadium	\N	Los Angeles (Pasadena)	Estados Unidos	34.161400	-118.167600	90888	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
11	Estadio Azteca	\N	Ciudad de Mexico	Mexico	19.303000	-99.150000	87523	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
12	Estadio BBVA	\N	Monterrey	Mexico	25.669400	-100.243600	53500	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
13	Estadio Akron	\N	Guadalajara	Mexico	20.686600	-103.467000	49850	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
14	BC Place	\N	Vancouver	Canada	49.276800	-123.111800	54500	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
15	BMO Field	\N	Toronto	Canada	43.633300	-79.418700	45736	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
16	Stade Olympique	\N	Montreal	Canada	45.563200	-73.551500	61004	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	2026-05-23 09:42:50.683475
\.


--
-- Data for Name: estadisticas_partido; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.estadisticas_partido (id, partido_id, seleccion_id, posesion, tiros, tiros_puerta, corners, faltas, fueras_de_juego, tarjetas_amarillas, tarjetas_rojas, pases, pases_completados, precision_pases) FROM stdin;
\.


--
-- Data for Name: eventos_partido; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.eventos_partido (id, partido_id, tipo, minuto, minuto_adicional, jugador_id, jugador_secundario_id, seleccion_id, descripcion, created_at) FROM stdin;
\.


--
-- Data for Name: fases; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fases (id, torneo_id, nombre, orden) FROM stdin;
1	23	Fase de grupos	1
2	23	Ronda de 32	2
3	23	Octavos de final	3
4	23	Cuartos de final	4
5	23	Semifinales	5
6	23	Tercer puesto	6
7	23	Final	7
\.


--
-- Data for Name: goleadores_torneo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.goleadores_torneo (id, torneo_id, jugador_id, seleccion_id, goles, asistencias, partidos) FROM stdin;
\.


--
-- Data for Name: ia_generaciones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ia_generaciones (id, tipo, entidad_id, modelo, tokens_input, tokens_output, coste_usd, contenido, created_at) FROM stdin;
\.


--
-- Data for Name: jugadores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jugadores (id, nombre, nombre_completo, seleccion_id, fecha_nacimiento, posicion, dorsal, foto_url, transfermarkt_id, mundiales_jugados, partidos_jugados, goles, asistencias, tarjetas_amarillas, tarjetas_rojas, created_at) FROM stdin;
\.


--
-- Data for Name: palmares; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.palmares (id, seleccion_id, torneo_id, posicion) FROM stdin;
1	1	1	1
2	2	1	2
3	3	1	3
4	4	1	4
5	5	2	1
6	6	2	2
7	7	2	3
8	8	2	4
9	5	3	1
10	10	3	2
11	11	3	3
12	12	3	4
13	1	4	1
14	11	4	2
15	12	4	3
16	16	4	4
17	17	5	1
18	10	5	2
19	8	5	3
20	1	5	4
21	11	6	1
22	12	6	2
23	23	6	3
24	17	6	4
25	11	7	1
26	6	7	2
27	27	7	3
28	28	7	4
29	29	8	1
30	17	8	2
31	31	8	3
32	32	8	4
33	11	9	1
34	5	9	2
35	17	9	3
36	1	9	4
37	17	10	1
38	38	10	2
39	39	10	3
40	11	10	4
41	2	11	1
42	38	11	2
43	11	11	3
44	5	11	4
45	5	12	1
46	17	12	2
47	39	12	3
48	23	12	4
49	2	13	1
50	17	13	2
51	23	13	3
52	52	13	4
53	17	14	1
54	2	14	2
55	5	14	3
56	29	14	4
57	11	15	1
58	5	15	2
59	12	15	3
60	60	15	4
61	23	16	1
62	11	16	2
63	63	16	3
64	38	16	4
65	11	17	1
66	7	17	2
67	67	17	3
68	68	17	4
69	5	18	1
70	23	18	2
71	7	18	3
72	31	18	4
73	16	19	1
74	38	19	2
75	7	19	3
76	1	19	4
77	7	20	1
78	2	20	2
79	38	20	3
80	11	20	4
81	23	21	1
82	63	21	2
83	52	21	3
84	29	21	4
85	2	22	1
86	23	22	2
87	63	22	3
88	88	22	4
\.


--
-- Data for Name: participaciones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.participaciones (id, torneo_id, seleccion_id, grupo, posicion_grupo, fase_eliminada, entrenador, goles_favor, goles_contra, puntos, valor_mercado_millones) FROM stdin;
\.


--
-- Data for Name: partidos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.partidos (id, torneo_id, fase_id, estadio_id, seleccion_local_id, seleccion_visitante_id, fecha, hora_local, hora_utc, zona_horaria, grupo, jornada, goles_local, goles_visitante, goles_local_prorroga, goles_visitante_prorroga, penaltis_local, penaltis_visitante, hubo_prorroga, hubo_penaltis, arbitro, asistencia, clima_temperatura, clima_descripcion, clima_humedad, clima_viento_kmh, estado, minuto_actual, resumen_narrativo, curiosidades, sofascore_id, created_at, updated_at, hora_espana) FROM stdin;
7	23	1	15	93	94	2026-06-12	15:00:00	\N	America/Toronto	B	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186836	2026-05-23 10:00:13.722166	2026-05-23 14:04:12.027179	21:00:00
8	23	1	4	95	96	2026-06-13	15:00:00	\N	America/Los_Angeles	B	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186526	2026-05-23 10:00:13.779472	2026-05-23 14:04:12.029194	00:00:00
13	23	1	1	11	88	2026-06-13	18:00:00	\N	America/New_York	C	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186850	2026-05-23 10:00:14.099665	2026-05-23 14:04:12.032586	00:00:00
14	23	1	6	99	100	2026-06-13	21:00:00	\N	America/New_York	C	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186853	2026-05-23 10:00:14.132633	2026-05-23 14:04:12.03368	03:00:00
20	23	1	14	101	67	2026-06-14	00:00:00	\N	America/Vancouver	D	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186874	2026-05-23 10:00:14.445068	2026-05-23 14:04:12.035456	09:00:00
25	23	1	\N	7	104	2026-06-14	13:00:00	\N	America/Chicago	E	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186899	2026-05-23 10:00:14.621853	2026-05-23 14:04:12.038103	20:00:00
31	23	1	\N	38	106	2026-06-14	16:00:00	\N	America/Chicago	F	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186945	2026-05-23 10:00:14.916344	2026-05-23 14:04:12.040431	23:00:00
26	23	1	7	107	108	2026-06-14	19:00:00	\N	America/New_York	E	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186904	2026-05-23 10:00:14.656205	2026-05-23 14:04:12.042399	01:00:00
32	23	1	12	12	110	2026-06-14	22:00:00	\N	America/Chicago	F	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186951	2026-05-23 10:00:14.979093	2026-05-23 14:04:12.044822	05:00:00
43	23	1	\N	16	112	2026-06-15	12:00:00	\N	America/New_York	H	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186783	2026-05-23 10:00:15.517884	2026-05-23 14:04:12.046642	18:00:00
37	23	1	9	52	114	2026-06-15	15:00:00	\N	America/Los_Angeles	G	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186837	2026-05-23 10:00:15.197511	2026-05-23 14:04:12.047989	00:00:00
38	23	1	2	117	118	2026-06-15	21:00:00	\N	America/Los_Angeles	G	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186832	2026-05-23 10:00:15.242558	2026-05-23 14:04:12.051194	06:00:00
49	23	1	1	23	120	2026-06-16	15:00:00	\N	America/New_York	I	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186501	2026-05-23 10:00:15.780766	2026-05-23 14:04:12.05304	21:00:00
50	23	1	6	121	122	2026-06-16	18:00:00	\N	America/New_York	I	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186773	2026-05-23 10:00:15.818074	2026-05-23 14:04:12.054525	00:00:00
55	23	1	8	2	124	2026-06-16	21:00:00	\N	America/Chicago	J	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186854	2026-05-23 10:00:16.090256	2026-05-23 14:04:12.057173	04:00:00
56	23	1	4	8	126	2026-06-17	00:00:00	\N	America/Los_Angeles	J	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186751	2026-05-23 10:00:16.133975	2026-05-23 14:04:12.060207	09:00:00
3	23	1	\N	92	90	2026-06-18	12:00:00	\N	America/New_York	A	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186731	2026-05-23 10:00:13.571487	2026-05-23 14:04:12.067592	18:00:00
9	23	1	2	96	94	2026-06-18	15:00:00	\N	America/Los_Angeles	B	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186806	2026-05-23 10:00:13.844166	2026-05-23 14:04:12.068755	00:00:00
10	23	1	14	93	95	2026-06-18	18:00:00	\N	America/Vancouver	B	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186798	2026-05-23 10:00:13.917498	2026-05-23 14:04:12.070083	03:00:00
15	23	1	6	100	88	2026-06-19	18:00:00	\N	America/New_York	C	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186859	2026-05-23 10:00:14.215001	2026-05-23 14:04:12.076229	00:00:00
16	23	1	7	11	99	2026-06-19	20:30:00	\N	America/New_York	C	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186856	2026-05-23 10:00:14.259262	2026-05-23 14:04:12.079668	02:30:00
22	23	1	4	67	135	2026-06-19	23:00:00	\N	America/Los_Angeles	D	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186879	2026-05-23 10:00:14.5289	2026-05-23 14:04:12.081573	08:00:00
33	23	1	\N	38	12	2026-06-20	13:00:00	\N	America/Chicago	F	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186957	2026-05-23 10:00:15.031962	2026-05-23 14:04:12.083201	20:00:00
27	23	1	15	7	107	2026-06-20	16:00:00	\N	America/Toronto	E	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186905	2026-05-23 10:00:14.696819	2026-05-23 14:04:12.085057	22:00:00
28	23	1	8	108	104	2026-06-20	20:00:00	\N	America/Chicago	E	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186906	2026-05-23 10:00:14.749264	2026-05-23 14:04:12.088552	03:00:00
34	23	1	12	110	106	2026-06-21	00:00:00	\N	America/Chicago	F	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186963	2026-05-23 10:00:15.080074	2026-05-23 14:04:12.092618	07:00:00
45	23	1	\N	16	115	2026-06-21	12:00:00	\N	America/New_York	H	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186840	2026-05-23 10:00:15.606755	2026-05-23 14:04:12.094288	18:00:00
39	23	1	2	52	117	2026-06-21	15:00:00	\N	America/Los_Angeles	G	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186499	2026-05-23 10:00:15.300227	2026-05-23 14:04:12.095656	00:00:00
46	23	1	5	1	112	2026-06-21	18:00:00	\N	America/New_York	H	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186800	2026-05-23 10:00:15.650791	2026-05-23 14:04:12.096798	00:00:00
57	23	1	\N	2	8	2026-06-22	13:00:00	\N	America/Chicago	J	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186502	2026-05-23 10:00:16.19389	2026-05-23 14:04:12.099625	20:00:00
51	23	1	7	23	121	2026-06-22	17:00:00	\N	America/New_York	I	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186769	2026-05-23 10:00:15.864639	2026-05-23 14:04:12.10111	23:00:00
52	23	1	1	122	120	2026-06-22	20:00:00	\N	America/New_York	I	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186770	2026-05-23 10:00:15.920899	2026-05-23 14:04:12.102496	02:00:00
58	23	1	4	126	124	2026-06-22	23:00:00	\N	America/Los_Angeles	J	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186740	2026-05-23 10:00:16.244689	2026-05-23 14:04:12.105279	08:00:00
11	23	1	14	96	93	2026-06-24	15:00:00	\N	America/Vancouver	B	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186821	2026-05-23 10:00:14.001411	2026-05-23 14:04:12.114361	00:00:00
12	23	1	9	94	95	2026-06-24	15:00:00	\N	America/Los_Angeles	B	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186829	2026-05-23 10:00:14.050994	2026-05-23 14:04:12.115722	00:00:00
17	23	1	5	100	11	2026-06-24	18:00:00	\N	America/New_York	C	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186861	2026-05-23 10:00:14.315005	2026-05-23 14:04:12.117025	00:00:00
18	23	1	\N	88	99	2026-06-24	18:00:00	\N	America/New_York	C	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186864	2026-05-23 10:00:14.366222	2026-05-23 14:04:12.118127	00:00:00
5	23	1	11	92	89	2026-06-24	21:00:00	\N	America/Mexico_City	A	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186732	2026-05-23 10:00:13.642109	2026-05-23 14:04:12.11912	04:00:00
6	23	1	12	90	68	2026-06-24	21:00:00	\N	America/Mexico_City	A	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186744	2026-05-23 10:00:13.678059	2026-05-23 14:04:12.121234	04:00:00
29	23	1	7	104	107	2026-06-25	16:00:00	\N	America/New_York	E	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186908	2026-05-23 10:00:14.785053	2026-05-23 14:04:12.125854	22:00:00
36	23	1	8	110	38	2026-06-25	19:00:00	\N	America/Chicago	F	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186973	2026-05-23 10:00:15.152139	2026-05-23 14:04:12.127139	02:00:00
35	23	1	\N	106	12	2026-06-25	19:00:00	\N	America/Chicago	F	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186972	2026-05-23 10:00:15.115623	2026-05-23 14:04:12.12819	02:00:00
24	23	1	4	135	101	2026-06-25	22:00:00	\N	America/Los_Angeles	D	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186891	2026-05-23 10:00:14.591744	2026-05-23 14:04:12.129313	07:00:00
53	23	1	6	122	23	2026-06-26	15:00:00	\N	America/New_York	I	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186537	2026-05-23 10:00:15.993878	2026-05-23 14:04:12.131383	21:00:00
54	23	1	15	120	121	2026-06-26	15:00:00	\N	America/Toronto	I	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186771	2026-05-23 10:00:16.047354	2026-05-23 14:04:12.134763	21:00:00
48	23	1	13	1	16	2026-06-26	20:00:00	\N	America/Chicago	H	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186841	2026-05-23 10:00:15.745879	2026-05-23 14:04:12.13585	03:00:00
47	23	1	\N	112	115	2026-06-26	20:00:00	\N	America/Chicago	H	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186803	2026-05-23 10:00:15.703508	2026-05-23 14:04:12.13772	03:00:00
41	23	1	9	114	117	2026-06-26	23:00:00	\N	America/Los_Angeles	G	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186828	2026-05-23 10:00:15.399594	2026-05-23 14:04:12.140021	08:00:00
59	23	1	8	124	8	2026-06-27	22:00:00	\N	America/Chicago	J	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186747	2026-05-23 10:00:16.283226	2026-05-23 14:04:12.151019	05:00:00
19	23	1	2	3	135	2026-06-12	21:00:00	\N	America/Los_Angeles	D	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186873	2026-05-23 10:00:14.413597	2026-05-23 14:13:58.217597	06:00:00
73	23	2	2	\N	\N	2026-06-28	15:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 73, "local_desc" : "2o A", "visitante_desc" : "2o B"}	\N	2026-05-23 10:00:16.860546	2026-05-23 10:00:16.860546	21:00:00
74	23	2	6	\N	\N	2026-06-29	16:30:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 74, "local_desc" : "1o E", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:16.888167	2026-05-23 10:00:16.888167	22:30:00
75	23	2	12	\N	\N	2026-06-29	23:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 75, "local_desc" : "1o F", "visitante_desc" : "2o C"}	\N	2026-05-23 10:00:16.928288	2026-05-23 10:00:16.928288	05:00:00
76	23	2	\N	\N	\N	2026-06-29	13:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 76, "local_desc" : "1o C", "visitante_desc" : "2o F"}	\N	2026-05-23 10:00:16.962803	2026-05-23 10:00:16.962803	19:00:00
77	23	2	1	\N	\N	2026-06-30	17:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 77, "local_desc" : "1o I", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.015161	2026-05-23 10:00:17.015161	23:00:00
78	23	2	\N	\N	\N	2026-06-30	13:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 78, "local_desc" : "2o E", "visitante_desc" : "2o I"}	\N	2026-05-23 10:00:17.079868	2026-05-23 10:00:17.079868	19:00:00
79	23	2	11	\N	\N	2026-06-30	21:00:00	\N	America/Mexico_City	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 79, "local_desc" : "1o A", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.128655	2026-05-23 10:00:17.128655	04:00:00
80	23	2	\N	\N	\N	2026-07-01	12:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 80, "local_desc" : "1o L", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.174428	2026-05-23 10:00:17.174428	18:00:00
81	23	2	4	\N	\N	2026-07-01	20:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 81, "local_desc" : "1o D", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.217322	2026-05-23 10:00:17.217322	05:00:00
82	23	2	9	\N	\N	2026-07-01	16:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 82, "local_desc" : "1o G", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.254329	2026-05-23 10:00:17.254329	22:00:00
83	23	2	15	\N	\N	2026-07-02	19:00:00	\N	America/Toronto	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 83, "local_desc" : "2o K", "visitante_desc" : "2o L"}	\N	2026-05-23 10:00:17.307673	2026-05-23 10:00:17.307673	01:00:00
84	23	2	2	\N	\N	2026-07-02	15:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 84, "local_desc" : "1o H", "visitante_desc" : "2o J"}	\N	2026-05-23 10:00:17.351357	2026-05-23 10:00:17.351357	21:00:00
85	23	2	14	\N	\N	2026-07-02	23:00:00	\N	America/Vancouver	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 85, "local_desc" : "1o B", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.39759	2026-05-23 10:00:17.39759	07:00:00
86	23	2	5	\N	\N	2026-07-03	18:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 86, "local_desc" : "1o J", "visitante_desc" : "2o H"}	\N	2026-05-23 10:00:17.43741	2026-05-23 10:00:17.43741	00:00:00
87	23	2	8	\N	\N	2026-07-03	21:30:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 87, "local_desc" : "1o K", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.50772	2026-05-23 10:00:17.50772	03:30:00
88	23	2	\N	\N	\N	2026-07-03	14:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 88, "local_desc" : "2o D", "visitante_desc" : "2o G"}	\N	2026-05-23 10:00:17.549921	2026-05-23 10:00:17.549921	20:00:00
89	23	3	7	\N	\N	2026-07-04	17:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 89, "local_desc" : "Gan 74", "visitante_desc" : "Gan 77"}	\N	2026-05-23 10:00:17.582932	2026-05-23 10:00:17.582932	23:00:00
90	23	3	\N	\N	\N	2026-07-04	13:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 90, "local_desc" : "Gan 73", "visitante_desc" : "Gan 75"}	\N	2026-05-23 10:00:17.628235	2026-05-23 10:00:17.628235	19:00:00
91	23	3	1	\N	\N	2026-07-05	16:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 91, "local_desc" : "Gan 76", "visitante_desc" : "Gan 78"}	\N	2026-05-23 10:00:17.667715	2026-05-23 10:00:17.667715	22:00:00
92	23	3	11	\N	\N	2026-07-05	20:00:00	\N	America/Mexico_City	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 92, "local_desc" : "Gan 79", "visitante_desc" : "Gan 80"}	\N	2026-05-23 10:00:17.72659	2026-05-23 10:00:17.72659	03:00:00
93	23	3	\N	\N	\N	2026-07-06	15:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 93, "local_desc" : "Gan 83", "visitante_desc" : "Gan 84"}	\N	2026-05-23 10:00:17.775332	2026-05-23 10:00:17.775332	21:00:00
94	23	3	9	\N	\N	2026-07-06	20:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 94, "local_desc" : "Gan 81", "visitante_desc" : "Gan 82"}	\N	2026-05-23 10:00:17.817561	2026-05-23 10:00:17.817561	05:00:00
95	23	3	\N	\N	\N	2026-07-07	12:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 95, "local_desc" : "Gan 86", "visitante_desc" : "Gan 88"}	\N	2026-05-23 10:00:17.857265	2026-05-23 10:00:17.857265	18:00:00
96	23	3	14	\N	\N	2026-07-07	16:00:00	\N	America/Vancouver	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 96, "local_desc" : "Gan 85", "visitante_desc" : "Gan 87"}	\N	2026-05-23 10:00:17.885628	2026-05-23 10:00:17.885628	23:00:00
97	23	4	6	\N	\N	2026-07-09	16:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 97, "local_desc" : "Gan 89", "visitante_desc" : "Gan 90"}	\N	2026-05-23 10:00:17.923943	2026-05-23 10:00:17.923943	22:00:00
98	23	4	2	\N	\N	2026-07-10	15:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 98, "local_desc" : "Gan 93", "visitante_desc" : "Gan 94"}	\N	2026-05-23 10:00:17.961315	2026-05-23 10:00:17.961315	22:00:00
99	23	4	5	\N	\N	2026-07-11	17:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 99, "local_desc" : "Gan 91", "visitante_desc" : "Gan 92"}	\N	2026-05-23 10:00:18.017148	2026-05-23 10:00:18.017148	23:00:00
100	23	4	8	\N	\N	2026-07-11	21:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 100, "local_desc" : "Gan 95", "visitante_desc" : "Gan 96"}	\N	2026-05-23 10:00:18.080897	2026-05-23 10:00:18.080897	04:00:00
101	23	5	\N	\N	\N	2026-07-14	15:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 101, "local_desc" : "Gan 97", "visitante_desc" : "Gan 98"}	\N	2026-05-23 10:00:18.147937	2026-05-23 10:00:18.147937	21:00:00
102	23	5	\N	\N	\N	2026-07-15	15:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 102, "local_desc" : "Gan 99", "visitante_desc" : "Gan 100"}	\N	2026-05-23 10:00:18.229611	2026-05-23 10:00:18.229611	21:00:00
103	23	6	5	\N	\N	2026-07-18	17:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 103, "local_desc" : "Per 101", "visitante_desc" : "Per 102"}	\N	2026-05-23 10:00:18.254997	2026-05-23 10:00:18.254997	23:00:00
104	23	7	1	\N	\N	2026-07-19	15:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 104, "local_desc" : "Gan 101", "visitante_desc" : "Gan 102"}	\N	2026-05-23 10:00:18.299784	2026-05-23 10:00:18.299784	21:00:00
67	23	1	\N	29	63	2026-06-17	16:00:00	\N	America/Chicago	L	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186504	2026-05-23 10:00:16.646065	2026-05-23 14:04:12.063029	23:00:00
68	23	1	15	131	132	2026-06-17	19:00:00	\N	America/Toronto	L	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186687	2026-05-23 10:00:16.688076	2026-05-23 14:04:12.064397	01:00:00
62	23	1	11	133	134	2026-06-17	22:00:00	\N	America/Chicago	K	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186722	2026-05-23 10:00:16.426046	2026-05-23 14:04:12.065848	05:00:00
63	23	1	\N	31	133	2026-06-23	13:00:00	\N	America/Chicago	K	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186858	2026-05-23 10:00:16.469294	2026-05-23 14:04:12.109161	20:00:00
69	23	1	6	29	131	2026-06-23	16:00:00	\N	America/New_York	L	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186672	2026-05-23 10:00:16.727657	2026-05-23 14:04:12.110457	22:00:00
70	23	1	15	132	63	2026-06-23	19:00:00	\N	America/Toronto	L	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186520	2026-05-23 10:00:16.765785	2026-05-23 14:04:12.111587	01:00:00
64	23	1	13	134	128	2026-06-23	22:00:00	\N	America/Chicago	K	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186713	2026-05-23 10:00:16.52133	2026-05-23 14:04:12.112635	05:00:00
71	23	1	1	132	29	2026-06-27	17:00:00	\N	America/New_York	L	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186676	2026-05-23 10:00:16.80033	2026-05-23 14:04:12.144492	23:00:00
72	23	1	7	63	131	2026-06-27	17:00:00	\N	America/New_York	L	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186624	2026-05-23 10:00:16.830063	2026-05-23 14:04:12.145553	23:00:00
66	23	1	\N	128	133	2026-06-27	19:30:00	\N	America/New_York	K	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186717	2026-05-23 10:00:16.601451	2026-05-23 14:04:12.147696	01:30:00
60	23	1	\N	126	2	2026-06-27	22:00:00	\N	America/Chicago	J	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186734	2026-05-23 10:00:16.33336	2026-05-23 14:04:12.149239	05:00:00
1	23	1	11	89	90	2026-06-11	21:00:00	\N	America/Mexico_City	A	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186710	2026-05-23 10:00:13.468581	2026-05-23 14:04:12.012358	03:00:00
2	23	1	13	68	92	2026-06-11	20:00:00	\N	America/Mexico_City	A	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186720	2026-05-23 10:00:13.533198	2026-05-23 14:04:12.02511	03:00:00
44	23	1	5	115	1	2026-06-15	18:00:00	\N	America/New_York	H	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186811	2026-05-23 10:00:15.566425	2026-05-23 14:04:12.049265	00:00:00
61	23	1	\N	31	128	2026-06-17	13:00:00	\N	America/Chicago	K	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186709	2026-05-23 10:00:16.381236	2026-05-23 14:04:12.061736	20:00:00
4	23	1	13	89	68	2026-06-18	21:00:00	\N	America/Mexico_City	A	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186490	2026-05-23 10:00:13.609473	2026-05-23 14:04:12.073071	04:00:00
40	23	1	14	118	114	2026-06-21	21:00:00	\N	America/Los_Angeles	G	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186827	2026-05-23 10:00:15.351624	2026-05-23 14:04:12.097952	06:00:00
30	23	1	1	108	7	2026-06-25	16:00:00	\N	America/New_York	E	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186907	2026-05-23 10:00:14.835759	2026-05-23 14:04:12.123953	22:00:00
42	23	1	14	118	52	2026-06-26	23:00:00	\N	America/Los_Angeles	G	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186822	2026-05-23 10:00:15.464225	2026-05-23 14:04:12.14272	08:00:00
65	23	1	5	134	31	2026-06-27	19:30:00	\N	America/New_York	K	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186696	2026-05-23 10:00:16.563465	2026-05-23 14:04:12.146645	01:30:00
21	23	1	9	3	101	2026-06-19	15:00:00	\N	America/Los_Angeles	D	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186878	2026-05-23 10:00:14.483081	2026-05-23 14:13:58.217597	00:00:00
23	23	1	2	67	3	2026-06-25	22:00:00	\N	America/Los_Angeles	D	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186887	2026-05-23 10:00:14.560526	2026-05-23 14:15:26.539099	07:00:00
\.


--
-- Data for Name: selecciones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.selecciones (id, nombre, nombre_fifa, codigo_fifa, confederacion, bandera_url, color_principal, color_secundario, mundiales_jugados, mundiales_ganados, partidos_jugados, partidos_ganados, partidos_empatados, partidos_perdidos, goles_favor, goles_contra, ficha_narrativa, curiosidades, created_at) FROM stdin;
4	Yugoslavia[a]	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:03.13711
3	USA	\N	USA	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:03.13711
10	Hungary	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:12.284228
6	Czechoslovakia	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:07.646263
27	Chile	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:30.965658
28	Yugoslavia	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:30.965658
89	Mexico	\N	MEX	CONCACAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
32	Soviet Union	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:35.580422
90	South Africa	\N	RSA	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
68	South Korea	\N	KOR	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:52:17.469176
92	Czechia	\N	CZE	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
93	Canada	\N	CAN	CONCACAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
94	Bosnia Herzegovina	\N	BIH	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
95	Qatar	\N	QAT	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
96	Switzerland	\N	SUI	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
11	Brazil	\N	BRA	CONMEBOL	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:12.284228
88	Morocco	\N	MAR	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:52:41.963246
99	Haiti	\N	HAI	CONCACAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
100	Scotland	\N	SCO	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
101	Australia	\N	AUS	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
39	Poland	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:44.771656
67	Turkey	\N	TUR	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:52:17.469176
7	Germany	\N	GER	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:07.646263
104	Curacao	\N	CUW	CONCACAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
38	Netherlands	\N	NED	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:44.771656
17	West Germany	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:21.712175
106	Japan	\N	JPN	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
107	Ivory Coast	\N	CIV	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
108	Ecuador	\N	ECU	CONMEBOL	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
60	Bulgaria	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:52:08.17348
12	Sweden	\N	SWE	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:12.284228
110	Tunisia	\N	TUN	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
16	Spain	\N	ESP	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:17.140558
112	Cape Verde	\N	CPV	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
5	Italy	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:07.646263
52	Belgium	\N	BEL	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:58.797784
114	Egypt	\N	EGY	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
115	Saudi Arabia	\N	KSA	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
1	Uruguay	\N	URU	CONMEBOL	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:03.13711
117	Iran	\N	IRN	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
118	New Zealand	\N	NZL	OFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
23	France	\N	FRA	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:26.293723
120	Senegal	\N	SEN	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
121	Iraq	\N	IRQ	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
122	Norway	\N	NOR	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
2	Argentina	\N	ARG	CONMEBOL	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:03.13711
124	Algeria	\N	ALG	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
8	Austria	\N	AUT	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:07.646263
126	Jordan	\N	JOR	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
31	Portugal	\N	POR	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:35.580422
128	DR Congo	\N	COD	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
29	England	\N	ENG	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:51:35.580422
63	Croatia	\N	CRO	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 09:52:12.849807
131	Ghana	\N	GHA	CAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
132	Panama	\N	PAN	CONCACAF	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
133	Uzbekistan	\N	UZB	AFC	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
134	Colombia	\N	COL	CONMEBOL	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
135	Paraguay	\N	PAR	CONMEBOL	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
136	Denmark	\N	DEN	UEFA	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-23 10:00:13.428226
\.


--
-- Data for Name: torneos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.torneos (id, anyo, nombre, pais_sede, paises_sede, fecha_inicio, fecha_fin, num_equipos, num_partidos, goles_totales, media_goles, campeon, subcampeon, tercer_puesto, cuarto_puesto, maximo_goleador, curiosidades, narrativa, created_at) FROM stdin;
1	1930	FIFA World Cup 1930	Uruguay	\N	\N	\N	13	18	70	3.89	Uruguay	Argentina	United States[a]	Yugoslavia[a]	Guillermo Stábile(8 goals)	\N	\N	2026-05-23 09:51:03.130935
2	1934	FIFA World Cup 1934	Italy	\N	\N	\N	16	17	70	4.12	Italy	Czechoslovakia	Germany	Austria	Oldřich Nejedlý(5 goals)	\N	\N	2026-05-23 09:51:07.642237
3	1938	FIFA World Cup 1938	France	\N	\N	\N	15	18	84	4.67	Italy	Hungary	Brazil	Sweden	Leônidas (7 goals)	\N	\N	2026-05-23 09:51:12.279795
4	1950	FIFA World Cup 1950	Brazil	\N	\N	\N	13	22	88	4.00	Uruguay	Brazil	Sweden	Spain	Ademir (9 goals)	\N	\N	2026-05-23 09:51:17.136361
5	1954	FIFA World Cup 1954	Switzerland	\N	\N	\N	16	26	140	5.38	West Germany	Hungary	Austria	Uruguay	Sándor Kocsis (11 goals)	\N	\N	2026-05-23 09:51:21.708157
6	1958	FIFA World Cup 1958	Sweden	\N	\N	\N	16	35	126	3.60	Brazil	Sweden	France	West Germany	Just Fontaine (13 goals)	\N	\N	2026-05-23 09:51:26.289634
7	1962	FIFA World Cup 1962	Chile	\N	\N	\N	16	32	89	2.78	Brazil	Czechoslovakia	Chile	Yugoslavia	Garrincha Vavá Leonel Sánchez Flórián Albert Valentin Ivanov Dražan Jerković(4 goals each)	\N	\N	2026-05-23 09:51:30.934362
8	1966	FIFA World Cup 1966	England	\N	\N	\N	16	32	89	2.78	England	West Germany	Portugal	Soviet Union	Eusébio (9 goals)	\N	\N	2026-05-23 09:51:35.550235
9	1970	FIFA World Cup 1970	Mexico	\N	\N	\N	16	32	95	2.97	Brazil	Italy	West Germany	Uruguay	Gerd Müller (10 goals)	\N	\N	2026-05-23 09:51:40.199728
10	1974	FIFA World Cup 1974	West Germany	\N	\N	\N	16	38	97	2.55	West Germany	Netherlands	Poland	Brazil	Grzegorz Lato (7 goals)	\N	\N	2026-05-23 09:51:44.770239
11	1978	FIFA World Cup 1978	Argentina	\N	\N	\N	16	38	102	2.68	Argentina	Netherlands	Brazil	Italy	Mario Kempes (6 goals)	\N	\N	2026-05-23 09:51:49.412252
12	1982	FIFA World Cup 1982	Spain	\N	\N	\N	24	52	146	2.81	Italy	West Germany	Poland	France	Paolo Rossi (6 goals)	\N	\N	2026-05-23 09:51:54.117207
13	1986	FIFA World Cup 1986	Mexico	\N	\N	\N	24	52	132	2.54	Argentina	West Germany	France	Belgium	Gary Lineker (6 goals)	\N	\N	2026-05-23 09:51:58.766552
14	1990	FIFA World Cup 1990	Italy	\N	\N	\N	24	52	115	2.21	West Germany	Argentina	Italy	England	Salvatore Schillaci (6 goals)	\N	\N	2026-05-23 09:52:03.513395
15	1994	FIFA World Cup 1994	United States	\N	\N	\N	24	52	141	2.71	Brazil	Italy	Sweden	Bulgaria	Hristo Stoichkov Oleg Salenko(6 goals each)	\N	\N	2026-05-23 09:52:08.169115
16	1998	FIFA World Cup 1998	France	\N	\N	\N	32	64	171	2.67	France	Brazil	Croatia	Netherlands	Davor Šuker (6 goals)	\N	\N	2026-05-23 09:52:12.845319
17	2002	FIFA World Cup 2002	JapanSouth Korea	\N	\N	\N	32	64	161	2.52	Brazil	Germany	Turkey	South Korea	Ronaldo (8 goals)	\N	\N	2026-05-23 09:52:17.464847
18	2006	FIFA World Cup 2006	Germany	\N	\N	\N	32	64	147	2.30	Italy	France	Germany	Portugal	Miroslav Klose(5 goals)	\N	\N	2026-05-23 09:52:22.269544
19	2010	FIFA World Cup 2010	South Africa	\N	\N	\N	32	64	145	2.27	Spain	Netherlands	Germany	Uruguay	Diego Forlán Thomas Müller Wesley Sneijder David Villa(5 goals each)	\N	\N	2026-05-23 09:52:27.036355
20	2014	FIFA World Cup 2014	Brazil	\N	\N	\N	32	64	171	2.67	Germany	Argentina	Netherlands	Brazil	James Rodríguez(6 goals)	\N	\N	2026-05-23 09:52:31.83635
21	2018	FIFA World Cup 2018	Russia	\N	\N	\N	32	64	169	2.64	France	Croatia	Belgium	England	Harry Kane (6 goals)	\N	\N	2026-05-23 09:52:36.942528
22	2022	FIFA World Cup 2022	Qatar	\N	\N	\N	32	64	172	2.69	Argentina	France	Croatia	Morocco	Kylian Mbappé (8 goals)	\N	\N	2026-05-23 09:52:41.958914
23	2026	FIFA World Cup 2026	USA/Mexico/Canada	{"Estados Unidos",Mexico,Canada}	2026-06-11	2026-07-19	48	104	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-05-23 10:00:13.399549
\.


--
-- Name: clima_live_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.clima_live_id_seq', 1, false);


--
-- Name: convocatorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.convocatorias_id_seq', 1, false);


--
-- Name: estadios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estadios_id_seq', 16, true);


--
-- Name: estadisticas_partido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.estadisticas_partido_id_seq', 1, false);


--
-- Name: eventos_partido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.eventos_partido_id_seq', 1, false);


--
-- Name: fases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fases_id_seq', 7, true);


--
-- Name: goleadores_torneo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.goleadores_torneo_id_seq', 1, false);


--
-- Name: ia_generaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ia_generaciones_id_seq', 1, false);


--
-- Name: jugadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jugadores_id_seq', 1, false);


--
-- Name: palmares_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.palmares_id_seq', 88, true);


--
-- Name: participaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.participaciones_id_seq', 1, false);


--
-- Name: partidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.partidos_id_seq', 104, true);


--
-- Name: selecciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.selecciones_id_seq', 136, true);


--
-- Name: torneos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.torneos_id_seq', 23, true);


--
-- Name: clima_live clima_live_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clima_live
    ADD CONSTRAINT clima_live_pkey PRIMARY KEY (id);


--
-- Name: convocatorias convocatorias_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_pkey PRIMARY KEY (id);


--
-- Name: convocatorias convocatorias_torneo_id_jugador_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_torneo_id_jugador_id_key UNIQUE (torneo_id, jugador_id);


--
-- Name: estadios estadios_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadios
    ADD CONSTRAINT estadios_pkey PRIMARY KEY (id);


--
-- Name: estadisticas_partido estadisticas_partido_partido_id_seleccion_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadisticas_partido
    ADD CONSTRAINT estadisticas_partido_partido_id_seleccion_id_key UNIQUE (partido_id, seleccion_id);


--
-- Name: estadisticas_partido estadisticas_partido_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadisticas_partido
    ADD CONSTRAINT estadisticas_partido_pkey PRIMARY KEY (id);


--
-- Name: eventos_partido eventos_partido_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.eventos_partido
    ADD CONSTRAINT eventos_partido_pkey PRIMARY KEY (id);


--
-- Name: fases fases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fases
    ADD CONSTRAINT fases_pkey PRIMARY KEY (id);


--
-- Name: fases fases_torneo_id_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fases
    ADD CONSTRAINT fases_torneo_id_nombre_key UNIQUE (torneo_id, nombre);


--
-- Name: goleadores_torneo goleadores_torneo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goleadores_torneo
    ADD CONSTRAINT goleadores_torneo_pkey PRIMARY KEY (id);


--
-- Name: goleadores_torneo goleadores_torneo_torneo_id_jugador_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goleadores_torneo
    ADD CONSTRAINT goleadores_torneo_torneo_id_jugador_id_key UNIQUE (torneo_id, jugador_id);


--
-- Name: ia_generaciones ia_generaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ia_generaciones
    ADD CONSTRAINT ia_generaciones_pkey PRIMARY KEY (id);


--
-- Name: jugadores jugadores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jugadores
    ADD CONSTRAINT jugadores_pkey PRIMARY KEY (id);


--
-- Name: palmares palmares_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.palmares
    ADD CONSTRAINT palmares_pkey PRIMARY KEY (id);


--
-- Name: palmares palmares_torneo_id_posicion_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.palmares
    ADD CONSTRAINT palmares_torneo_id_posicion_key UNIQUE (torneo_id, posicion);


--
-- Name: participaciones participaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_pkey PRIMARY KEY (id);


--
-- Name: participaciones participaciones_torneo_id_seleccion_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_torneo_id_seleccion_id_key UNIQUE (torneo_id, seleccion_id);


--
-- Name: partidos partidos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_pkey PRIMARY KEY (id);


--
-- Name: selecciones selecciones_codigo_fifa_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selecciones
    ADD CONSTRAINT selecciones_codigo_fifa_key UNIQUE (codigo_fifa);


--
-- Name: selecciones selecciones_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selecciones
    ADD CONSTRAINT selecciones_nombre_key UNIQUE (nombre);


--
-- Name: selecciones selecciones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selecciones
    ADD CONSTRAINT selecciones_pkey PRIMARY KEY (id);


--
-- Name: torneos torneos_anyo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.torneos
    ADD CONSTRAINT torneos_anyo_key UNIQUE (anyo);


--
-- Name: torneos torneos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.torneos
    ADD CONSTRAINT torneos_pkey PRIMARY KEY (id);


--
-- Name: idx_clima_live_estadio; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clima_live_estadio ON public.clima_live USING btree (estadio_id);


--
-- Name: idx_clima_live_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clima_live_timestamp ON public.clima_live USING btree ("timestamp");


--
-- Name: idx_eventos_partido; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_eventos_partido ON public.eventos_partido USING btree (partido_id);


--
-- Name: idx_eventos_tipo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_eventos_tipo ON public.eventos_partido USING btree (tipo);


--
-- Name: idx_goleadores_torneo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_goleadores_torneo ON public.goleadores_torneo USING btree (torneo_id);


--
-- Name: idx_participaciones_seleccion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_participaciones_seleccion ON public.participaciones USING btree (seleccion_id);


--
-- Name: idx_participaciones_torneo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_participaciones_torneo ON public.participaciones USING btree (torneo_id);


--
-- Name: idx_partidos_estado; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_partidos_estado ON public.partidos USING btree (estado);


--
-- Name: idx_partidos_fecha; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_partidos_fecha ON public.partidos USING btree (fecha);


--
-- Name: idx_partidos_torneo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_partidos_torneo ON public.partidos USING btree (torneo_id);


--
-- Name: partidos trigger_partidos_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_partidos_updated_at BEFORE UPDATE ON public.partidos FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();


--
-- Name: clima_live clima_live_estadio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clima_live
    ADD CONSTRAINT clima_live_estadio_id_fkey FOREIGN KEY (estadio_id) REFERENCES public.estadios(id);


--
-- Name: convocatorias convocatorias_jugador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES public.jugadores(id);


--
-- Name: convocatorias convocatorias_seleccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_seleccion_id_fkey FOREIGN KEY (seleccion_id) REFERENCES public.selecciones(id);


--
-- Name: convocatorias convocatorias_torneo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.convocatorias
    ADD CONSTRAINT convocatorias_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES public.torneos(id);


--
-- Name: estadisticas_partido estadisticas_partido_partido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadisticas_partido
    ADD CONSTRAINT estadisticas_partido_partido_id_fkey FOREIGN KEY (partido_id) REFERENCES public.partidos(id);


--
-- Name: estadisticas_partido estadisticas_partido_seleccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.estadisticas_partido
    ADD CONSTRAINT estadisticas_partido_seleccion_id_fkey FOREIGN KEY (seleccion_id) REFERENCES public.selecciones(id);


--
-- Name: eventos_partido eventos_partido_jugador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.eventos_partido
    ADD CONSTRAINT eventos_partido_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES public.jugadores(id);


--
-- Name: eventos_partido eventos_partido_jugador_secundario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.eventos_partido
    ADD CONSTRAINT eventos_partido_jugador_secundario_id_fkey FOREIGN KEY (jugador_secundario_id) REFERENCES public.jugadores(id);


--
-- Name: eventos_partido eventos_partido_partido_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.eventos_partido
    ADD CONSTRAINT eventos_partido_partido_id_fkey FOREIGN KEY (partido_id) REFERENCES public.partidos(id);


--
-- Name: eventos_partido eventos_partido_seleccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.eventos_partido
    ADD CONSTRAINT eventos_partido_seleccion_id_fkey FOREIGN KEY (seleccion_id) REFERENCES public.selecciones(id);


--
-- Name: fases fases_torneo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fases
    ADD CONSTRAINT fases_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES public.torneos(id);


--
-- Name: goleadores_torneo goleadores_torneo_jugador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goleadores_torneo
    ADD CONSTRAINT goleadores_torneo_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES public.jugadores(id);


--
-- Name: goleadores_torneo goleadores_torneo_seleccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goleadores_torneo
    ADD CONSTRAINT goleadores_torneo_seleccion_id_fkey FOREIGN KEY (seleccion_id) REFERENCES public.selecciones(id);


--
-- Name: goleadores_torneo goleadores_torneo_torneo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goleadores_torneo
    ADD CONSTRAINT goleadores_torneo_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES public.torneos(id);


--
-- Name: jugadores jugadores_seleccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jugadores
    ADD CONSTRAINT jugadores_seleccion_id_fkey FOREIGN KEY (seleccion_id) REFERENCES public.selecciones(id);


--
-- Name: palmares palmares_seleccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.palmares
    ADD CONSTRAINT palmares_seleccion_id_fkey FOREIGN KEY (seleccion_id) REFERENCES public.selecciones(id);


--
-- Name: palmares palmares_torneo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.palmares
    ADD CONSTRAINT palmares_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES public.torneos(id);


--
-- Name: participaciones participaciones_seleccion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_seleccion_id_fkey FOREIGN KEY (seleccion_id) REFERENCES public.selecciones(id);


--
-- Name: participaciones participaciones_torneo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participaciones
    ADD CONSTRAINT participaciones_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES public.torneos(id);


--
-- Name: partidos partidos_estadio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_estadio_id_fkey FOREIGN KEY (estadio_id) REFERENCES public.estadios(id);


--
-- Name: partidos partidos_fase_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_fase_id_fkey FOREIGN KEY (fase_id) REFERENCES public.fases(id);


--
-- Name: partidos partidos_seleccion_local_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_seleccion_local_id_fkey FOREIGN KEY (seleccion_local_id) REFERENCES public.selecciones(id);


--
-- Name: partidos partidos_seleccion_visitante_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_seleccion_visitante_id_fkey FOREIGN KEY (seleccion_visitante_id) REFERENCES public.selecciones(id);


--
-- Name: partidos partidos_torneo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES public.torneos(id);


--
-- PostgreSQL database dump complete
--

\unrestrict l6CKPO8XzwBIgwflLjLSSRgd7bUCtnzH7L7lye7DIUPUM7U7AQAZWdV9eI9BI1K

