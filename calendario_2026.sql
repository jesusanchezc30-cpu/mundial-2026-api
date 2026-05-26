-- ============================================================
-- CALENDARIO MUNDIAL 2026
-- Horas en hora local del estadio y hora Espana (CEST = UTC+2)
-- ET+6=ESP | CT+7=ESP | PT+9=ESP | Mexico City+7=ESP
-- ============================================================

-- Anadir columnas de hora al schema si no existen
ALTER TABLE partidos ADD COLUMN IF NOT EXISTS hora_espana TIME;
ALTER TABLE partidos ADD COLUMN IF NOT EXISTS hora_local TIME;

-- Torneo 2026
INSERT INTO torneos (anyo, nombre, pais_sede, paises_sede, fecha_inicio, fecha_fin, num_equipos, num_partidos)
VALUES (2026, 'FIFA World Cup 2026', 'USA/Mexico/Canada',
        ARRAY['Estados Unidos','Mexico','Canada'],
        '2026-06-11', '2026-07-19', 48, 104)
ON CONFLICT (anyo) DO UPDATE SET
    num_equipos = EXCLUDED.num_equipos,
    num_partidos = EXCLUDED.num_partidos;

-- Fases
INSERT INTO fases (torneo_id, nombre, orden)
SELECT id, 'Fase de grupos', 1 FROM torneos WHERE anyo = 2026
ON CONFLICT (torneo_id, nombre) DO NOTHING;
INSERT INTO fases (torneo_id, nombre, orden)
SELECT id, 'Ronda de 32', 2 FROM torneos WHERE anyo = 2026
ON CONFLICT (torneo_id, nombre) DO NOTHING;
INSERT INTO fases (torneo_id, nombre, orden)
SELECT id, 'Octavos de final', 3 FROM torneos WHERE anyo = 2026
ON CONFLICT (torneo_id, nombre) DO NOTHING;
INSERT INTO fases (torneo_id, nombre, orden)
SELECT id, 'Cuartos de final', 4 FROM torneos WHERE anyo = 2026
ON CONFLICT (torneo_id, nombre) DO NOTHING;
INSERT INTO fases (torneo_id, nombre, orden)
SELECT id, 'Semifinales', 5 FROM torneos WHERE anyo = 2026
ON CONFLICT (torneo_id, nombre) DO NOTHING;
INSERT INTO fases (torneo_id, nombre, orden)
SELECT id, 'Tercer puesto', 6 FROM torneos WHERE anyo = 2026
ON CONFLICT (torneo_id, nombre) DO NOTHING;
INSERT INTO fases (torneo_id, nombre, orden)
SELECT id, 'Final', 7 FROM torneos WHERE anyo = 2026
ON CONFLICT (torneo_id, nombre) DO NOTHING;

-- Selecciones
INSERT INTO selecciones (nombre, codigo_fifa, confederacion) VALUES
('Mexico','MEX','CONCACAF'),('South Africa','RSA','CAF'),
('South Korea','KOR','AFC'),('Czechia','CZE','UEFA'),
('Canada','CAN','CONCACAF'),('Bosnia Herzegovina','BIH','UEFA'),
('Qatar','QAT','AFC'),('Switzerland','SUI','UEFA'),
('Brazil','BRA','CONMEBOL'),('Morocco','MAR','CAF'),
('Haiti','HAI','CONCACAF'),('Scotland','SCO','UEFA'),
('Australia','AUS','AFC'),('Turkey','TUR','UEFA'),
('Germany','GER','UEFA'),('Curacao','CUW','CONCACAF'),
('Netherlands','NED','UEFA'),('Japan','JPN','AFC'),
('Ivory Coast','CIV','CAF'),('Ecuador','ECU','CONMEBOL'),
('Sweden','SWE','UEFA'),('Tunisia','TUN','CAF'),
('Spain','ESP','UEFA'),('Cape Verde','CPV','CAF'),
('Belgium','BEL','UEFA'),('Egypt','EGY','CAF'),
('Saudi Arabia','KSA','AFC'),('Uruguay','URU','CONMEBOL'),
('Iran','IRN','AFC'),('New Zealand','NZL','OFC'),
('France','FRA','UEFA'),('Senegal','SEN','CAF'),
('Iraq','IRQ','AFC'),('Norway','NOR','UEFA'),
('Argentina','ARG','CONMEBOL'),('Algeria','ALG','CAF'),
('Austria','AUT','UEFA'),('Jordan','JOR','AFC'),
('Portugal','POR','UEFA'),('DR Congo','COD','CAF'),
('England','ENG','UEFA'),('Croatia','CRO','UEFA'),
('Ghana','GHA','CAF'),('Panama','PAN','CONCACAF'),
('Uzbekistan','UZB','AFC'),('Colombia','COL','CONMEBOL'),
('Paraguay','PAR','CONMEBOL'),('Denmark','DEN','UEFA')
ON CONFLICT (nombre) DO UPDATE SET
    codigo_fifa = EXCLUDED.codigo_fifa,
    confederacion = EXCLUDED.confederacion;

