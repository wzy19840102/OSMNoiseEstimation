DROP TABLE IF EXISTS noise_areas;

DROP TABLE IF EXISTS road2maxlevel_tmp;

CREATE TABLE noise_areas (

    osm_id  bigint NOT NULL,

    noise_type varchar(40),

    noise_db integer NOT NULL,

    noise_geom geometry(Geometry,4326) NOT NULL

);





CREATE TEMPORARY TABLE road2maxlevel_tmp (

    osm_id  bigint NOT NULL,

    noise_db integer NOT NULL

);



ALTER TABLE ways drop COLUMN IF EXISTS noise_db;

ALTER TABLE ways ADD COLUMN noise_db integer NOT NULL DEFAULT 0;





/****motorway***/

insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 3,  ST_Buffer(linestring::Geography, 60)::Geometry from ways where (tags->'highway')='motorway' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 2,  ST_Buffer(linestring::Geography, 220)::Geometry from ways where (tags->'highway')='motorway' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 1,  ST_Buffer(linestring::Geography, 550)::Geometry from ways where (tags->'highway')='motorway' and linestring is not null;



/****trunk***/

insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 3,  ST_Buffer(linestring::Geography, 50)::Geometry from ways where (tags->'highway')='trunk' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 2,  ST_Buffer(linestring::Geography, 190)::Geometry from ways where (tags->'highway')='trunk' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 1,  ST_Buffer(linestring::Geography, 400)::Geometry from ways where (tags->'highway')='trunk' and linestring is not null;





/******primary*****/

insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 3,  ST_Buffer(linestring::Geography, 35)::Geometry from ways where (tags->'highway')='primary' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 2,  ST_Buffer(linestring::Geography, 160)::Geometry from ways where (tags->'highway')='primary' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 1,  ST_Buffer(linestring::Geography, 300)::Geometry from ways where (tags->'highway')='primary' and linestring is not null;





/****secondary***/

insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 2,  ST_Buffer(linestring::Geography, 80)::Geometry from ways where (tags->'highway')='secondary' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 1,  ST_Buffer(linestring::Geography, 125)::Geometry from ways where (tags->'highway')='secondary' and linestring is not null;



/****tertiary***/

insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 2,  ST_Buffer(linestring::Geography, 35)::Geometry from ways where (tags->'highway')='tertiary' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'highway'), 1,  ST_Buffer(linestring::Geography, 65)::Geometry from ways where (tags->'highway')='tertiary' and linestring is not null;





/****industrial***/

insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'landuse'), 3,  ST_Buffer(linestring::Geography, 50)::Geometry from ways where (tags->'landuse')='industrial' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'landuse'), 2,  ST_Buffer(linestring::Geography, 100)::Geometry from ways where (tags->'landuse')='industrial' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'landuse'), 3,  ST_Buffer(linestring::Geography, 70)::Geometry from ways where (tags->'landuse')='retail' and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'landuse'), 2,  ST_Buffer(linestring::Geography, 180)::Geometry from ways where (tags->'landuse')='retail' and linestring is not null;





/****rail***/

insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'railway'), 3,  ST_Buffer(linestring::Geography, 30)::Geometry from ways where ((tags->'railway') = 'rail' or (tags->'railway') = 'narrow_gauge' or (tags->'railway') = 'preserved') and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'railway'), 2,  ST_Buffer(linestring::Geography, 60)::Geometry from ways where ((tags->'railway') = 'rail' or (tags->'railway') = 'narrow_gauge' or (tags->'railway') = 'preserved') and linestring is not null;



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'railway'), 1,  ST_Buffer(linestring::Geography, 100)::Geometry from ways where ((tags->'railway') = 'rail' or (tags->'railway') = 'narrow_gauge' or (tags->'railway') = 'preserved') and linestring is not null;





/****light rail***/

insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'railway'), 2,  ST_Buffer(linestring::Geography, 30)::Geometry from ways where ((tags->'railway') = 'light_rail' or (tags->'railway') = 'tram' or (tags->'railway') = 'funicular' or (tags->'railway') = 'monorail') and linestring is not null; 



insert into noise_areas (osm_id, noise_type, noise_db, noise_geom)

select id, (tags->'railway'), 1,  ST_Buffer(linestring::Geography, 60)::Geometry from ways where ((tags->'railway') = 'light_rail' or (tags->'railway') = 'tram' or (tags->'railway') = 'funicular' or (tags->'railway') = 'monorail') and linestring is not null;



DROP TABLE IF EXISTS roads_tmp;

CREATE TEMP TABLE roads_tmp AS

SELECT * FROM ways WHERE tags -> 'highway'= 'primary' or  tags -> 'highway' ='motorway' or tags -> 'highway'= 'motorway_link' or  tags -> 'highway' ='motorroad' or tags -> 'highway'= 'trunk' or  tags -> 'highway' ='trunk_link'  or tags -> 'highway'= 'primary_link' or  tags -> 'highway' ='secondary' or tags -> 'highway'= 'secondary_link' or  tags -> 'highway' ='tertiary'  or tags -> 'highway'= 'tertiary_link' or  tags -> 'highway' ='unclassified'  or tags -> 'highway'= 'residential' or  tags -> 'highway' ='living_street' or  tags -> 'highway' ='service'  or tags -> 'highway'= 'road' or  tags -> 'highway' ='track' or  tags -> 'highway' ='construction' or  tags -> 'highway' ='path' or tags -> 'highway' ='steps' or tags -> 'highway' ='footway' or tags -> 'highway' ='pedestrian';



insert into road2maxlevel_tmp (select id, max(noise_db) from (select roads_tmp.id, noise_areas.noise_db from roads_tmp, noise_areas where ST_Intersects(roads_tmp.linestring, noise_areas.noise_geom)) as way2levels group by id);

update ways set noise_db =road2maxlevel_tmp.noise_db from road2maxlevel_tmp where ways.id = road2maxlevel_tmp.osm_id;

Copy (Select id, noise_db From ways where noise_db<>0) To 'D:/noise_data.csv' With CSV DELIMITER ',';

DROP TABLE roads_tmp;

DROP TABLE road2maxlevel_tmp;
