--
-- PostgreSQL database dump
--

\restrict c3WNLaazHJMUmdN8SXniNog8vvTZv222v7qSIohTce6sTdD6SmAUammw1fCKBQb

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
-- Name: fases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fases ALTER COLUMN id SET DEFAULT nextval('public.fases_id_seq'::regclass);


--
-- Name: partidos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partidos ALTER COLUMN id SET DEFAULT nextval('public.partidos_id_seq'::regclass);


--
-- Name: selecciones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.selecciones ALTER COLUMN id SET DEFAULT nextval('public.selecciones_id_seq'::regclass);


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
8	1	Group 1	1
9	1	Group 2	2
10	1	Group 3	3
11	1	Group 4	4
12	1	Semi-finals	5
13	1	Third and fourth place	6
14	1	Final	7
15	1	Group stage	8
16	1	Knockout stage	13
17	2	Final tournament	1
18	2	Round of 16	2
19	2	Quarter-finals	3
20	2	Semi-finals	4
21	2	Match for third place	5
22	2	Final	6
23	3	Final draw	1
24	3	Final tournament	2
25	3	Round of 16	3
26	3	Quarter-finals	4
27	3	Semi-finals	5
28	3	Match for third place	6
29	3	Final	7
30	4	Group stage	1
31	4	Group 1	2
32	4	Group 2	3
33	4	Group 3	4
34	4	Group 4	5
35	4	Final round	6
36	5	Group stage	1
37	5	Quarter-finals	2
38	5	Semi-finals	3
39	5	Final	4
40	5	Final: "The Miracle of Bern"	5
41	5	Group 1	7
42	5	Group 2	8
43	5	Play-off	9
44	5	Group 3	10
45	5	Group 4	11
46	5	Knockout stage	13
47	5	Match for third place	16
48	6	Final	1
49	6	Group stage	2
50	6	Group 1	3
51	6	Play-off	4
52	6	Group 2	5
53	6	Group 3	6
54	6	Group 4	8
55	6	Knockout stage	10
56	6	Quarter-finals	11
57	6	Semi-finals	12
58	6	Match for third place	13
59	7	Group stage	1
60	7	Group 1	2
61	7	Group 2	3
62	7	Group 3	4
63	7	Group 4	5
64	7	Knockout stage	6
65	7	Quarter-finals	7
66	7	Semi-finals	8
67	7	Match for third place	9
68	7	Final	10
69	8	Background	1
70	8	Group stage	2
71	8	Final	3
72	8	Group 1	5
73	8	Group 2	6
74	8	Group 3	7
75	8	Group 4	8
76	8	Knockout stage	9
77	8	Quarter-finals	10
78	8	Semi-finals	11
79	8	Match for third place	12
80	9	Final draw	1
81	9	Group stage	2
82	9	Knockout stage	3
83	9	Quarter-finals	4
84	9	Semi-finals	5
85	9	Final	6
86	9	Group 1	8
87	9	Group 2	9
88	9	Group 3	10
89	9	Group 4	11
90	9	Match for third place	15
91	10	First round	1
92	10	Second round	2
93	10	Final	3
94	10	Final draw	4
95	10	First group stage	5
96	10	Group 1	6
97	10	Group 2	7
98	10	Group 3	8
99	10	Group 4	9
100	10	Second group stage	10
101	10	Group A	11
102	10	Group B	12
103	10	Knockout stage	13
104	10	Match for third place	14
105	11	First round	1
106	11	Second round	2
107	11	Final	3
108	11	First group stage	4
109	11	Group 1	5
110	11	Group 2	6
111	11	Group 3	7
112	11	Group 4	8
113	11	Second group stage	9
114	11	Group A	10
115	11	Group B	11
116	11	Knockout stage	12
117	11	Match for third place	13
118	12	First group stage	1
119	12	Second group stage	2
120	12	Semi-finals, match for third place and final	3
121	12	Groups	4
122	12	Final draw	5
123	12	Group 1	7
124	12	Group 2	8
125	12	Group 3	9
126	12	Group 4	10
127	12	Group 5	11
128	12	Group 6	12
129	12	Group A	14
130	12	Group B	15
131	12	Group C	16
132	12	Group D	17
133	12	Knockout stage	18
134	12	Semi-finals	19
135	12	Match for third place	20
136	12	Final	21
137	12	Final standings	22
138	13	First round	1
139	13	Second round and quarter-finals	2
140	13	Semi-finals, match for third place and final	3
141	13	Group stage	4
142	13	Group A	5
143	13	Group B	6
144	13	Group C	7
145	13	Group D	8
146	13	Group E	9
147	13	Group F	10
148	13	Ranking of third-placed teams	11
149	13	Knockout stage	12
150	13	Round of 16	13
151	13	Quarter-finals	14
152	13	Semi-finals	15
153	13	Match for third place	16
154	13	Final	17
155	13	Final standings	18
156	14	Final draw	1
157	14	All-champion final four	2
158	14	Group stage	3
159	14	Group A	4
160	14	Group B	5
161	14	Group C	6
162	14	Group D	7
163	14	Group E	8
164	14	Group F	9
165	14	Ranking of third-placed teams	10
166	14	Knockout stage	11
167	14	Round of 16	12
168	14	Quarter-finals	13
169	14	Semi-finals	14
170	14	Match for third place	15
171	14	Final	16
172	14	Final standings	17
173	15	Background and preparations	1
174	15	Group stage	2
175	15	Group A	3
176	15	Group B	4
177	15	Group C	5
178	15	Group D	6
179	15	Group E	7
180	15	Group F	8
181	15	Ranking of third-placed teams	9
182	15	Knockout stage	10
183	15	Round of 16	11
184	15	Quarterfinals	12
185	15	Semifinals	13
186	15	Match for third place	14
187	15	Final	15
188	15	Final standings	16
189	16	Draw results and group fixtures	1
190	16	Group stage	2
191	16	Group A	3
192	16	Group B	4
193	16	Group C	5
194	16	Group D	6
195	16	Group E	7
196	16	Group F	8
197	16	Group G	9
198	16	Group H	10
199	16	Knockout stage	11
200	16	Round of 16	12
201	16	Quarter-finals	13
202	16	Semi-finals	14
203	16	Match for third place	15
204	16	Final	16
205	16	Final standings	17
206	17	Draw results and group fixtures	1
207	17	Group stage	2
208	17	Group A	3
209	17	Group B	4
210	17	Group C	5
211	17	Group D	6
212	17	Group E	7
213	17	Group F	8
214	17	Group G	9
215	17	Group H	10
216	17	Knockout stage	11
217	17	Round of 16	12
218	17	Quarter-finals	13
219	17	Semi-finals	14
220	17	Match for third place	15
221	17	Final	16
222	17	Final standings	17
223	18	Groups	1
224	18	Group system	2
225	18	Finals tournament	3
226	18	Group stage	4
227	18	Group A	5
228	18	Group B	6
229	18	Group C	7
230	18	Group D	8
231	18	Group E	9
232	18	Group F	10
233	18	Group G	11
234	18	Group H	12
235	18	Knockout stage	13
236	18	Round of 16	14
237	18	Quarter-finals	15
238	18	Semi-finals	16
239	18	Match for third place	17
240	18	Final	18
241	18	Final standings	19
242	19	Final draw	1
243	19	Group stage	2
244	19	Group A	3
245	19	Group B	4
246	19	Group C	5
247	19	Group D	6
248	19	Group E	7
249	19	Group F	8
250	19	Group G	9
251	19	Group H	10
252	19	Knockout stage	11
253	19	Round of 16	12
254	19	Quarter-finals	13
255	19	Semi-finals	14
256	19	Match for third place	15
257	19	Final	16
258	19	Final standings	17
259	20	Final draw	1
260	20	Group stage	2
261	20	Group A	3
262	20	Group B	4
263	20	Group C	5
264	20	Group D	6
265	20	Group E	7
266	20	Group F	8
267	20	Group G	9
268	20	Group H	10
269	20	Knockout stage	11
270	20	Round of 16	12
271	20	Quarter-finals	13
272	20	Semi-finals	14
273	20	Match for third place	15
274	20	Final	16
275	20	Final standings	17
276	21	Group stage	1
277	21	Group A	2
278	21	Group B	3
279	21	Group C	4
280	21	Group D	5
281	21	Group E	6
282	21	Group F	7
283	21	Group G	8
284	21	Group H	9
285	21	Knockout stage	10
286	21	Round of 16	11
287	21	Quarter-finals	12
288	21	Semi-finals	13
289	21	Match for third place	14
290	21	Final	15
291	22	Group stage	1
292	22	Group A	2
293	22	Group B	3
294	22	Group C	4
295	22	Group D	5
296	22	Group E	6
297	22	Group F	7
298	22	Group G	8
299	22	Group H	9
300	22	Knockout stage	10
301	22	Round of 16	11
302	22	Quarter-finals	12
303	22	Semi-finals	13
304	22	Match for third place	14
305	22	Final	15
\.