-- Funcion auxiliar para grupos
CREATE OR REPLACE FUNCTION ins_partido(
    p_grupo VARCHAR, p_jornada INT,
    p_local VARCHAR, p_visitante VARCHAR,
    p_fecha DATE,
    p_hora_local TIME, p_hora_espana TIME,
    p_zona VARCHAR, p_estadio VARCHAR
) RETURNS VOID AS $$
DECLARE
    v_torneo_id INT;
    v_fase_id INT;
    v_estadio_id INT;
    v_local_id INT;
    v_visitante_id INT;
BEGIN
    SELECT id INTO v_torneo_id FROM torneos WHERE anyo = 2026;
    SELECT id INTO v_fase_id FROM fases
        WHERE torneo_id = v_torneo_id AND nombre = 'Fase de grupos';
    SELECT id INTO v_estadio_id FROM estadios
        WHERE nombre ILIKE '%' || p_estadio || '%' LIMIT 1;
    SELECT id INTO v_local_id FROM selecciones WHERE nombre = p_local;
    SELECT id INTO v_visitante_id FROM selecciones WHERE nombre = p_visitante;
    INSERT INTO partidos (
        torneo_id, fase_id, estadio_id,
        seleccion_local_id, seleccion_visitante_id,
        fecha, hora_local, hora_espana, zona_horaria, grupo, jornada, estado)
    VALUES (
        v_torneo_id, v_fase_id, v_estadio_id,
        v_local_id, v_visitante_id,
        p_fecha, p_hora_local, p_hora_espana, p_zona, p_grupo, p_jornada, 'pendiente')
    ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- GRUPO A — Mexico City (CT=UTC-5, ESP=CT+7) | Zapopan igual
-- ============================================================
-- Jue 11 Jun: Mexico vs South Africa 21:00 local / 03:00 ESP (dia sig)
SELECT ins_partido('A',1,'Mexico','South Africa','2026-06-11','21:00','03:00','America/Mexico_City','Azteca');
-- Jue 11 Jun: South Korea vs Czechia 20:00 local Zapopan / 03:00 ESP (dia sig)
SELECT ins_partido('A',1,'South Korea','Czechia','2026-06-11','20:00','03:00','America/Mexico_City','Akron');
-- Jue 18 Jun: Czechia vs South Africa 12:00 ET Atlanta / 18:00 ESP
SELECT ins_partido('A',2,'Czechia','South Africa','2026-06-18','12:00','18:00','America/New_York','Mercedes-Benz');
-- Jue 18 Jun: Mexico vs South Korea 21:00 local Zapopan / 04:00 ESP (dia sig)
SELECT ins_partido('A',2,'Mexico','South Korea','2026-06-18','21:00','04:00','America/Mexico_City','Akron');
-- Mie 24 Jun: Czechia vs Mexico 21:00 local Mexico City / 04:00 ESP (dia sig)
SELECT ins_partido('A',3,'Czechia','Mexico','2026-06-24','21:00','04:00','America/Mexico_City','Azteca');
-- Mie 24 Jun: South Africa vs South Korea 21:00 local Monterrey / 04:00 ESP (dia sig)
SELECT ins_partido('A',3,'South Africa','South Korea','2026-06-24','21:00','04:00','America/Mexico_City','BBVA');

