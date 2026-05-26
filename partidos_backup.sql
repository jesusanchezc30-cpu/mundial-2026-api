--
-- PostgreSQL database dump
--

\restrict 8XX2y7fjIFP72AK36lbTRTFp3B6bBO8fTn7n9nndglRyk6dd5duHbTFcmGZPgMd

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

SET default_tablespace = '';

SET default_table_access_method = heap;

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
    hora_espana time without time zone,
    fecha_espana date
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
-- Name: partidos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos ALTER COLUMN id SET DEFAULT nextval('public.partidos_id_seq'::regclass);


--
-- Data for Name: partidos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.partidos (id, torneo_id, fase_id, estadio_id, seleccion_local_id, seleccion_visitante_id, fecha, hora_local, hora_utc, zona_horaria, grupo, jornada, goles_local, goles_visitante, goles_local_prorroga, goles_visitante_prorroga, penaltis_local, penaltis_visitante, hubo_prorroga, hubo_penaltis, arbitro, asistencia, clima_temperatura, clima_descripcion, clima_humedad, clima_viento_kmh, estado, minuto_actual, resumen_narrativo, curiosidades, sofascore_id, created_at, updated_at, hora_espana, fecha_espana) FROM stdin;
7	23	1	15	93	94	2026-06-12	15:00:00	\N	America/Toronto	B	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186836	2026-05-23 10:00:13.722166	2026-05-25 19:43:09.581656	21:00:00	2026-06-12
19	23	1	2	3	135	2026-06-12	21:00:00	\N	America/Los_Angeles	D	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186873	2026-05-23 10:00:14.413597	2026-05-25 19:43:09.581656	03:00:00	2026-06-13
8	23	1	4	95	96	2026-06-13	15:00:00	\N	America/Los_Angeles	B	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186526	2026-05-23 10:00:13.779472	2026-05-25 19:43:09.581656	21:00:00	2026-06-13
13	23	1	1	11	88	2026-06-13	18:00:00	\N	America/New_York	C	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186850	2026-05-23 10:00:14.099665	2026-05-25 19:43:09.581656	00:00:00	2026-06-14
14	23	1	6	99	100	2026-06-13	21:00:00	\N	America/New_York	C	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186853	2026-05-23 10:00:14.132633	2026-05-25 19:43:09.581656	03:00:00	2026-06-14
20	23	1	14	101	67	2026-06-14	00:00:00	\N	America/Vancouver	D	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186874	2026-05-23 10:00:14.445068	2026-05-25 19:43:09.581656	06:00:00	2026-06-14
26	23	1	7	107	108	2026-06-14	19:00:00	\N	America/New_York	E	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186904	2026-05-23 10:00:14.656205	2026-05-25 19:43:09.581656	01:00:00	2026-06-15
43	23	1	\N	16	112	2026-06-15	12:00:00	\N	America/New_York	H	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186783	2026-05-23 10:00:15.517884	2026-05-25 19:43:09.581656	18:00:00	2026-06-15
49	23	1	1	23	120	2026-06-16	15:00:00	\N	America/New_York	I	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186501	2026-05-23 10:00:15.780766	2026-05-25 19:43:09.581656	21:00:00	2026-06-16
50	23	1	6	121	122	2026-06-16	18:00:00	\N	America/New_York	I	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186773	2026-05-23 10:00:15.818074	2026-05-25 19:43:09.581656	00:00:00	2026-06-17
3	23	1	\N	92	90	2026-06-18	12:00:00	\N	America/New_York	A	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186731	2026-05-23 10:00:13.571487	2026-05-25 19:43:09.581656	18:00:00	2026-06-18
15	23	1	6	100	88	2026-06-19	18:00:00	\N	America/New_York	C	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186859	2026-05-23 10:00:14.215001	2026-05-25 19:43:09.581656	00:00:00	2026-06-20
16	23	1	7	11	99	2026-06-19	20:30:00	\N	America/New_York	C	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186856	2026-05-23 10:00:14.259262	2026-05-25 19:43:09.581656	02:30:00	2026-06-20
27	23	1	15	7	107	2026-06-20	16:00:00	\N	America/Toronto	E	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186905	2026-05-23 10:00:14.696819	2026-05-25 19:43:09.581656	22:00:00	2026-06-20
45	23	1	\N	16	115	2026-06-21	12:00:00	\N	America/New_York	H	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186840	2026-05-23 10:00:15.606755	2026-05-25 19:43:09.581656	18:00:00	2026-06-21
46	23	1	5	1	112	2026-06-21	18:00:00	\N	America/New_York	H	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186800	2026-05-23 10:00:15.650791	2026-05-25 19:43:09.581656	00:00:00	2026-06-22
51	23	1	7	23	121	2026-06-22	17:00:00	\N	America/New_York	I	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186769	2026-05-23 10:00:15.864639	2026-05-25 19:43:09.581656	23:00:00	2026-06-22
52	23	1	1	122	120	2026-06-22	20:00:00	\N	America/New_York	I	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186770	2026-05-23 10:00:15.920899	2026-05-25 19:43:09.581656	02:00:00	2026-06-23
17	23	1	5	100	11	2026-06-24	18:00:00	\N	America/New_York	C	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186861	2026-05-23 10:00:14.315005	2026-05-25 19:43:09.581656	00:00:00	2026-06-25
18	23	1	\N	88	99	2026-06-24	18:00:00	\N	America/New_York	C	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186864	2026-05-23 10:00:14.366222	2026-05-25 19:43:09.581656	00:00:00	2026-06-25
29	23	1	7	104	107	2026-06-25	16:00:00	\N	America/New_York	E	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186908	2026-05-23 10:00:14.785053	2026-05-25 19:43:09.581656	22:00:00	2026-06-25
53	23	1	6	122	23	2026-06-26	15:00:00	\N	America/New_York	I	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186537	2026-05-23 10:00:15.993878	2026-05-25 19:43:09.581656	21:00:00	2026-06-26
54	23	1	15	120	121	2026-06-26	15:00:00	\N	America/Toronto	I	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186771	2026-05-23 10:00:16.047354	2026-05-25 19:43:09.581656	21:00:00	2026-06-26
73	23	2	2	\N	\N	2026-06-28	15:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 73, "local_desc" : "2o A", "visitante_desc" : "2o B"}	\N	2026-05-23 10:00:16.860546	2026-05-23 10:00:16.860546	21:00:00	\N
74	23	2	6	\N	\N	2026-06-29	16:30:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 74, "local_desc" : "1o E", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:16.888167	2026-05-23 10:00:16.888167	22:30:00	\N
75	23	2	12	\N	\N	2026-06-29	23:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 75, "local_desc" : "1o F", "visitante_desc" : "2o C"}	\N	2026-05-23 10:00:16.928288	2026-05-23 10:00:16.928288	05:00:00	\N
76	23	2	\N	\N	\N	2026-06-29	13:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 76, "local_desc" : "1o C", "visitante_desc" : "2o F"}	\N	2026-05-23 10:00:16.962803	2026-05-23 10:00:16.962803	19:00:00	\N
77	23	2	1	\N	\N	2026-06-30	17:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 77, "local_desc" : "1o I", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.015161	2026-05-23 10:00:17.015161	23:00:00	\N
78	23	2	\N	\N	\N	2026-06-30	13:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 78, "local_desc" : "2o E", "visitante_desc" : "2o I"}	\N	2026-05-23 10:00:17.079868	2026-05-23 10:00:17.079868	19:00:00	\N
79	23	2	11	\N	\N	2026-06-30	21:00:00	\N	America/Mexico_City	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 79, "local_desc" : "1o A", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.128655	2026-05-23 10:00:17.128655	04:00:00	\N
80	23	2	\N	\N	\N	2026-07-01	12:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 80, "local_desc" : "1o L", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.174428	2026-05-23 10:00:17.174428	18:00:00	\N
81	23	2	4	\N	\N	2026-07-01	20:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 81, "local_desc" : "1o D", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.217322	2026-05-23 10:00:17.217322	05:00:00	\N
82	23	2	9	\N	\N	2026-07-01	16:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 82, "local_desc" : "1o G", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.254329	2026-05-23 10:00:17.254329	22:00:00	\N
83	23	2	15	\N	\N	2026-07-02	19:00:00	\N	America/Toronto	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 83, "local_desc" : "2o K", "visitante_desc" : "2o L"}	\N	2026-05-23 10:00:17.307673	2026-05-23 10:00:17.307673	01:00:00	\N
84	23	2	2	\N	\N	2026-07-02	15:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 84, "local_desc" : "1o H", "visitante_desc" : "2o J"}	\N	2026-05-23 10:00:17.351357	2026-05-23 10:00:17.351357	21:00:00	\N
85	23	2	14	\N	\N	2026-07-02	23:00:00	\N	America/Vancouver	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 85, "local_desc" : "1o B", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.39759	2026-05-23 10:00:17.39759	07:00:00	\N
86	23	2	5	\N	\N	2026-07-03	18:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 86, "local_desc" : "1o J", "visitante_desc" : "2o H"}	\N	2026-05-23 10:00:17.43741	2026-05-23 10:00:17.43741	00:00:00	\N
87	23	2	8	\N	\N	2026-07-03	21:30:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 87, "local_desc" : "1o K", "visitante_desc" : "Mejor 3o"}	\N	2026-05-23 10:00:17.50772	2026-05-23 10:00:17.50772	03:30:00	\N
88	23	2	\N	\N	\N	2026-07-03	14:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 88, "local_desc" : "2o D", "visitante_desc" : "2o G"}	\N	2026-05-23 10:00:17.549921	2026-05-23 10:00:17.549921	20:00:00	\N
89	23	3	7	\N	\N	2026-07-04	17:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 89, "local_desc" : "Gan 74", "visitante_desc" : "Gan 77"}	\N	2026-05-23 10:00:17.582932	2026-05-23 10:00:17.582932	23:00:00	\N
90	23	3	\N	\N	\N	2026-07-04	13:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 90, "local_desc" : "Gan 73", "visitante_desc" : "Gan 75"}	\N	2026-05-23 10:00:17.628235	2026-05-23 10:00:17.628235	19:00:00	\N
91	23	3	1	\N	\N	2026-07-05	16:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 91, "local_desc" : "Gan 76", "visitante_desc" : "Gan 78"}	\N	2026-05-23 10:00:17.667715	2026-05-23 10:00:17.667715	22:00:00	\N
92	23	3	11	\N	\N	2026-07-05	20:00:00	\N	America/Mexico_City	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 92, "local_desc" : "Gan 79", "visitante_desc" : "Gan 80"}	\N	2026-05-23 10:00:17.72659	2026-05-23 10:00:17.72659	03:00:00	\N
93	23	3	\N	\N	\N	2026-07-06	15:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 93, "local_desc" : "Gan 83", "visitante_desc" : "Gan 84"}	\N	2026-05-23 10:00:17.775332	2026-05-23 10:00:17.775332	21:00:00	\N
94	23	3	9	\N	\N	2026-07-06	20:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 94, "local_desc" : "Gan 81", "visitante_desc" : "Gan 82"}	\N	2026-05-23 10:00:17.817561	2026-05-23 10:00:17.817561	05:00:00	\N
95	23	3	\N	\N	\N	2026-07-07	12:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 95, "local_desc" : "Gan 86", "visitante_desc" : "Gan 88"}	\N	2026-05-23 10:00:17.857265	2026-05-23 10:00:17.857265	18:00:00	\N
96	23	3	14	\N	\N	2026-07-07	16:00:00	\N	America/Vancouver	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 96, "local_desc" : "Gan 85", "visitante_desc" : "Gan 87"}	\N	2026-05-23 10:00:17.885628	2026-05-23 10:00:17.885628	23:00:00	\N
97	23	4	6	\N	\N	2026-07-09	16:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 97, "local_desc" : "Gan 89", "visitante_desc" : "Gan 90"}	\N	2026-05-23 10:00:17.923943	2026-05-23 10:00:17.923943	22:00:00	\N
98	23	4	2	\N	\N	2026-07-10	15:00:00	\N	America/Los_Angeles	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 98, "local_desc" : "Gan 93", "visitante_desc" : "Gan 94"}	\N	2026-05-23 10:00:17.961315	2026-05-23 10:00:17.961315	22:00:00	\N
99	23	4	5	\N	\N	2026-07-11	17:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 99, "local_desc" : "Gan 91", "visitante_desc" : "Gan 92"}	\N	2026-05-23 10:00:18.017148	2026-05-23 10:00:18.017148	23:00:00	\N
100	23	4	8	\N	\N	2026-07-11	21:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 100, "local_desc" : "Gan 95", "visitante_desc" : "Gan 96"}	\N	2026-05-23 10:00:18.080897	2026-05-23 10:00:18.080897	04:00:00	\N
101	23	5	\N	\N	\N	2026-07-14	15:00:00	\N	America/Chicago	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 101, "local_desc" : "Gan 97", "visitante_desc" : "Gan 98"}	\N	2026-05-23 10:00:18.147937	2026-05-23 10:00:18.147937	21:00:00	\N
102	23	5	\N	\N	\N	2026-07-15	15:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 102, "local_desc" : "Gan 99", "visitante_desc" : "Gan 100"}	\N	2026-05-23 10:00:18.229611	2026-05-23 10:00:18.229611	21:00:00	\N
103	23	6	5	\N	\N	2026-07-18	17:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 103, "local_desc" : "Per 101", "visitante_desc" : "Per 102"}	\N	2026-05-23 10:00:18.254997	2026-05-23 10:00:18.254997	23:00:00	\N
104	23	7	1	\N	\N	2026-07-19	15:00:00	\N	America/New_York	\N	\N	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	{"match_num" : 104, "local_desc" : "Gan 101", "visitante_desc" : "Gan 102"}	\N	2026-05-23 10:00:18.299784	2026-05-23 10:00:18.299784	21:00:00	\N
67	23	1	\N	29	63	2026-06-17	16:00:00	\N	America/Chicago	L	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186504	2026-05-23 10:00:16.646065	2026-05-25 19:43:09.581656	22:00:00	2026-06-17
68	23	1	15	131	132	2026-06-17	19:00:00	\N	America/Toronto	L	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186687	2026-05-23 10:00:16.688076	2026-05-25 19:43:09.581656	01:00:00	2026-06-18
69	23	1	6	29	131	2026-06-23	16:00:00	\N	America/New_York	L	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186672	2026-05-23 10:00:16.727657	2026-05-25 19:43:09.581656	22:00:00	2026-06-23
70	23	1	15	132	63	2026-06-23	19:00:00	\N	America/Toronto	L	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186520	2026-05-23 10:00:16.765785	2026-05-25 19:43:09.581656	01:00:00	2026-06-24
71	23	1	1	132	29	2026-06-27	17:00:00	\N	America/New_York	L	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186676	2026-05-23 10:00:16.80033	2026-05-25 19:43:09.581656	23:00:00	2026-06-27
1	23	1	11	89	90	2026-06-11	21:00:00	\N	America/Mexico_City	A	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186710	2026-05-23 10:00:13.468581	2026-05-25 19:43:09.581656	21:00:00	2026-06-11
2	23	1	13	68	92	2026-06-11	20:00:00	\N	America/Mexico_City	A	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186720	2026-05-23 10:00:13.533198	2026-05-25 19:43:09.581656	04:00:00	2026-06-12
25	23	1	\N	7	104	2026-06-14	13:00:00	\N	America/Chicago	E	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186899	2026-05-23 10:00:14.621853	2026-05-25 19:43:09.581656	19:00:00	2026-06-14
31	23	1	\N	38	106	2026-06-14	16:00:00	\N	America/Chicago	F	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186945	2026-05-23 10:00:14.916344	2026-05-25 19:43:09.581656	22:00:00	2026-06-14
32	23	1	12	12	110	2026-06-14	22:00:00	\N	America/Chicago	F	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186951	2026-05-23 10:00:14.979093	2026-05-25 19:43:09.581656	04:00:00	2026-06-15
37	23	1	9	52	114	2026-06-15	15:00:00	\N	America/Los_Angeles	G	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186837	2026-05-23 10:00:15.197511	2026-05-25 19:43:09.581656	21:00:00	2026-06-15
44	23	1	5	115	1	2026-06-15	18:00:00	\N	America/New_York	H	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186811	2026-05-23 10:00:15.566425	2026-05-25 19:43:09.581656	00:00:00	2026-06-16
38	23	1	2	117	118	2026-06-15	21:00:00	\N	America/Los_Angeles	G	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186832	2026-05-23 10:00:15.242558	2026-05-25 19:43:09.581656	03:00:00	2026-06-16
55	23	1	8	2	124	2026-06-16	21:00:00	\N	America/Chicago	J	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186854	2026-05-23 10:00:16.090256	2026-05-25 19:43:09.581656	03:00:00	2026-06-17
56	23	1	4	8	126	2026-06-17	00:00:00	\N	America/Los_Angeles	J	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186751	2026-05-23 10:00:16.133975	2026-05-25 19:43:09.581656	06:00:00	2026-06-17
61	23	1	\N	31	128	2026-06-17	13:00:00	\N	America/Chicago	K	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186709	2026-05-23 10:00:16.381236	2026-05-25 19:43:09.581656	19:00:00	2026-06-17
62	23	1	11	133	134	2026-06-17	22:00:00	\N	America/Chicago	K	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186722	2026-05-23 10:00:16.426046	2026-05-25 19:43:09.581656	04:00:00	2026-06-18
9	23	1	2	96	94	2026-06-18	15:00:00	\N	America/Los_Angeles	B	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186806	2026-05-23 10:00:13.844166	2026-05-25 19:43:09.581656	21:00:00	2026-06-18
10	23	1	14	93	95	2026-06-18	18:00:00	\N	America/Vancouver	B	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186798	2026-05-23 10:00:13.917498	2026-05-25 19:43:09.581656	00:00:00	2026-06-19
4	23	1	13	89	68	2026-06-18	21:00:00	\N	America/Mexico_City	A	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186490	2026-05-23 10:00:13.609473	2026-05-25 19:43:09.581656	03:00:00	2026-06-19
21	23	1	9	3	101	2026-06-19	15:00:00	\N	America/Los_Angeles	D	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186878	2026-05-23 10:00:14.483081	2026-05-25 19:43:09.581656	21:00:00	2026-06-19
22	23	1	4	67	135	2026-06-19	23:00:00	\N	America/Los_Angeles	D	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186879	2026-05-23 10:00:14.5289	2026-05-25 19:43:09.581656	05:00:00	2026-06-20
33	23	1	\N	38	12	2026-06-20	13:00:00	\N	America/Chicago	F	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186957	2026-05-23 10:00:15.031962	2026-05-25 19:43:09.581656	19:00:00	2026-06-20
28	23	1	8	108	104	2026-06-20	20:00:00	\N	America/Chicago	E	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186906	2026-05-23 10:00:14.749264	2026-05-25 19:43:09.581656	02:00:00	2026-06-21
34	23	1	12	110	106	2026-06-21	00:00:00	\N	America/Chicago	F	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186963	2026-05-23 10:00:15.080074	2026-05-25 19:43:09.581656	06:00:00	2026-06-21
39	23	1	2	52	117	2026-06-21	15:00:00	\N	America/Los_Angeles	G	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186499	2026-05-23 10:00:15.300227	2026-05-25 19:43:09.581656	21:00:00	2026-06-21
40	23	1	14	118	114	2026-06-21	21:00:00	\N	America/Los_Angeles	G	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186827	2026-05-23 10:00:15.351624	2026-05-25 19:43:09.581656	03:00:00	2026-06-22
57	23	1	\N	2	8	2026-06-22	13:00:00	\N	America/Chicago	J	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186502	2026-05-23 10:00:16.19389	2026-05-25 19:43:09.581656	19:00:00	2026-06-22
58	23	1	4	126	124	2026-06-22	23:00:00	\N	America/Los_Angeles	J	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186740	2026-05-23 10:00:16.244689	2026-05-25 19:43:09.581656	05:00:00	2026-06-23
63	23	1	\N	31	133	2026-06-23	13:00:00	\N	America/Chicago	K	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186858	2026-05-23 10:00:16.469294	2026-05-25 19:43:09.581656	19:00:00	2026-06-23
64	23	1	13	134	128	2026-06-23	22:00:00	\N	America/Chicago	K	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186713	2026-05-23 10:00:16.52133	2026-05-25 19:43:09.581656	04:00:00	2026-06-24
11	23	1	14	96	93	2026-06-24	15:00:00	\N	America/Vancouver	B	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186821	2026-05-23 10:00:14.001411	2026-05-25 19:43:09.581656	21:00:00	2026-06-24
12	23	1	9	94	95	2026-06-24	15:00:00	\N	America/Los_Angeles	B	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186829	2026-05-23 10:00:14.050994	2026-05-25 19:43:09.581656	21:00:00	2026-06-24
5	23	1	11	92	89	2026-06-24	21:00:00	\N	America/Mexico_City	A	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186732	2026-05-23 10:00:13.642109	2026-05-25 19:43:09.581656	03:00:00	2026-06-25
6	23	1	12	90	68	2026-06-24	21:00:00	\N	America/Mexico_City	A	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186744	2026-05-23 10:00:13.678059	2026-05-25 19:43:09.581656	03:00:00	2026-06-25
30	23	1	1	108	7	2026-06-25	16:00:00	\N	America/New_York	E	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186907	2026-05-23 10:00:14.835759	2026-05-25 19:43:09.581656	22:00:00	2026-06-25
36	23	1	8	110	38	2026-06-25	19:00:00	\N	America/Chicago	F	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186973	2026-05-23 10:00:15.152139	2026-05-25 19:43:09.581656	01:00:00	2026-06-26
35	23	1	\N	106	12	2026-06-25	19:00:00	\N	America/Chicago	F	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186972	2026-05-23 10:00:15.115623	2026-05-25 19:43:09.581656	01:00:00	2026-06-26
24	23	1	4	135	101	2026-06-25	22:00:00	\N	America/Los_Angeles	D	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186891	2026-05-23 10:00:14.591744	2026-05-25 19:43:09.581656	04:00:00	2026-06-26
23	23	1	2	67	3	2026-06-25	22:00:00	\N	America/Los_Angeles	D	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186887	2026-05-23 10:00:14.560526	2026-05-25 19:43:09.581656	04:00:00	2026-06-26
48	23	1	13	1	16	2026-06-26	20:00:00	\N	America/Chicago	H	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186841	2026-05-23 10:00:15.745879	2026-05-25 19:43:09.581656	02:00:00	2026-06-27
47	23	1	\N	112	115	2026-06-26	20:00:00	\N	America/Chicago	H	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186803	2026-05-23 10:00:15.703508	2026-05-25 19:43:09.581656	02:00:00	2026-06-27
41	23	1	9	114	117	2026-06-26	23:00:00	\N	America/Los_Angeles	G	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186828	2026-05-23 10:00:15.399594	2026-05-25 19:43:09.581656	05:00:00	2026-06-27
42	23	1	14	118	52	2026-06-26	23:00:00	\N	America/Los_Angeles	G	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186822	2026-05-23 10:00:15.464225	2026-05-25 19:43:09.581656	05:00:00	2026-06-27
72	23	1	7	63	131	2026-06-27	17:00:00	\N	America/New_York	L	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186624	2026-05-23 10:00:16.830063	2026-05-25 19:43:09.581656	23:00:00	2026-06-27
65	23	1	5	134	31	2026-06-27	19:30:00	\N	America/New_York	K	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186696	2026-05-23 10:00:16.563465	2026-05-25 19:43:09.581656	01:30:00	2026-06-28
66	23	1	\N	128	133	2026-06-27	19:30:00	\N	America/New_York	K	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186717	2026-05-23 10:00:16.601451	2026-05-25 19:43:09.581656	01:30:00	2026-06-28
60	23	1	\N	126	2	2026-06-27	22:00:00	\N	America/Chicago	J	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186734	2026-05-23 10:00:16.33336	2026-05-25 19:43:09.581656	04:00:00	2026-06-28
59	23	1	8	124	8	2026-06-27	22:00:00	\N	America/Chicago	J	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186747	2026-05-23 10:00:16.283226	2026-05-25 19:43:09.581656	04:00:00	2026-06-28
\.


--
-- Name: partidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.partidos_id_seq', 104, true);


--
-- Name: partidos partidos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos
    ADD CONSTRAINT partidos_pkey PRIMARY KEY (id);


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

\unrestrict 8XX2y7fjIFP72AK36lbTRTFp3B6bBO8fTn7n9nndglRyk6dd5duHbTFcmGZPgMd