--
-- Data for Name: partidos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.partidos (id, torneo_id, fase_id, estadio_id, seleccion_local_id, seleccion_visitante_id, fecha, hora_local, hora_utc, zona_horaria, grupo, jornada, goles_local, goles_visitante, goles_local_prorroga, goles_visitante_prorroga, penaltis_local, penaltis_visitante, hubo_prorroga, hubo_penaltis, arbitro, asistencia, clima_temperatura, clima_descripcion, clima_humedad, clima_viento_kmh, estado, minuto_actual, resumen_narrativo, curiosidades, sofascore_id, created_at, updated_at, hora_espana, fecha_espana) FROM stdin;
105	1	8	\N	23	89	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
106	1	8	\N	2	23	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
107	1	8	\N	27	89	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
108	1	8	\N	27	23	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
109	1	8	\N	2	89	\N	\N	\N	\N	\N	\N	6	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
110	1	8	\N	2	27	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
111	1	9	\N	28	11	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
112	1	9	\N	28	137	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
113	1	9	\N	11	137	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
114	1	10	\N	138	139	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
115	1	10	\N	1	139	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
116	1	10	\N	1	138	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
117	1	11	\N	140	52	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
118	1	11	\N	140	135	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
119	1	11	\N	135	52	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
120	1	12	\N	2	140	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
121	1	12	\N	1	28	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
122	1	14	\N	1	2	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:41.960691	2026-05-25 20:40:41.960691	\N	\N
123	2	18	\N	16	11	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
124	2	18	\N	10	114	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
125	2	18	\N	96	38	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
126	2	18	\N	5	140	\N	\N	\N	\N	\N	\N	7	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
127	2	18	\N	6	138	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
128	2	18	\N	12	2	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
129	2	18	\N	8	23	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
130	2	18	\N	7	52	\N	\N	\N	\N	\N	\N	5	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
131	2	19	\N	8	10	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
132	2	19	\N	5	16	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
133	2	19	\N	7	12	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
134	2	19	\N	6	96	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
135	2	20	\N	5	8	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
136	2	20	\N	6	7	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
137	2	21	\N	7	8	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
138	2	22	\N	5	6	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:44.013977	2026-05-25 20:40:44.013977	\N	\N
139	3	25	\N	96	7	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
140	3	25	\N	10	141	\N	\N	\N	\N	\N	\N	6	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
141	3	25	\N	142	138	\N	\N	\N	\N	\N	\N	3	3	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
7	23	1	15	93	94	2026-06-12	15:00:00	\N	America/Toronto	B	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186836	2026-05-23 10:00:13.722166	2026-05-25 19:43:09.581656	21:00:00	2026-06-12
142	3	25	\N	23	52	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
143	3	25	\N	5	122	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
19	23	1	2	3	135	2026-06-12	21:00:00	\N	America/Los_Angeles	D	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186873	2026-05-23 10:00:14.413597	2026-05-25 19:43:09.581656	03:00:00	2026-06-13
8	23	1	4	95	96	2026-06-13	15:00:00	\N	America/Los_Angeles	B	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186526	2026-05-23 10:00:13.779472	2026-05-25 19:43:09.581656	21:00:00	2026-06-13
13	23	1	1	11	88	2026-06-13	18:00:00	\N	America/New_York	C	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186850	2026-05-23 10:00:14.099665	2026-05-25 19:43:09.581656	00:00:00	2026-06-14
144	3	25	\N	11	39	\N	\N	\N	\N	\N	\N	6	5	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
14	23	1	6	99	100	2026-06-13	21:00:00	\N	America/New_York	C	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186853	2026-05-23 10:00:14.132633	2026-05-25 19:43:09.581656	03:00:00	2026-06-14
145	3	25	\N	6	38	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
20	23	1	14	101	67	2026-06-14	00:00:00	\N	America/Vancouver	D	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186874	2026-05-23 10:00:14.445068	2026-05-25 19:43:09.581656	06:00:00	2026-06-14
26	23	1	7	107	108	2026-06-14	19:00:00	\N	America/New_York	E	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186904	2026-05-23 10:00:14.656205	2026-05-25 19:43:09.581656	01:00:00	2026-06-15
146	3	26	\N	10	96	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
147	3	26	\N	12	142	\N	\N	\N	\N	\N	\N	8	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
43	23	1	\N	16	112	2026-06-15	12:00:00	\N	America/New_York	H	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186783	2026-05-23 10:00:15.517884	2026-05-25 19:43:09.581656	18:00:00	2026-06-15
49	23	1	1	23	120	2026-06-16	15:00:00	\N	America/New_York	I	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186501	2026-05-23 10:00:15.780766	2026-05-25 19:43:09.581656	21:00:00	2026-06-16
148	3	26	\N	5	23	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
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
149	3	26	\N	11	6	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
150	3	27	\N	10	12	\N	\N	\N	\N	\N	\N	5	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
151	3	27	\N	5	11	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
152	3	28	\N	11	12	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
153	3	29	\N	5	10	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:45.6718	2026-05-25 20:40:45.6718	\N	\N
154	4	31	\N	11	89	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
155	4	31	\N	28	96	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
156	4	31	\N	11	96	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
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
157	4	31	\N	28	89	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
68	23	1	15	131	132	2026-06-17	19:00:00	\N	America/Toronto	L	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186687	2026-05-23 10:00:16.688076	2026-05-25 19:43:09.581656	01:00:00	2026-06-18
69	23	1	6	29	131	2026-06-23	16:00:00	\N	America/New_York	L	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186672	2026-05-23 10:00:16.727657	2026-05-25 19:43:09.581656	22:00:00	2026-06-23
158	4	31	\N	11	28	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
70	23	1	15	132	63	2026-06-23	19:00:00	\N	America/Toronto	L	2	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186520	2026-05-23 10:00:16.765785	2026-05-25 19:43:09.581656	01:00:00	2026-06-24
71	23	1	1	132	29	2026-06-27	17:00:00	\N	America/New_York	L	3	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186676	2026-05-23 10:00:16.80033	2026-05-25 19:43:09.581656	23:00:00	2026-06-27
159	4	31	\N	96	89	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
160	4	32	\N	29	27	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
161	4	32	\N	16	140	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
162	4	32	\N	16	27	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
163	4	32	\N	140	29	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
164	4	32	\N	16	29	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
165	4	32	\N	27	140	\N	\N	\N	\N	\N	\N	5	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
1	23	1	11	89	90	2026-06-11	21:00:00	\N	America/Mexico_City	A	1	\N	\N	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	pendiente	\N	\N	\N	15186710	2026-05-23 10:00:13.468581	2026-05-25 19:43:09.581656	21:00:00	2026-06-11
166	4	33	\N	12	5	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
167	4	33	\N	12	135	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
168	4	33	\N	5	135	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
169	4	34	\N	1	137	\N	\N	\N	\N	\N	\N	8	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
170	4	35	\N	1	16	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
171	4	35	\N	11	12	\N	\N	\N	\N	\N	\N	7	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
172	4	35	\N	11	16	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
173	4	35	\N	1	12	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
174	4	35	\N	12	16	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
175	4	35	\N	1	11	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:47.263843	2026-05-25 20:40:47.263843	\N	\N
176	5	41	\N	11	89	\N	\N	\N	\N	\N	\N	5	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
177	5	41	\N	28	23	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
178	5	41	\N	11	28	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
179	5	41	\N	23	89	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
180	5	42	\N	17	67	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
181	5	42	\N	10	68	\N	\N	\N	\N	\N	\N	9	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
182	5	42	\N	10	17	\N	\N	\N	\N	\N	\N	8	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
183	5	42	\N	67	68	\N	\N	\N	\N	\N	\N	7	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
184	5	43	\N	17	67	\N	\N	\N	\N	\N	\N	7	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
185	5	44	\N	1	6	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
186	5	44	\N	8	100	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
187	5	44	\N	1	100	\N	\N	\N	\N	\N	\N	7	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
188	5	44	\N	8	6	\N	\N	\N	\N	\N	\N	5	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
189	5	45	\N	96	5	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
190	5	45	\N	29	52	\N	\N	\N	\N	\N	\N	4	4	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
191	5	45	\N	5	52	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
192	5	45	\N	29	96	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
193	5	43	\N	96	5	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
194	5	37	\N	8	96	\N	\N	\N	\N	\N	\N	7	5	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
195	5	37	\N	1	29	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
196	5	37	\N	17	28	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
197	5	37	\N	10	11	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
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
198	5	38	\N	17	8	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
199	5	38	\N	10	1	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
200	5	47	\N	8	1	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
201	5	39	\N	17	10	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:48.994321	2026-05-25 20:40:48.994321	\N	\N
231	6	56	\N	12	32	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
232	6	56	\N	17	28	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
233	6	57	\N	11	23	\N	\N	\N	\N	\N	\N	5	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
234	6	57	\N	12	17	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
235	6	58	\N	23	17	\N	\N	\N	\N	\N	\N	6	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
236	6	48	\N	11	12	\N	\N	\N	\N	\N	\N	5	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
237	7	60	\N	1	134	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
238	7	60	\N	32	28	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
239	7	60	\N	28	1	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
240	7	60	\N	32	134	\N	\N	\N	\N	\N	\N	4	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
241	7	60	\N	32	1	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
242	7	60	\N	28	134	\N	\N	\N	\N	\N	\N	5	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
243	7	61	\N	27	96	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
244	7	61	\N	17	5	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
245	7	61	\N	27	5	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
246	7	61	\N	17	96	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
247	7	61	\N	17	27	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
248	7	61	\N	5	96	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
249	7	62	\N	11	89	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
250	7	62	\N	6	16	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
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
202	6	50	\N	2	17	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
203	6	50	\N	143	6	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
204	6	50	\N	17	6	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
205	6	50	\N	2	143	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
206	6	50	\N	17	143	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
207	6	50	\N	6	2	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
208	6	51	\N	143	6	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
209	6	52	\N	23	135	\N	\N	\N	\N	\N	\N	7	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
210	6	52	\N	28	100	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
211	6	52	\N	28	23	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
212	6	52	\N	135	100	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
213	6	52	\N	23	100	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
214	6	52	\N	135	28	\N	\N	\N	\N	\N	\N	3	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
215	6	53	\N	12	89	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
216	6	53	\N	10	144	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
217	6	53	\N	89	144	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
218	6	53	\N	12	10	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
219	6	53	\N	12	144	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
220	6	53	\N	10	89	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
221	6	51	\N	144	10	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
222	6	54	\N	11	8	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
223	6	54	\N	32	29	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
224	6	54	\N	11	29	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
225	6	54	\N	32	8	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
226	6	54	\N	29	8	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
227	6	54	\N	11	32	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
228	6	51	\N	32	29	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
229	6	56	\N	11	144	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
230	6	56	\N	23	143	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:50.954384	2026-05-25 20:40:50.954384	\N	\N
251	7	62	\N	11	6	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
252	7	62	\N	16	89	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
253	7	62	\N	11	16	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
254	7	62	\N	89	6	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
255	7	63	\N	2	60	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
256	7	63	\N	10	29	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
257	7	63	\N	29	2	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
258	7	63	\N	10	60	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
259	7	63	\N	10	2	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
260	7	63	\N	29	60	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
261	7	65	\N	27	32	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
262	7	65	\N	6	10	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
263	7	65	\N	11	29	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
264	7	65	\N	28	17	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
265	7	66	\N	6	28	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
266	7	66	\N	11	27	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
267	7	67	\N	27	28	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
268	7	68	\N	11	6	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:53.260323	2026-05-25 20:40:53.260323	\N	\N
269	8	72	\N	29	1	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
270	8	72	\N	23	89	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
271	8	72	\N	1	23	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
272	8	72	\N	29	89	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
273	8	72	\N	89	1	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
274	8	72	\N	29	23	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
275	8	73	\N	17	96	\N	\N	\N	\N	\N	\N	5	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
276	8	73	\N	2	16	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
277	8	73	\N	16	96	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
278	8	73	\N	2	17	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
279	8	73	\N	2	96	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
280	8	73	\N	17	16	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
281	8	74	\N	11	60	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
282	8	74	\N	31	10	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
283	8	74	\N	10	11	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
284	8	74	\N	31	60	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
285	8	74	\N	31	11	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
286	8	74	\N	10	60	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
287	8	75	\N	32	145	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
288	8	75	\N	5	27	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
289	8	75	\N	27	145	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
290	8	75	\N	32	5	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
291	8	75	\N	145	5	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
292	8	75	\N	32	27	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
293	8	77	\N	29	2	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
294	8	77	\N	17	1	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
295	8	77	\N	32	10	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
296	8	77	\N	31	145	\N	\N	\N	\N	\N	\N	5	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
297	8	78	\N	17	32	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
298	8	78	\N	29	31	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
299	8	79	\N	31	32	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
300	8	71	\N	29	17	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:55.077957	2026-05-25 20:40:55.077957	\N	\N
301	9	86	\N	89	32	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
302	9	86	\N	52	146	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
303	9	86	\N	32	52	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
304	9	86	\N	89	146	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
305	9	86	\N	32	146	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
306	9	86	\N	89	52	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
307	9	87	\N	1	147	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
308	9	87	\N	5	12	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
309	9	87	\N	1	5	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
310	9	87	\N	12	147	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
311	9	87	\N	12	1	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
312	9	87	\N	5	147	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
313	9	88	\N	29	138	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
314	9	88	\N	11	6	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
315	9	88	\N	138	6	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
316	9	88	\N	11	29	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
317	9	88	\N	11	138	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
318	9	88	\N	29	6	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
319	9	89	\N	139	60	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
320	9	89	\N	17	88	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
321	9	89	\N	139	88	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
322	9	89	\N	17	60	\N	\N	\N	\N	\N	\N	5	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
323	9	89	\N	17	139	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
324	9	89	\N	60	88	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
325	9	83	\N	32	1	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
326	9	83	\N	5	89	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
327	9	83	\N	11	139	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
328	9	83	\N	17	29	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
329	9	84	\N	11	1	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
330	9	84	\N	5	17	\N	\N	\N	\N	\N	\N	4	3	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
331	9	90	\N	17	1	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
332	9	85	\N	11	5	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:56.853011	2026-05-25 20:40:56.853011	\N	\N
333	10	96	\N	17	27	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
334	10	96	\N	148	101	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
335	10	96	\N	101	17	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
336	10	96	\N	27	148	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
337	10	96	\N	101	27	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
338	10	96	\N	148	17	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
339	10	97	\N	11	28	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
340	10	97	\N	149	100	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
341	10	97	\N	28	149	\N	\N	\N	\N	\N	\N	9	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
342	10	97	\N	100	11	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
343	10	97	\N	100	28	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
344	10	97	\N	149	11	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
345	10	98	\N	1	38	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
346	10	98	\N	12	60	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
347	10	98	\N	60	1	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
348	10	98	\N	38	12	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
349	10	98	\N	60	38	\N	\N	\N	\N	\N	\N	1	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
350	10	98	\N	12	1	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
351	10	99	\N	5	99	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
352	10	99	\N	39	2	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
353	10	99	\N	2	5	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
354	10	99	\N	99	39	\N	\N	\N	\N	\N	\N	0	7	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
355	10	99	\N	2	99	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
356	10	99	\N	39	5	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
357	10	101	\N	38	2	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
358	10	101	\N	11	148	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
359	10	101	\N	2	11	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
360	10	101	\N	148	38	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
361	10	101	\N	2	148	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
362	10	101	\N	38	11	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
363	10	102	\N	28	17	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
364	10	102	\N	12	39	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
365	10	102	\N	39	28	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
366	10	102	\N	17	12	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
367	10	102	\N	39	17	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
368	10	102	\N	12	28	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
369	10	104	\N	11	39	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
370	10	93	\N	38	17	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:40:58.66773	2026-05-25 20:40:58.66773	\N	\N
371	11	109	\N	5	23	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
372	11	109	\N	2	10	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
373	11	109	\N	5	10	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
374	11	109	\N	2	23	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
375	11	109	\N	23	10	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
376	11	109	\N	2	5	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
377	11	110	\N	17	39	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
378	11	110	\N	110	89	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
379	11	110	\N	17	89	\N	\N	\N	\N	\N	\N	6	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
380	11	110	\N	39	110	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
381	11	110	\N	17	110	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
382	11	110	\N	39	89	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
383	11	111	\N	8	16	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
384	11	111	\N	11	12	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
385	11	111	\N	8	12	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
386	11	111	\N	11	16	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
387	11	111	\N	16	12	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
388	11	111	\N	11	8	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
389	11	112	\N	139	100	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
390	11	112	\N	38	117	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
391	11	112	\N	100	117	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
392	11	112	\N	38	139	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
393	11	112	\N	139	117	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
394	11	112	\N	100	38	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
395	11	114	\N	8	38	\N	\N	\N	\N	\N	\N	1	5	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
396	11	114	\N	5	17	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
397	11	114	\N	38	17	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
398	11	114	\N	5	8	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
399	11	114	\N	8	17	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
400	11	114	\N	5	38	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
401	11	115	\N	11	139	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
402	11	115	\N	2	39	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
403	11	115	\N	139	39	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
404	11	115	\N	2	11	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
405	11	115	\N	11	39	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
406	11	115	\N	2	139	\N	\N	\N	\N	\N	\N	6	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
407	11	117	\N	11	5	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
408	11	107	\N	2	38	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:00.730504	2026-05-25 20:41:00.730504	\N	\N
409	12	123	\N	5	39	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
410	12	123	\N	139	150	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
411	12	123	\N	5	139	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
412	12	123	\N	39	150	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
413	12	123	\N	39	139	\N	\N	\N	\N	\N	\N	5	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
414	12	123	\N	5	150	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
415	12	124	\N	17	124	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
416	12	124	\N	27	8	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
417	12	124	\N	17	27	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
418	12	124	\N	124	8	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
419	12	124	\N	124	27	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
420	12	124	\N	17	8	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
421	12	125	\N	2	52	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
422	12	125	\N	10	146	\N	\N	\N	\N	\N	\N	10	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
423	12	125	\N	2	10	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
424	12	125	\N	52	146	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
425	12	125	\N	52	10	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
426	12	125	\N	2	146	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
427	12	126	\N	29	23	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
428	12	126	\N	6	151	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
429	12	126	\N	29	6	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
430	12	126	\N	23	151	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
431	12	126	\N	23	6	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
432	12	126	\N	29	151	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
433	12	127	\N	16	152	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
434	12	127	\N	28	143	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
435	12	127	\N	16	28	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
436	12	127	\N	152	143	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
437	12	127	\N	152	28	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
438	12	127	\N	16	143	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
439	12	128	\N	11	32	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
440	12	128	\N	100	118	\N	\N	\N	\N	\N	\N	5	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
441	12	128	\N	11	100	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
442	12	128	\N	32	118	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
443	12	128	\N	32	100	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
444	12	128	\N	11	118	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
445	12	129	\N	39	52	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
446	12	129	\N	52	32	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
447	12	129	\N	32	39	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
448	12	130	\N	17	29	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
449	12	130	\N	17	16	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
450	12	130	\N	16	29	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
451	12	131	\N	5	2	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
452	12	131	\N	2	11	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
453	12	131	\N	5	11	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
454	12	132	\N	8	23	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
455	12	132	\N	8	143	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
456	12	132	\N	23	143	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
457	12	134	\N	39	5	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
458	12	134	\N	17	23	\N	\N	\N	\N	\N	\N	3	3	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
459	12	135	\N	39	23	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
460	12	136	\N	5	17	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:02.634412	2026-05-25 20:41:02.634412	\N	\N
461	13	142	\N	60	5	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
462	13	142	\N	2	68	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
463	13	142	\N	5	2	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
464	13	142	\N	68	60	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
465	13	142	\N	68	5	\N	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
466	13	142	\N	2	60	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
467	13	143	\N	52	89	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
468	13	143	\N	135	121	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
469	13	143	\N	89	135	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
470	13	143	\N	121	52	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
471	13	143	\N	135	52	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
472	13	143	\N	121	89	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
473	13	144	\N	93	23	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
474	13	144	\N	32	10	\N	\N	\N	\N	\N	\N	6	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
475	13	144	\N	23	32	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
476	13	144	\N	10	93	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
477	13	144	\N	10	23	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
478	13	144	\N	32	93	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
479	13	145	\N	16	11	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
480	13	145	\N	124	143	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
481	13	145	\N	11	124	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
482	13	145	\N	143	16	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
483	13	145	\N	143	11	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
484	13	145	\N	124	16	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
485	13	146	\N	1	17	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
486	13	146	\N	100	136	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
487	13	146	\N	17	100	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
488	13	146	\N	136	1	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
489	13	146	\N	136	17	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
490	13	146	\N	100	1	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
491	13	147	\N	88	39	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
492	13	147	\N	31	29	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
493	13	147	\N	29	88	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
494	13	147	\N	39	31	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
495	13	147	\N	29	39	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
496	13	147	\N	31	88	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
497	13	150	\N	89	60	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
498	13	150	\N	32	52	\N	\N	\N	\N	\N	\N	3	4	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
499	13	150	\N	11	39	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
500	13	150	\N	2	1	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
501	13	150	\N	5	23	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
502	13	150	\N	88	17	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
503	13	150	\N	29	135	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
504	13	150	\N	136	16	\N	\N	\N	\N	\N	\N	1	5	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
505	13	151	\N	11	23	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
506	13	151	\N	153	154	\N	\N	\N	\N	\N	\N	3	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
507	13	151	\N	17	89	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
508	13	151	\N	155	156	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
509	13	151	\N	2	29	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
510	13	151	\N	16	52	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
511	13	151	\N	157	158	\N	\N	\N	\N	\N	\N	4	5	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
512	13	152	\N	23	17	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
513	13	152	\N	2	52	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
514	13	153	\N	52	23	\N	\N	\N	\N	\N	\N	2	4	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
515	13	154	\N	2	17	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:04.621766	2026-05-25 20:41:04.621766	\N	\N
516	14	159	\N	5	8	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
517	14	159	\N	140	6	\N	\N	\N	\N	\N	\N	1	5	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
518	14	159	\N	5	140	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
519	14	159	\N	8	6	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
520	14	159	\N	5	6	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
521	14	159	\N	8	140	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
522	14	160	\N	2	150	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
523	14	160	\N	32	138	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
524	14	160	\N	2	32	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
525	14	160	\N	150	138	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
526	14	160	\N	2	138	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
527	14	160	\N	150	32	\N	\N	\N	\N	\N	\N	0	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
528	14	161	\N	11	12	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
529	14	161	\N	159	100	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
530	14	161	\N	11	159	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
531	14	161	\N	12	100	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
532	14	161	\N	11	100	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
533	14	161	\N	12	159	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
534	14	162	\N	160	134	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
535	14	162	\N	17	28	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
536	14	162	\N	28	134	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
537	14	162	\N	17	160	\N	\N	\N	\N	\N	\N	5	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
538	14	162	\N	17	134	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
539	14	162	\N	28	160	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
540	14	163	\N	52	68	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
541	14	163	\N	1	16	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
542	14	163	\N	52	1	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
543	14	163	\N	68	16	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
544	14	163	\N	52	16	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
545	14	163	\N	68	1	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
546	14	164	\N	29	161	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
547	14	164	\N	38	114	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
548	14	164	\N	29	38	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
549	14	164	\N	161	114	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
550	14	164	\N	29	114	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
551	14	164	\N	161	38	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
552	14	167	\N	150	134	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
553	14	167	\N	6	159	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
554	14	167	\N	11	2	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
555	14	167	\N	17	38	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
556	14	167	\N	161	138	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
557	14	167	\N	162	163	\N	\N	\N	\N	\N	\N	5	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
558	14	167	\N	5	1	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
559	14	167	\N	16	28	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
560	14	167	\N	29	52	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
561	14	168	\N	2	28	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
562	14	168	\N	164	165	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
563	14	168	\N	161	5	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
564	14	168	\N	6	17	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
565	14	168	\N	150	29	\N	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
566	14	169	\N	2	5	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
567	14	169	\N	166	167	\N	\N	\N	\N	\N	\N	4	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
568	14	169	\N	17	29	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
569	14	169	\N	168	169	\N	\N	\N	\N	\N	\N	4	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
570	14	170	\N	5	29	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
571	14	171	\N	17	2	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:06.493176	2026-05-25 20:41:06.493176	\N	\N
572	15	175	\N	140	96	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
573	15	175	\N	134	138	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
574	15	175	\N	138	96	\N	\N	\N	\N	\N	\N	1	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
575	15	175	\N	140	134	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
576	15	175	\N	96	134	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
577	15	175	\N	140	138	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
578	15	176	\N	150	12	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
579	15	176	\N	11	170	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
580	15	176	\N	11	150	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
581	15	176	\N	12	170	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
582	15	176	\N	170	150	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
583	15	176	\N	11	12	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
584	15	177	\N	7	137	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
585	15	177	\N	16	68	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
586	15	177	\N	7	16	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
587	15	177	\N	68	137	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
588	15	177	\N	137	16	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
589	15	177	\N	7	68	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
590	15	178	\N	2	171	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
591	15	178	\N	172	60	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
592	15	178	\N	2	172	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
593	15	178	\N	60	171	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
594	15	178	\N	2	60	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
595	15	178	\N	171	172	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
596	15	179	\N	5	161	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
597	15	179	\N	122	89	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
598	15	179	\N	5	122	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
599	15	179	\N	89	161	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
600	15	179	\N	5	89	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
601	15	179	\N	161	122	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
602	15	180	\N	52	88	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
603	15	180	\N	38	115	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
604	15	180	\N	52	38	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
605	15	180	\N	115	88	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
606	15	180	\N	52	115	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
607	15	180	\N	88	38	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
608	15	183	\N	7	52	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
609	15	183	\N	16	96	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
610	15	183	\N	115	12	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
611	15	183	\N	138	2	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
612	15	183	\N	38	161	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
613	15	183	\N	11	140	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
614	15	183	\N	172	5	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
615	15	183	\N	89	60	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
616	15	183	\N	173	174	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
617	15	184	\N	5	16	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
618	15	184	\N	38	11	\N	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
619	15	184	\N	60	7	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
620	15	184	\N	138	12	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
621	15	185	\N	60	5	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
622	15	185	\N	12	11	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
623	15	186	\N	12	60	\N	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
624	15	187	\N	11	5	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
625	15	187	\N	175	176	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:08.577315	2026-05-25 20:41:08.577315	\N	\N
626	16	191	\N	11	100	1998-06-10	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
627	16	191	\N	88	122	1998-06-10	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
628	16	191	\N	100	122	1998-06-16	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
629	16	191	\N	11	88	1998-06-16	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
630	16	191	\N	100	88	1998-06-23	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
631	16	191	\N	11	122	1998-06-23	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
632	16	192	\N	5	27	1998-06-11	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
633	16	192	\N	150	8	1998-06-11	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
634	16	192	\N	27	8	1998-06-17	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
635	16	192	\N	5	150	1998-06-17	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
636	16	192	\N	5	8	1998-06-23	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
637	16	192	\N	27	150	1998-06-23	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
638	16	193	\N	115	136	1998-06-12	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
639	16	193	\N	23	90	1998-06-12	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
640	16	193	\N	90	136	1998-06-18	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
641	16	193	\N	23	115	1998-06-18	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
642	16	193	\N	23	136	1998-06-24	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
643	16	193	\N	90	115	1998-06-24	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
644	16	194	\N	135	60	1998-06-12	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
645	16	194	\N	16	172	1998-06-13	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
646	16	194	\N	172	60	1998-06-19	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
647	16	194	\N	16	135	1998-06-19	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
648	16	194	\N	172	135	1998-06-24	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
649	16	194	\N	16	60	1998-06-24	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
650	16	195	\N	68	89	1998-06-13	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
651	16	195	\N	38	52	1998-06-13	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
652	16	195	\N	52	89	1998-06-20	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
653	16	195	\N	38	68	1998-06-20	\N	\N	\N	\N	\N	5	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
654	16	195	\N	38	89	1998-06-25	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
655	16	195	\N	52	68	1998-06-25	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
656	16	196	\N	177	117	1998-06-14	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
657	16	196	\N	7	140	1998-06-15	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
658	16	196	\N	7	177	1998-06-21	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
659	16	196	\N	140	117	1998-06-21	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
660	16	196	\N	7	117	1998-06-25	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
661	16	196	\N	140	177	1998-06-25	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
662	16	197	\N	29	110	1998-06-15	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
663	16	197	\N	138	134	1998-06-15	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
664	16	197	\N	134	110	1998-06-22	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
665	16	197	\N	138	29	1998-06-22	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
666	16	197	\N	134	29	1998-06-26	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
667	16	197	\N	138	110	1998-06-26	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
668	16	198	\N	2	106	1998-06-14	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
669	16	198	\N	178	63	1998-06-14	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
670	16	198	\N	106	63	1998-06-20	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
671	16	198	\N	2	178	1998-06-21	\N	\N	\N	\N	\N	5	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
672	16	198	\N	2	63	1998-06-26	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
673	16	198	\N	106	178	1998-06-26	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
674	16	200	\N	5	122	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
675	16	200	\N	11	27	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
676	16	200	\N	23	135	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
677	16	200	\N	172	136	\N	\N	\N	\N	\N	\N	1	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
678	16	200	\N	7	89	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
679	16	200	\N	38	177	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
680	16	200	\N	138	63	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
681	16	200	\N	2	29	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
682	16	200	\N	179	180	\N	\N	\N	\N	\N	\N	4	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
683	16	201	\N	5	23	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
684	16	201	\N	181	182	\N	\N	\N	\N	\N	\N	3	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
685	16	201	\N	11	136	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
686	16	201	\N	38	2	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
687	16	201	\N	7	63	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
688	16	202	\N	11	38	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
689	16	202	\N	183	184	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
690	16	202	\N	23	63	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
691	16	203	\N	38	63	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
692	16	204	\N	11	23	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
693	16	205	\N	185	186	\N	\N	\N	\N	\N	\N	1997	98	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:10.49477	2026-05-25 20:41:10.49477	\N	\N
694	17	208	\N	23	120	2002-05-31	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
695	17	208	\N	1	136	2002-06-01	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
696	17	208	\N	136	120	2002-06-06	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
697	17	208	\N	23	1	2002-06-06	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
698	17	208	\N	136	23	2002-06-11	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
699	17	208	\N	120	1	2002-06-11	\N	\N	\N	\N	\N	3	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
700	17	209	\N	135	90	2002-06-02	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
701	17	209	\N	16	187	2002-06-02	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
702	17	209	\N	16	135	2002-06-07	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
703	17	209	\N	90	187	2002-06-08	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
704	17	209	\N	90	16	2002-06-12	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
705	17	209	\N	187	135	2002-06-12	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
706	17	210	\N	11	67	2002-06-03	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
707	17	210	\N	188	159	2002-06-04	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
708	17	210	\N	11	188	2002-06-08	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
709	17	210	\N	159	67	2002-06-09	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
710	17	210	\N	159	11	2002-06-13	\N	\N	\N	\N	\N	2	5	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
711	17	210	\N	67	188	2002-06-13	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
712	17	211	\N	68	39	2002-06-04	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
713	17	211	\N	140	31	2002-06-05	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
714	17	211	\N	68	140	2002-06-10	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
715	17	211	\N	31	39	2002-06-10	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
716	17	211	\N	31	68	2002-06-14	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
717	17	211	\N	39	140	2002-06-14	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
718	17	212	\N	161	150	2002-06-01	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
719	17	212	\N	7	115	2002-06-01	\N	\N	\N	\N	\N	8	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
720	17	212	\N	7	161	2002-06-05	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
721	17	212	\N	150	115	2002-06-06	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
722	17	212	\N	150	7	2002-06-11	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
723	17	212	\N	115	161	2002-06-11	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
724	17	213	\N	2	172	2002-06-02	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
725	17	213	\N	29	12	2002-06-02	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
726	17	213	\N	12	172	2002-06-07	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
727	17	213	\N	2	29	2002-06-07	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
728	17	213	\N	12	2	2002-06-12	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
729	17	213	\N	172	29	2002-06-12	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
730	17	214	\N	63	89	2002-06-03	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
731	17	214	\N	5	108	2002-06-03	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
732	17	214	\N	5	63	2002-06-08	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
733	17	214	\N	89	108	2002-06-09	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
734	17	214	\N	89	5	2002-06-13	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
735	17	214	\N	108	63	2002-06-13	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
736	17	215	\N	106	52	2002-06-04	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
737	17	215	\N	170	110	2002-06-05	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
738	17	215	\N	106	170	2002-06-09	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
739	17	215	\N	110	52	2002-06-10	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
740	17	215	\N	110	106	2002-06-14	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
741	17	215	\N	52	170	2002-06-14	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
742	17	217	\N	7	135	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
743	17	217	\N	136	29	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
744	17	217	\N	12	120	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
745	17	217	\N	16	161	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
746	17	217	\N	189	190	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
747	17	217	\N	89	140	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
748	17	217	\N	11	52	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
749	17	217	\N	106	67	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
750	17	217	\N	68	5	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
751	17	218	\N	29	11	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
752	17	218	\N	7	140	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
753	17	218	\N	16	68	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
754	17	218	\N	120	67	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
755	17	219	\N	7	68	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
756	17	219	\N	11	67	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
757	17	220	\N	68	67	\N	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
758	17	221	\N	7	11	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:12.569858	2026-05-25 20:41:12.569858	\N	\N
759	18	227	\N	7	159	2006-06-09	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
760	18	227	\N	39	108	2006-06-09	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
761	18	227	\N	7	39	2006-06-14	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
762	18	227	\N	108	159	2006-06-15	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
763	18	227	\N	108	7	2006-06-20	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
764	18	227	\N	159	39	2006-06-20	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
765	18	228	\N	29	135	2006-06-10	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
766	18	228	\N	191	12	2006-06-10	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
767	18	228	\N	29	191	2006-06-15	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
768	18	228	\N	12	135	2006-06-15	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
769	18	228	\N	12	29	2006-06-20	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
770	18	228	\N	135	191	2006-06-20	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
771	18	229	\N	2	107	2006-06-10	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
772	18	229	\N	192	38	2006-06-11	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
773	18	229	\N	2	192	2006-06-16	\N	\N	\N	\N	\N	6	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
774	18	229	\N	38	107	2006-06-16	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
775	18	229	\N	38	2	2006-06-21	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
776	18	229	\N	107	192	2006-06-21	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
777	18	230	\N	89	117	2006-06-11	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
778	18	230	\N	193	31	2006-06-11	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
779	18	230	\N	89	193	2006-06-16	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
780	18	230	\N	31	117	2006-06-17	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
781	18	230	\N	31	89	2006-06-21	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
782	18	230	\N	117	193	2006-06-21	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
783	18	231	\N	140	194	2006-06-12	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
784	18	231	\N	5	131	2006-06-12	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
785	18	231	\N	194	131	2006-06-17	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
786	18	231	\N	5	140	2006-06-17	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
787	18	231	\N	194	5	2006-06-22	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
788	18	231	\N	131	140	2006-06-22	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
789	18	232	\N	101	106	2006-06-12	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
790	18	232	\N	11	63	2006-06-13	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
791	18	232	\N	106	63	2006-06-18	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
792	18	232	\N	11	101	2006-06-18	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
793	18	232	\N	106	11	2006-06-22	\N	\N	\N	\N	\N	1	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
794	18	232	\N	63	101	2006-06-22	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
795	18	233	\N	68	195	2006-06-13	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
796	18	233	\N	23	96	2006-06-13	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
797	18	233	\N	23	68	2006-06-18	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
798	18	233	\N	195	96	2006-06-19	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
799	18	233	\N	195	23	2006-06-23	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
800	18	233	\N	96	68	2006-06-23	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
801	18	234	\N	16	196	2006-06-14	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
802	18	234	\N	110	115	2006-06-14	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
803	18	234	\N	115	196	2006-06-19	\N	\N	\N	\N	\N	0	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
804	18	234	\N	16	110	2006-06-19	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
805	18	234	\N	115	16	2006-06-23	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
806	18	234	\N	196	110	2006-06-23	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
807	18	236	\N	7	12	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
808	18	236	\N	2	89	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
809	18	236	\N	29	108	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
810	18	236	\N	31	38	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
811	18	236	\N	5	101	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
812	18	236	\N	96	196	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
813	18	236	\N	197	198	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
814	18	236	\N	11	131	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
815	18	236	\N	16	23	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
816	18	237	\N	7	2	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
817	18	237	\N	199	200	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
818	18	237	\N	5	196	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
819	18	237	\N	29	31	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
820	18	237	\N	201	202	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
821	18	237	\N	11	23	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
822	18	238	\N	7	5	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
823	18	238	\N	31	23	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
824	18	239	\N	7	31	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
825	18	240	\N	5	23	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
826	18	240	\N	203	204	\N	\N	\N	\N	\N	\N	5	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:14.524852	2026-05-25 20:41:14.524852	\N	\N
827	19	244	\N	90	89	2010-06-11	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
828	19	244	\N	1	23	2010-06-11	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
829	19	244	\N	90	1	2010-06-16	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
830	19	244	\N	23	89	2010-06-17	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
831	19	244	\N	89	1	2010-06-22	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
832	19	244	\N	23	90	2010-06-22	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
833	19	245	\N	68	171	2010-06-12	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
834	19	245	\N	2	172	2010-06-12	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
835	19	245	\N	2	68	2010-06-17	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
836	19	245	\N	171	172	2010-06-17	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
837	19	245	\N	172	68	2010-06-22	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
838	19	245	\N	171	2	2010-06-22	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
839	19	246	\N	29	140	2010-06-12	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
840	19	246	\N	124	187	2010-06-13	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
841	19	246	\N	187	140	2010-06-18	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
842	19	246	\N	29	124	2010-06-18	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
843	19	246	\N	187	29	2010-06-23	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
844	19	246	\N	140	124	2010-06-23	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
845	19	247	\N	205	131	2010-06-13	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
846	19	247	\N	7	101	2010-06-13	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
847	19	247	\N	7	205	2010-06-18	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
848	19	247	\N	131	101	2010-06-19	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
849	19	247	\N	131	7	2010-06-23	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
850	19	247	\N	101	205	2010-06-23	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
851	19	248	\N	38	136	2010-06-14	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
852	19	248	\N	106	150	2010-06-14	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
853	19	248	\N	38	106	2010-06-19	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
854	19	248	\N	150	136	2010-06-19	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
855	19	248	\N	136	106	2010-06-24	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
856	19	248	\N	150	38	2010-06-24	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
857	19	249	\N	5	135	2010-06-14	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
858	19	249	\N	118	206	2010-06-15	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
859	19	249	\N	206	135	2010-06-20	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
860	19	249	\N	5	118	2010-06-20	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
861	19	249	\N	206	5	2010-06-24	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
862	19	249	\N	135	118	2010-06-24	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
863	19	250	\N	107	31	2010-06-15	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
864	19	250	\N	11	145	2010-06-15	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
865	19	250	\N	11	107	2010-06-20	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
866	19	250	\N	31	145	2010-06-21	\N	\N	\N	\N	\N	7	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
867	19	250	\N	31	11	2010-06-25	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
868	19	250	\N	145	107	2010-06-25	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
869	19	251	\N	152	27	2010-06-16	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
870	19	251	\N	16	96	2010-06-16	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
871	19	251	\N	27	96	2010-06-21	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
872	19	251	\N	16	152	2010-06-21	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
873	19	251	\N	27	16	2010-06-25	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
874	19	251	\N	96	152	2010-06-25	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
875	19	253	\N	1	68	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
876	19	253	\N	140	131	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
877	19	253	\N	7	29	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
878	19	253	\N	2	89	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
879	19	253	\N	38	206	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
880	19	253	\N	11	27	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
881	19	253	\N	135	106	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
882	19	253	\N	207	208	\N	\N	\N	\N	\N	\N	5	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
883	19	253	\N	16	31	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
884	19	254	\N	38	11	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
885	19	254	\N	1	131	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
886	19	254	\N	209	210	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
887	19	254	\N	2	7	\N	\N	\N	\N	\N	\N	0	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
888	19	254	\N	135	16	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
889	19	255	\N	1	38	\N	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
890	19	255	\N	7	16	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
891	19	256	\N	1	7	\N	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
892	19	257	\N	38	16	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
893	19	258	\N	211	186	\N	\N	\N	\N	\N	\N	1959	77	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
894	19	258	\N	186	212	\N	\N	\N	\N	\N	\N	1959	77	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
895	19	258	\N	213	186	\N	\N	\N	\N	\N	\N	2011	2022	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:16.55674	2026-05-25 20:41:16.55674	\N	\N
896	20	261	\N	11	63	2014-06-12	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
897	20	261	\N	89	150	2014-06-13	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
898	20	261	\N	11	89	2014-06-17	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
899	20	261	\N	150	63	2014-06-18	\N	\N	\N	\N	\N	0	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
900	20	261	\N	150	11	2014-06-23	\N	\N	\N	\N	\N	1	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
901	20	261	\N	63	89	2014-06-23	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
902	20	262	\N	16	38	2014-06-13	\N	\N	\N	\N	\N	1	5	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
903	20	262	\N	27	101	2014-06-13	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
904	20	262	\N	101	38	2014-06-18	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
905	20	262	\N	16	27	2014-06-18	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
906	20	262	\N	101	16	2014-06-23	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
907	20	262	\N	38	27	2014-06-23	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
908	20	263	\N	134	171	2014-06-14	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
909	20	263	\N	107	106	2014-06-14	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
910	20	263	\N	134	107	2014-06-19	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
911	20	263	\N	106	171	2014-06-19	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
912	20	263	\N	106	134	2014-06-24	\N	\N	\N	\N	\N	1	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
913	20	263	\N	171	107	2014-06-24	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
914	20	264	\N	1	159	2014-06-14	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
915	20	264	\N	29	5	2014-06-14	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
916	20	264	\N	1	29	2014-06-19	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
917	20	264	\N	5	159	2014-06-20	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
918	20	264	\N	5	1	2014-06-24	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
919	20	264	\N	159	29	2014-06-24	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
920	20	265	\N	96	108	2014-06-15	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
921	20	265	\N	23	152	2014-06-15	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
922	20	265	\N	96	23	2014-06-20	\N	\N	\N	\N	\N	2	5	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
923	20	265	\N	152	108	2014-06-20	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
924	20	265	\N	152	96	2014-06-25	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
925	20	265	\N	108	23	2014-06-25	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
926	20	266	\N	2	214	2014-06-15	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
927	20	266	\N	117	172	2014-06-16	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
928	20	266	\N	2	117	2014-06-21	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
929	20	266	\N	172	214	2014-06-21	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
930	20	266	\N	172	2	2014-06-25	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
931	20	266	\N	214	117	2014-06-25	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
932	20	267	\N	7	31	2014-06-16	\N	\N	\N	\N	\N	4	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
933	20	267	\N	131	140	2014-06-16	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
934	20	267	\N	7	131	2014-06-21	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
935	20	267	\N	140	31	2014-06-22	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
936	20	267	\N	140	7	2014-06-26	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
937	20	267	\N	31	131	2014-06-26	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
938	20	268	\N	52	124	2014-06-17	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
939	20	268	\N	170	68	2014-06-17	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
940	20	268	\N	52	170	2014-06-22	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
941	20	268	\N	68	124	2014-06-22	\N	\N	\N	\N	\N	2	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
942	20	268	\N	68	52	2014-06-26	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
943	20	268	\N	124	170	2014-06-26	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
944	20	270	\N	11	27	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
945	20	270	\N	215	216	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
946	20	270	\N	134	1	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
947	20	270	\N	38	89	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
948	20	270	\N	159	171	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
949	20	270	\N	217	218	\N	\N	\N	\N	\N	\N	5	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
950	20	270	\N	23	172	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
951	20	270	\N	7	124	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
952	20	270	\N	2	96	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
953	20	270	\N	52	140	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
954	20	271	\N	23	7	\N	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
955	20	271	\N	11	134	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
956	20	271	\N	2	52	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
957	20	271	\N	38	159	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
958	20	271	\N	219	220	\N	\N	\N	\N	\N	\N	4	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
959	20	272	\N	11	7	\N	\N	\N	\N	\N	\N	1	7	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
960	20	272	\N	38	2	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
961	20	272	\N	221	222	\N	\N	\N	\N	\N	\N	2	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
962	20	273	\N	11	38	\N	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
963	20	274	\N	7	2	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
964	20	275	\N	223	224	\N	\N	\N	\N	\N	\N	1904	12	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
965	20	275	\N	225	226	\N	\N	\N	\N	\N	\N	1904	12	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:18.81535	2026-05-25 20:41:18.81535	\N	\N
966	21	277	\N	170	115	2018-06-14	\N	\N	\N	\N	\N	5	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
967	21	277	\N	114	1	2018-06-15	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
968	21	277	\N	170	114	2018-06-19	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
969	21	277	\N	1	115	2018-06-20	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
970	21	277	\N	1	170	2018-06-25	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
971	21	277	\N	115	114	2018-06-25	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
972	21	278	\N	88	117	2018-06-15	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
973	21	278	\N	31	16	2018-06-15	\N	\N	\N	\N	\N	3	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
974	21	278	\N	31	88	2018-06-20	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
975	21	278	\N	117	16	2018-06-20	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
976	21	278	\N	117	31	2018-06-25	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
977	21	278	\N	16	88	2018-06-25	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
978	21	279	\N	23	101	2018-06-16	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
979	21	279	\N	139	136	2018-06-16	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
980	21	279	\N	136	101	2018-06-21	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
981	21	279	\N	23	139	2018-06-21	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
982	21	279	\N	136	23	2018-06-26	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
983	21	279	\N	101	139	2018-06-26	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
984	21	280	\N	2	227	2018-06-16	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
985	21	280	\N	63	172	2018-06-16	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
986	21	280	\N	2	63	2018-06-21	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
987	21	280	\N	172	227	2018-06-22	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
988	21	280	\N	172	2	2018-06-26	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
989	21	280	\N	227	63	2018-06-26	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
990	21	281	\N	159	205	2018-06-17	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
991	21	281	\N	11	96	2018-06-17	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
992	21	281	\N	11	159	2018-06-22	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
993	21	281	\N	205	96	2018-06-22	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
994	21	281	\N	205	11	2018-06-27	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
995	21	281	\N	96	159	2018-06-27	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
996	21	282	\N	7	89	2018-06-17	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
997	21	282	\N	12	68	2018-06-18	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
998	21	282	\N	68	89	2018-06-23	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
999	21	282	\N	7	12	2018-06-23	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1000	21	282	\N	68	7	2018-06-27	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1001	21	282	\N	89	12	2018-06-27	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1002	21	283	\N	52	132	2018-06-18	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1003	21	283	\N	110	29	2018-06-18	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1004	21	283	\N	52	110	2018-06-23	\N	\N	\N	\N	\N	5	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1005	21	283	\N	29	132	2018-06-24	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1006	21	283	\N	29	52	2018-06-28	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1007	21	283	\N	132	110	2018-06-28	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1008	21	284	\N	134	106	2018-06-19	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1009	21	284	\N	39	120	2018-06-19	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1010	21	284	\N	106	120	2018-06-24	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1011	21	284	\N	39	134	2018-06-24	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1012	21	284	\N	106	39	2018-06-28	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1013	21	284	\N	120	134	2018-06-28	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1014	21	286	\N	23	2	\N	\N	\N	\N	\N	\N	4	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1015	21	286	\N	1	31	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1016	21	286	\N	16	170	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1017	21	286	\N	228	229	\N	\N	\N	\N	\N	\N	3	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1018	21	286	\N	63	136	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1019	21	286	\N	230	231	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1020	21	286	\N	11	89	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1021	21	286	\N	52	106	\N	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1022	21	286	\N	12	96	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1023	21	286	\N	134	29	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1024	21	286	\N	232	233	\N	\N	\N	\N	\N	\N	3	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1025	21	287	\N	1	23	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1026	21	287	\N	11	52	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1027	21	287	\N	12	29	\N	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1028	21	287	\N	170	63	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1029	21	287	\N	234	235	\N	\N	\N	\N	\N	\N	3	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1030	21	288	\N	23	52	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1031	21	288	\N	63	29	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1032	21	289	\N	52	29	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1033	21	290	\N	23	63	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:20.936243	2026-05-25 20:41:20.936243	\N	\N
1034	22	292	\N	95	108	2022-11-20	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1035	22	292	\N	120	38	2022-11-21	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1036	22	292	\N	95	120	2022-11-25	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1037	22	292	\N	38	108	2022-11-25	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1038	22	292	\N	108	120	2022-11-29	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1039	22	292	\N	38	95	2022-11-29	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1040	22	293	\N	29	117	2022-11-21	\N	\N	\N	\N	\N	6	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1041	22	293	\N	140	144	2022-11-21	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1042	22	293	\N	144	117	2022-11-25	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1043	22	293	\N	29	140	2022-11-25	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1044	22	293	\N	144	29	2022-11-29	\N	\N	\N	\N	\N	0	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1045	22	293	\N	117	140	2022-11-29	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1046	22	294	\N	2	115	2022-11-22	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1047	22	294	\N	89	39	2022-11-22	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1048	22	294	\N	39	115	2022-11-26	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1049	22	294	\N	2	89	2022-11-26	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1050	22	294	\N	39	2	2022-11-30	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1051	22	294	\N	115	89	2022-11-30	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1052	22	295	\N	136	110	2022-11-22	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1053	22	295	\N	23	101	2022-11-22	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1054	22	295	\N	110	101	2022-11-26	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1055	22	295	\N	23	136	2022-11-26	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1056	22	295	\N	101	136	2022-11-30	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1057	22	295	\N	110	23	2022-11-30	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1058	22	296	\N	7	106	2022-11-23	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1059	22	296	\N	16	159	2022-11-23	\N	\N	\N	\N	\N	7	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1060	22	296	\N	106	159	2022-11-27	\N	\N	\N	\N	\N	0	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1061	22	296	\N	16	7	2022-11-27	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1062	22	296	\N	106	16	2022-12-01	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1063	22	296	\N	159	7	2022-12-01	\N	\N	\N	\N	\N	2	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1064	22	297	\N	88	63	2022-11-23	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1065	22	297	\N	52	93	2022-11-23	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1066	22	297	\N	52	88	2022-11-27	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1067	22	297	\N	63	93	2022-11-27	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1068	22	297	\N	63	52	2022-12-01	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1069	22	297	\N	93	88	2022-12-01	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1070	22	298	\N	96	150	2022-11-24	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1071	22	298	\N	11	205	2022-11-24	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1072	22	298	\N	150	205	2022-11-28	\N	\N	\N	\N	\N	3	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1073	22	298	\N	11	96	2022-11-28	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1074	22	298	\N	205	96	2022-12-02	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1075	22	298	\N	150	11	2022-12-02	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1076	22	299	\N	1	68	2022-11-24	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1077	22	299	\N	31	131	2022-11-24	\N	\N	\N	\N	\N	3	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1078	22	299	\N	68	131	2022-11-28	\N	\N	\N	\N	\N	2	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1079	22	299	\N	31	1	2022-11-28	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1080	22	299	\N	131	1	2022-12-02	\N	\N	\N	\N	\N	0	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1081	22	299	\N	68	31	2022-12-02	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1082	22	301	\N	38	140	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1083	22	301	\N	2	101	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1084	22	301	\N	23	39	\N	\N	\N	\N	\N	\N	3	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1085	22	301	\N	29	120	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1086	22	301	\N	106	63	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1087	22	301	\N	236	237	\N	\N	\N	\N	\N	\N	1	3	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1088	22	301	\N	11	68	\N	\N	\N	\N	\N	\N	4	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1089	22	301	\N	88	16	\N	\N	\N	\N	\N	\N	0	0	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1090	22	301	\N	238	239	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1091	22	301	\N	31	96	\N	\N	\N	\N	\N	\N	6	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1092	22	302	\N	63	11	\N	\N	\N	\N	\N	\N	1	1	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1093	22	302	\N	240	241	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1094	22	302	\N	38	2	\N	\N	\N	\N	\N	\N	2	2	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1095	22	302	\N	242	243	\N	\N	\N	\N	\N	\N	3	4	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1096	22	302	\N	88	31	\N	\N	\N	\N	\N	\N	1	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1097	22	302	\N	29	23	\N	\N	\N	\N	\N	\N	1	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1098	22	303	\N	2	63	\N	\N	\N	\N	\N	\N	3	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1099	22	303	\N	23	88	\N	\N	\N	\N	\N	\N	2	0	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1100	22	304	\N	63	88	\N	\N	\N	\N	\N	\N	2	1	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1101	22	305	\N	2	23	\N	\N	\N	\N	\N	\N	3	3	\N	\N	\N	\N	t	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
1102	22	305	\N	244	245	\N	\N	\N	\N	\N	\N	4	2	\N	\N	\N	\N	f	f	\N	\N	\N	\N	\N	\N	finalizado	\N	\N	\N	\N	2026-05-25 20:41:22.953359	2026-05-25 20:41:22.953359	\N	\N
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
137	Bolivia	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:41.960691
138	Romania	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:41.960691
139	Peru	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:41.960691
140	United States	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:41.960691
141	Dutch East Indies	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:45.6718
142	Cuba	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:45.6718
143	Northern Ireland	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:50.954384
144	Wales	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:50.954384
145	North Korea	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:55.077957
146	El Salvador	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:56.853011
147	Israel	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:56.853011
148	East Germany	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:58.66773
149	Zaire	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:40:58.66773
150	Cameroon	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:02.634412
151	Kuwait	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:02.634412
152	Honduras	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:02.634412
153	Sócrates Alemão Zico Branco Júlio César	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:04.621766
154	Stopyra Amoros Bellone Platini Fernández	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:04.621766
155	Allofs Brehme Matthäus Littbarski	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:04.621766
156	Negrete Quirarte Servín	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:04.621766
157	Señor Eloy Chendo Butragueño Víctor	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:04.621766
158	Claesen Scifo Broos Vervoort L. Van der Elst	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:04.621766
159	Costa Rica	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
160	United Arab Emirates	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
161	Republic of Ireland	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
162	Sheedy Houghton Townsend Cascarino O'Leary	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
163	Hagi Lupu Rotariu Lupescu Timofte	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
164	Serrizuela Burruchaga Maradona Troglio Dezotti	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
165	Stojković Prosinečki Savićević Brnović Hadžibegić	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
166	Serrizuela Burruchaga Olarticoechea Maradona	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
167	Baresi Baggio De Agostini Donadoni Serena	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
168	Brehme Matthäus Riedle Thon	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
169	Lineker Beardsley Platt Pearce Waddle	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:06.493176
170	Russia	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:08.577315
171	Greece	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:08.577315
172	Nigeria	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:08.577315
173	García Aspe Bernal Rodríguez Suárez	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:08.577315
174	Balakov Genchev Borimirov Letchkov	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:08.577315
175	Márcio Santos Romário Branco Dunga	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:08.577315
176	Baresi Albertini Evani Massaro R. Baggio	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:08.577315
177	FR Yugoslavia	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
178	Jamaica	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
179	Berti Crespo Verón Gallardo Ayala	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
180	Shearer Ince Merson Owen Batty	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
181	R. Baggio Albertini Costacurta Vieri Di Biagio	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
182	Zidane Lizarazu Trezeguet Henry Blanc	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
183	Ronaldo Rivaldo Emerson Dunga	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
184	F. de Boer Bergkamp Cocu R. de Boer	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
185	AFC competitions	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
186	Men	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:10.49477
187	Slovenia	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:12.569858
188	China	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:12.569858
189	Hierro Baraja Juanfran Valerón Mendieta	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:12.569858
190	Robbie Keane Holland Connolly Kilbane Finnan	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:12.569858
191	Trinidad and Tobago	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
192	Serbia and Montenegro	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
193	Angola	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
194	Czech Republic	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
195	Togo	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
196	Ukraine	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
197	Streller Barnetta Cabanas	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
198	Shevchenko Milevskyi Rebrov Husiev	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
199	Neuville Ballack Podolski Borowski	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
200	Cruz Ayala Rodríguez Cambiasso	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
201	Lampard Hargreaves Gerrard Carragher	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
202	Simão Viana Petit Postiga Ronaldo	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
203	Pirlo Materazzi De Rossi Del Piero Grosso	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
204	Wiltord Trezeguet Abidal Sagnol	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:14.524852
205	Serbia	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
206	Slovakia	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
207	Barreto Barrios Riveros Valdez Cardozo	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
208	Endō Hasebe Komano Honda	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
209	Forlán Victorino Scotti M. Pereira Abreu	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
210	Gyan Appiah Mensah Adiyiah	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
211	League system	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
212	Active	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
213	Domestic cups	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:16.55674
214	Bosnia and Herzegovina	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
215	David Luiz Willian Marcelo Hulk Neymar	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
216	Pinilla Sánchez Aránguiz Díaz Jara	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
217	Borges Ruiz González Campbell Umaña	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
218	Mitroglou Christodoulopoulos Holebas Gekas	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
219	Van Persie Robben Sneijder Kuyt	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
220	Borges Ruiz González Bolaños Umaña	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
221	Vlaar Robben Sneijder Kuyt	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
222	Messi Garay Agüero Rodríguez	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
223	Men's	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
224	National teams	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
225	Defunct competitions	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
226	Youth	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:18.81535
227	Iceland	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
228	Iniesta Piqué Koke Ramos Aspas	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
229	Smolov Ignashevich Golovin Cheryshev	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
230	Badelj Kramarić Modrić Pivarić Rakitić	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
231	Eriksen Kjær Krohn-Dehli Schöne N. Jørgensen	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
232	Falcao Ju. Cuadrado Muriel Uribe Bacca	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
233	Kane Rashford Henderson Trippier Dier	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
234	Smolov Dzagoev Fernandes Ignashevich Kuzyayev	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
235	Brozović Kovačić Modrić Vida Rakitić	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:20.936243
236	Minamino Mitoma Asano Yoshida	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
237	Vlašić Brozović Livaja Pašalić	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
238	Sabiri Ziyech Benoun Hakimi	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
239	Sarabia Soler Busquets	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
240	Vlašić Majer Modrić Oršić	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
241	Rodrygo Casemiro Pedro Marquinhos	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
242	Van Dijk Berghuis Koopmeiners Weghorst L. de Jong	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
243	Messi Paredes Montiel Fernández La. Martínez	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
244	Messi Dybala Paredes Montiel	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
245	Mbappé Coman Tchouaméni Kolo Muani	\N	\N	\N	\N	\N	\N	0	0	0	0	0	0	0	0	\N	\N	2026-05-25 20:41:22.953359
\.


--
-- Name: fases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fases_id_seq', 305, true);


--
-- Name: partidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.partidos_id_seq', 1102, true);


--
-- Name: selecciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.selecciones_id_seq', 245, true);


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
-- Name: fases fases_torneo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fases
    ADD CONSTRAINT fases_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES public.torneos(id);


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

\unrestrict c3WNLaazHJMUmdN8SXniNog8vvTZv222v7qSIohTce6sTdD6SmAUammw1fCKBQb