-- ============================================================
-- GRUPO B — Toronto (ET), Santa Clara (PT), Vancouver (PT)
-- ============================================================
-- Jue 12 Jun: Canada vs Bosnia 15:00 ET Toronto / 21:00 ESP
SELECT ins_partido('B',1,'Canada','Bosnia Herzegovina','2026-06-12','15:00','21:00','America/Toronto','BMO');
-- Sab 13 Jun: Qatar vs Switzerland 15:00 PT Santa Clara / 00:00 ESP (dia sig)
SELECT ins_partido('B',1,'Qatar','Switzerland','2026-06-13','15:00','00:00','America/Los_Angeles','Levis');
-- Jue 18 Jun: Switzerland vs Bosnia 15:00 PT SoFi / 00:00 ESP (dia sig)
SELECT ins_partido('B',2,'Switzerland','Bosnia Herzegovina','2026-06-18','15:00','00:00','America/Los_Angeles','SoFi');
-- Jue 18 Jun: Canada vs Qatar 18:00 PT Vancouver / 03:00 ESP (dia sig)
SELECT ins_partido('B',2,'Canada','Qatar','2026-06-18','18:00','03:00','America/Vancouver','BC Place');
-- Mie 24 Jun: Switzerland vs Canada 15:00 PT Vancouver / 00:00 ESP (dia sig)
SELECT ins_partido('B',3,'Switzerland','Canada','2026-06-24','15:00','00:00','America/Vancouver','BC Place');
-- Mie 24 Jun: Bosnia vs Qatar 15:00 PT Seattle / 00:00 ESP (dia sig)
SELECT ins_partido('B',3,'Bosnia Herzegovina','Qatar','2026-06-24','15:00','00:00','America/Los_Angeles','Lumen');

-- ============================================================
-- GRUPO C — MetLife ET, Gillette ET, Hard Rock ET, Mercedes ET
-- ============================================================
-- Sab 13 Jun: Brazil vs Morocco 18:00 ET MetLife / 00:00 ESP (dia sig)
SELECT ins_partido('C',1,'Brazil','Morocco','2026-06-13','18:00','00:00','America/New_York','MetLife');
-- Sab 13 Jun: Haiti vs Scotland 21:00 ET Gillette / 03:00 ESP (dia sig)
SELECT ins_partido('C',1,'Haiti','Scotland','2026-06-13','21:00','03:00','America/New_York','Gillette');
-- Vie 19 Jun: Scotland vs Morocco 18:00 ET Gillette / 00:00 ESP (dia sig)
SELECT ins_partido('C',2,'Scotland','Morocco','2026-06-19','18:00','00:00','America/New_York','Gillette');
-- Vie 19 Jun: Brazil vs Haiti 20:30 ET Lincoln / 02:30 ESP (dia sig)
SELECT ins_partido('C',2,'Brazil','Haiti','2026-06-19','20:30','02:30','America/New_York','Lincoln');
-- Mie 24 Jun: Scotland vs Brazil 18:00 ET Hard Rock / 00:00 ESP (dia sig)
SELECT ins_partido('C',3,'Scotland','Brazil','2026-06-24','18:00','00:00','America/New_York','Hard Rock');
-- Mie 24 Jun: Morocco vs Haiti 18:00 ET Mercedes / 00:00 ESP (dia sig)
SELECT ins_partido('C',3,'Morocco','Haiti','2026-06-24','18:00','00:00','America/New_York','Mercedes-Benz');

-- ============================================================
-- GRUPO D — SoFi PT, BC Place PT, Lumen PT, Levis PT
-- ============================================================
-- Vie 12 Jun: USA vs Paraguay 21:00 PT SoFi / 06:00 ESP (dia sig)
SELECT ins_partido('D',1,'USA','Paraguay','2026-06-12','21:00','06:00','America/Los_Angeles','SoFi');
-- Dom 14 Jun: Australia vs Turkey 00:00 PT BC Place (sabado noche) / 09:00 ESP
SELECT ins_partido('D',1,'Australia','Turkey','2026-06-14','00:00','09:00','America/Vancouver','BC Place');
-- Jue 19 Jun: USA vs Australia 15:00 PT Lumen / 00:00 ESP (dia sig)
SELECT ins_partido('D',2,'USA','Australia','2026-06-19','15:00','00:00','America/Los_Angeles','Lumen');
-- Vie 19 Jun: Turkey vs Paraguay 23:00 PT Levis / 08:00 ESP (dia sig)
SELECT ins_partido('D',2,'Turkey','Paraguay','2026-06-19','23:00','08:00','America/Los_Angeles','Levis');
-- Jue 25 Jun: Turkey vs USA 22:00 PT SoFi / 07:00 ESP (dia sig)
SELECT ins_partido('D',3,'Turkey','USA','2026-06-25','22:00','07:00','America/Los_Angeles','SoFi');
-- Jue 25 Jun: Paraguay vs Australia 22:00 PT Levis / 07:00 ESP (dia sig)
SELECT ins_partido('D',3,'Paraguay','Australia','2026-06-25','22:00','07:00','America/Los_Angeles','Levis');

-- ============================================================
-- GRUPO E — NRG CT, Lincoln ET, BMO ET, Arrowhead CT
-- ============================================================
-- Dom 14 Jun: Germany vs Curacao 13:00 CT NRG / 20:00 ESP
SELECT ins_partido('E',1,'Germany','Curacao','2026-06-14','13:00','20:00','America/Chicago','NRG');
-- Dom 14 Jun: Ivory Coast vs Ecuador 19:00 ET Lincoln / 01:00 ESP (dia sig)
SELECT ins_partido('E',1,'Ivory Coast','Ecuador','2026-06-14','19:00','01:00','America/New_York','Lincoln');
-- Sab 20 Jun: Germany vs Ivory Coast 16:00 ET BMO / 22:00 ESP
SELECT ins_partido('E',2,'Germany','Ivory Coast','2026-06-20','16:00','22:00','America/Toronto','BMO');
-- Sab 20 Jun: Ecuador vs Curacao 20:00 CT Arrowhead / 03:00 ESP (dia sig)
SELECT ins_partido('E',2,'Ecuador','Curacao','2026-06-20','20:00','03:00','America/Chicago','Arrowhead');
-- Jue 25 Jun: Curacao vs Ivory Coast 16:00 ET Lincoln / 22:00 ESP
SELECT ins_partido('E',3,'Curacao','Ivory Coast','2026-06-25','16:00','22:00','America/New_York','Lincoln');
-- Jue 25 Jun: Ecuador vs Germany 16:00 ET MetLife / 22:00 ESP
SELECT ins_partido('E',3,'Ecuador','Germany','2026-06-25','16:00','22:00','America/New_York','MetLife');

-- ============================================================
-- GRUPO F — ATT CT, BBVA CT, NRG CT, Arrowhead CT
-- ============================================================
-- Dom 14 Jun: Netherlands vs Japan 16:00 CT ATT / 23:00 ESP
SELECT ins_partido('F',1,'Netherlands','Japan','2026-06-14','16:00','23:00','America/Chicago','ATT');
-- Dom 14 Jun: Sweden vs Tunisia 22:00 CT BBVA / 05:00 ESP (dia sig)
SELECT ins_partido('F',1,'Sweden','Tunisia','2026-06-14','22:00','05:00','America/Chicago','BBVA');
-- Sab 20 Jun: Netherlands vs Sweden 13:00 CT NRG / 20:00 ESP
SELECT ins_partido('F',2,'Netherlands','Sweden','2026-06-20','13:00','20:00','America/Chicago','NRG');
-- Dom 21 Jun: Tunisia vs Japan 00:00 CT BBVA / 07:00 ESP
SELECT ins_partido('F',2,'Tunisia','Japan','2026-06-21','00:00','07:00','America/Chicago','BBVA');
-- Jue 25 Jun: Japan vs Sweden 19:00 CT ATT / 02:00 ESP (dia sig)
SELECT ins_partido('F',3,'Japan','Sweden','2026-06-25','19:00','02:00','America/Chicago','ATT');
-- Jue 25 Jun: Tunisia vs Netherlands 19:00 CT Arrowhead / 02:00 ESP (dia sig)
SELECT ins_partido('F',3,'Tunisia','Netherlands','2026-06-25','19:00','02:00','America/Chicago','Arrowhead');

-- ============================================================
-- GRUPO G — Lumen PT, SoFi PT, BC Place PT
-- ============================================================
-- Lun 15 Jun: Belgium vs Egypt 15:00 PT Lumen / 00:00 ESP (dia sig)
SELECT ins_partido('G',1,'Belgium','Egypt','2026-06-15','15:00','00:00','America/Los_Angeles','Lumen');
-- Lun 15 Jun: Iran vs New Zealand 21:00 PT SoFi / 06:00 ESP (dia sig)
SELECT ins_partido('G',1,'Iran','New Zealand','2026-06-15','21:00','06:00','America/Los_Angeles','SoFi');
-- Dom 21 Jun: Belgium vs Iran 15:00 PT SoFi / 00:00 ESP (dia sig)
SELECT ins_partido('G',2,'Belgium','Iran','2026-06-21','15:00','00:00','America/Los_Angeles','SoFi');
-- Dom 21 Jun: New Zealand vs Egypt 21:00 PT BC Place / 06:00 ESP (dia sig)
SELECT ins_partido('G',2,'New Zealand','Egypt','2026-06-21','21:00','06:00','America/Los_Angeles','BC Place');
-- Vie 26 Jun: Egypt vs Iran 23:00 PT Lumen / 08:00 ESP (dia sig)
SELECT ins_partido('G',3,'Egypt','Iran','2026-06-26','23:00','08:00','America/Los_Angeles','Lumen');
-- Vie 26 Jun: New Zealand vs Belgium 23:00 PT BC Place / 08:00 ESP (dia sig)
SELECT ins_partido('G',3,'New Zealand','Belgium','2026-06-26','23:00','08:00','America/Los_Angeles','BC Place');

-- ============================================================
-- GRUPO H — Mercedes ET, Hard Rock ET, NRG CT, Akron CT
-- ============================================================
-- Lun 15 Jun: Spain vs Cape Verde 12:00 ET Mercedes / 18:00 ESP
SELECT ins_partido('H',1,'Spain','Cape Verde','2026-06-15','12:00','18:00','America/New_York','Mercedes-Benz');
-- Lun 15 Jun: Saudi Arabia vs Uruguay 18:00 ET Hard Rock / 00:00 ESP (dia sig)
SELECT ins_partido('H',1,'Saudi Arabia','Uruguay','2026-06-15','18:00','00:00','America/New_York','Hard Rock');
-- Dom 21 Jun: Spain vs Saudi Arabia 12:00 ET Mercedes / 18:00 ESP
SELECT ins_partido('H',2,'Spain','Saudi Arabia','2026-06-21','12:00','18:00','America/New_York','Mercedes-Benz');
-- Dom 21 Jun: Uruguay vs Cape Verde 18:00 ET Hard Rock / 00:00 ESP (dia sig)
SELECT ins_partido('H',2,'Uruguay','Cape Verde','2026-06-21','18:00','00:00','America/New_York','Hard Rock');
-- Vie 26 Jun: Cape Verde vs Saudi Arabia 20:00 CT NRG / 03:00 ESP (dia sig)
SELECT ins_partido('H',3,'Cape Verde','Saudi Arabia','2026-06-26','20:00','03:00','America/Chicago','NRG');
-- Vie 26 Jun: Uruguay vs Spain 20:00 CT Akron / 03:00 ESP (dia sig)
SELECT ins_partido('H',3,'Uruguay','Spain','2026-06-26','20:00','03:00','America/Chicago','Akron');

-- ============================================================
-- GRUPO I — MetLife ET, Gillette ET, Lincoln ET, BMO ET
-- ============================================================
-- Mar 16 Jun: France vs Senegal 15:00 ET MetLife / 21:00 ESP
SELECT ins_partido('I',1,'France','Senegal','2026-06-16','15:00','21:00','America/New_York','MetLife');
-- Mar 16 Jun: Iraq vs Norway 18:00 ET Gillette / 00:00 ESP (dia sig)
SELECT ins_partido('I',1,'Iraq','Norway','2026-06-16','18:00','00:00','America/New_York','Gillette');
-- Lun 22 Jun: France vs Iraq 17:00 ET Lincoln / 23:00 ESP
SELECT ins_partido('I',2,'France','Iraq','2026-06-22','17:00','23:00','America/New_York','Lincoln');
-- Lun 22 Jun: Norway vs Senegal 20:00 ET MetLife / 02:00 ESP (dia sig)
SELECT ins_partido('I',2,'Norway','Senegal','2026-06-22','20:00','02:00','America/New_York','MetLife');
-- Vie 26 Jun: Norway vs France 15:00 ET Gillette / 21:00 ESP
SELECT ins_partido('I',3,'Norway','France','2026-06-26','15:00','21:00','America/New_York','Gillette');
-- Vie 26 Jun: Senegal vs Iraq 15:00 ET BMO / 21:00 ESP
SELECT ins_partido('I',3,'Senegal','Iraq','2026-06-26','15:00','21:00','America/Toronto','BMO');

-- ============================================================
-- GRUPO J — Arrowhead CT, Levis PT, ATT CT
-- ============================================================
-- Mar 16 Jun: Argentina vs Algeria 21:00 CT Arrowhead / 04:00 ESP (dia sig)
SELECT ins_partido('J',1,'Argentina','Algeria','2026-06-16','21:00','04:00','America/Chicago','Arrowhead');
-- Mie 17 Jun: Austria vs Jordan 00:00 PT Levis (martes noche) / 09:00 ESP
SELECT ins_partido('J',1,'Austria','Jordan','2026-06-17','00:00','09:00','America/Los_Angeles','Levis');
-- Lun 22 Jun: Argentina vs Austria 13:00 CT ATT / 20:00 ESP
SELECT ins_partido('J',2,'Argentina','Austria','2026-06-22','13:00','20:00','America/Chicago','ATT');
-- Lun 22 Jun: Jordan vs Algeria 23:00 PT Levis / 08:00 ESP (dia sig)
SELECT ins_partido('J',2,'Jordan','Algeria','2026-06-22','23:00','08:00','America/Los_Angeles','Levis');
-- Sab 27 Jun: Algeria vs Austria 22:00 CT Arrowhead / 05:00 ESP (dia sig)
SELECT ins_partido('J',3,'Algeria','Austria','2026-06-27','22:00','05:00','America/Chicago','Arrowhead');
-- Sab 27 Jun: Jordan vs Argentina 22:00 CT ATT / 05:00 ESP (dia sig)
SELECT ins_partido('J',3,'Jordan','Argentina','2026-06-27','22:00','05:00','America/Chicago','ATT');

-- ============================================================
-- GRUPO K — NRG CT, Azteca CT, Akron CT, Hard Rock ET, Mercedes ET
-- ============================================================
-- Mie 17 Jun: Portugal vs DR Congo 13:00 CT NRG / 20:00 ESP
SELECT ins_partido('K',1,'Portugal','DR Congo','2026-06-17','13:00','20:00','America/Chicago','NRG');
-- Mie 17 Jun: Uzbekistan vs Colombia 22:00 CT Azteca / 05:00 ESP (dia sig)
SELECT ins_partido('K',1,'Uzbekistan','Colombia','2026-06-17','22:00','05:00','America/Chicago','Azteca');
-- Mar 23 Jun: Portugal vs Uzbekistan 13:00 CT NRG / 20:00 ESP
SELECT ins_partido('K',2,'Portugal','Uzbekistan','2026-06-23','13:00','20:00','America/Chicago','NRG');
-- Mar 23 Jun: Colombia vs DR Congo 22:00 CT Akron / 05:00 ESP (dia sig)
SELECT ins_partido('K',2,'Colombia','DR Congo','2026-06-23','22:00','05:00','America/Chicago','Akron');
-- Sab 27 Jun: Colombia vs Portugal 19:30 ET Hard Rock / 01:30 ESP (dia sig)
SELECT ins_partido('K',3,'Colombia','Portugal','2026-06-27','19:30','01:30','America/New_York','Hard Rock');
-- Sab 27 Jun: DR Congo vs Uzbekistan 19:30 ET Mercedes / 01:30 ESP (dia sig)
SELECT ins_partido('K',3,'DR Congo','Uzbekistan','2026-06-27','19:30','01:30','America/New_York','Mercedes-Benz');

-- ============================================================
-- GRUPO L — ATT CT, BMO ET, Gillette ET, Lincoln ET, MetLife ET
-- ============================================================
-- Mie 17 Jun: England vs Croatia 16:00 CT ATT / 23:00 ESP
SELECT ins_partido('L',1,'England','Croatia','2026-06-17','16:00','23:00','America/Chicago','ATT');
-- Mie 17 Jun: Ghana vs Panama 19:00 ET BMO / 01:00 ESP (dia sig)
SELECT ins_partido('L',1,'Ghana','Panama','2026-06-17','19:00','01:00','America/Toronto','BMO');
-- Mar 23 Jun: England vs Ghana 16:00 ET Gillette / 22:00 ESP
SELECT ins_partido('L',2,'England','Ghana','2026-06-23','16:00','22:00','America/New_York','Gillette');
-- Mar 23 Jun: Panama vs Croatia 19:00 ET BMO / 01:00 ESP (dia sig)
SELECT ins_partido('L',2,'Panama','Croatia','2026-06-23','19:00','01:00','America/Toronto','BMO');
-- Sab 27 Jun: Panama vs England 17:00 ET MetLife / 23:00 ESP
SELECT ins_partido('L',3,'Panama','England','2026-06-27','17:00','23:00','America/New_York','MetLife');
-- Sab 27 Jun: Croatia vs Ghana 17:00 ET Lincoln / 23:00 ESP
SELECT ins_partido('L',3,'Croatia','Ghana','2026-06-27','17:00','23:00','America/New_York','Lincoln');

-- ============================================================
-- FASES ELIMINATORIAS
-- ============================================================
CREATE OR REPLACE FUNCTION ins_elim(
    p_fase VARCHAR, p_num INT,
    p_desc_local VARCHAR, p_desc_visitante VARCHAR,
    p_fecha DATE, p_hora_local TIME, p_hora_espana TIME,
    p_zona VARCHAR, p_estadio VARCHAR
) RETURNS VOID AS $$
DECLARE
    v_torneo_id INT;
    v_fase_id INT;
    v_estadio_id INT;
BEGIN
    SELECT id INTO v_torneo_id FROM torneos WHERE anyo = 2026;
    SELECT id INTO v_fase_id FROM fases
        WHERE torneo_id = v_torneo_id AND nombre = p_fase;
    SELECT id INTO v_estadio_id FROM estadios
        WHERE nombre ILIKE '%' || p_estadio || '%' LIMIT 1;
    INSERT INTO partidos (torneo_id, fase_id, estadio_id,
        fecha, hora_local, hora_espana, zona_horaria, estado, curiosidades)
    VALUES (v_torneo_id, v_fase_id, v_estadio_id,
        p_fecha, p_hora_local, p_hora_espana, p_zona, 'pendiente',
        json_build_object('match_num', p_num,
            'local_desc', p_desc_local,
            'visitante_desc', p_desc_visitante)::text)
    ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- Ronda de 32 (28 Jun - 3 Jul)
SELECT ins_elim('Ronda de 32',73,'2o A','2o B','2026-06-28','15:00','21:00','America/Los_Angeles','SoFi');
SELECT ins_elim('Ronda de 32',74,'1o E','Mejor 3o','2026-06-29','16:30','22:30','America/New_York','Gillette');
SELECT ins_elim('Ronda de 32',75,'1o F','2o C','2026-06-29','23:00','05:00','America/Chicago','BBVA');
SELECT ins_elim('Ronda de 32',76,'1o C','2o F','2026-06-29','13:00','19:00','America/Chicago','NRG');
SELECT ins_elim('Ronda de 32',77,'1o I','Mejor 3o','2026-06-30','17:00','23:00','America/New_York','MetLife');
SELECT ins_elim('Ronda de 32',78,'2o E','2o I','2026-06-30','13:00','19:00','America/Chicago','ATT');
SELECT ins_elim('Ronda de 32',79,'1o A','Mejor 3o','2026-06-30','21:00','04:00','America/Mexico_City','Azteca');
SELECT ins_elim('Ronda de 32',80,'1o L','Mejor 3o','2026-07-01','12:00','18:00','America/New_York','Mercedes-Benz');
SELECT ins_elim('Ronda de 32',81,'1o D','Mejor 3o','2026-07-01','20:00','05:00','America/Los_Angeles','Levis');
SELECT ins_elim('Ronda de 32',82,'1o G','Mejor 3o','2026-07-01','16:00','22:00','America/Los_Angeles','Lumen');
SELECT ins_elim('Ronda de 32',83,'2o K','2o L','2026-07-02','19:00','01:00','America/Toronto','BMO');
SELECT ins_elim('Ronda de 32',84,'1o H','2o J','2026-07-02','15:00','21:00','America/Los_Angeles','SoFi');
SELECT ins_elim('Ronda de 32',85,'1o B','Mejor 3o','2026-07-02','23:00','07:00','America/Vancouver','BC Place');
SELECT ins_elim('Ronda de 32',86,'1o J','2o H','2026-07-03','18:00','00:00','America/New_York','Hard Rock');
SELECT ins_elim('Ronda de 32',87,'1o K','Mejor 3o','2026-07-03','21:30','03:30','America/Chicago','Arrowhead');
SELECT ins_elim('Ronda de 32',88,'2o D','2o G','2026-07-03','14:00','20:00','America/Chicago','ATT');

-- Octavos de final (4-7 Jul)
SELECT ins_elim('Octavos de final',89,'Gan 74','Gan 77','2026-07-04','17:00','23:00','America/New_York','Lincoln');
SELECT ins_elim('Octavos de final',90,'Gan 73','Gan 75','2026-07-04','13:00','19:00','America/Chicago','NRG');
SELECT ins_elim('Octavos de final',91,'Gan 76','Gan 78','2026-07-05','16:00','22:00','America/New_York','MetLife');
SELECT ins_elim('Octavos de final',92,'Gan 79','Gan 80','2026-07-05','20:00','03:00','America/Mexico_City','Azteca');
SELECT ins_elim('Octavos de final',93,'Gan 83','Gan 84','2026-07-06','15:00','21:00','America/Chicago','ATT');
SELECT ins_elim('Octavos de final',94,'Gan 81','Gan 82','2026-07-06','20:00','05:00','America/Los_Angeles','Lumen');
SELECT ins_elim('Octavos de final',95,'Gan 86','Gan 88','2026-07-07','12:00','18:00','America/New_York','Mercedes-Benz');
SELECT ins_elim('Octavos de final',96,'Gan 85','Gan 87','2026-07-07','16:00','23:00','America/Vancouver','BC Place');

-- Cuartos de final (9-11 Jul)
SELECT ins_elim('Cuartos de final',97,'Gan 89','Gan 90','2026-07-09','16:00','22:00','America/New_York','Gillette');
SELECT ins_elim('Cuartos de final',98,'Gan 93','Gan 94','2026-07-10','15:00','22:00','America/Los_Angeles','SoFi');
SELECT ins_elim('Cuartos de final',99,'Gan 91','Gan 92','2026-07-11','17:00','23:00','America/New_York','Hard Rock');
SELECT ins_elim('Cuartos de final',100,'Gan 95','Gan 96','2026-07-11','21:00','04:00','America/Chicago','Arrowhead');

-- Semifinales (14-15 Jul)
SELECT ins_elim('Semifinales',101,'Gan 97','Gan 98','2026-07-14','15:00','21:00','America/Chicago','ATT');
SELECT ins_elim('Semifinales',102,'Gan 99','Gan 100','2026-07-15','15:00','21:00','America/New_York','Mercedes-Benz');

-- Tercer puesto (18 Jul)
SELECT ins_elim('Tercer puesto',103,'Per 101','Per 102','2026-07-18','17:00','23:00','America/New_York','Hard Rock');

-- Final (19 Jul)
SELECT ins_elim('Final',104,'Gan 101','Gan 102','2026-07-19','15:00','21:00','America/New_York','MetLife');

-- Limpiar funciones
DROP FUNCTION IF EXISTS ins_partido(VARCHAR,INT,VARCHAR,VARCHAR,DATE,TIME,TIME,VARCHAR,VARCHAR);
DROP FUNCTION IF EXISTS ins_elim(VARCHAR,INT,VARCHAR,VARCHAR,DATE,TIME,TIME,VARCHAR,VARCHAR);

-- Verificacion final
SELECT f.nombre as fase, COUNT(*) as partidos
FROM partidos p
JOIN torneos t ON t.id = p.torneo_id
JOIN fases f ON f.id = p.fase_id
WHERE t.anyo = 2026
GROUP BY f.nombre, f.orden
ORDER BY f.orden;
