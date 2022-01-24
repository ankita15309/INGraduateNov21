--section 29
--create a database airport



CREATE TABLE airports (
	id int NOT NULL,
	ident varchar(10),
	type text,
	name text,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	continent text,
	iso_country varchar(10),
	iso_region varchar(10),
	municipality text,
	scheduled_service text,
	gps_code varchar(10),
	iata_code varchar(20),
	local_code varchar(20),
	home_link text,
	wikipedia_link text,
	keywords text
);

-- this won't work in pgAdmin
COPY airports (	id,ident,type,name,latitude_deg,longitude_deg,elevation_ft,
						continent,iso_country,iso_region,municipality,scheduled_service,
						gps_code,iata_code,local_code,home_link,wikipedia_link,keywords)
FROM '/Users/Will/Desktop/airportdata/airports.csv' DELIMITER ',' CSV HEADER;

--COPY

--OM SQL^
airport=# \copy airports (id,ident,type,name,latitude_deg,longitude_deg,elevation_ft,continent,iso_country,iso_region,municipality,scheduled_service,gps_code,iata_code,local_code,home_link,wikipedia_link,keywords)FROM 'C:\Users\Ankita15309\Downloads/airports.csv' DELIMITER ',' CSV HEADER;
ERROR:  character with byte sequence 0x81 in encoding "WIN1252" has no equivalent in encoding "UTF8"
CONTEXT:  COPY airports, line 10943

SELECT COUNT(*) FROM airports;



--IMPORT airport-frequncies into a table you create airport frequncies


CREATE TABLE airport_frequencies (
	id int,
	airport_ref int,
	airport_ident varchar(10),
	type varchar(20),
	description text,
	frequency_mhz float
)



--\copy airport_frequencies (	id,airport_ref,airport_ident,type,description,frequency_mhz)
--FROM 'FROM 'C:/Users/Ankita15309/Downloads/airport-frequencies.csv' DELIMITER ',' CSV HEADER;

--SELECT COUNT(*) FROM airpot_frequncies



--1)Create a table in airport for navaids and import the CSV file you downloaded.

CREATE TABLE navaids (
	id int,
	filename text,
	ident varchar(10),
	name text,
	type varchar(10),
	frequency_khz float,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	iso_country varchar(10),
	dme_frequency_khz float,
	dme_channel varchar(10),
	dme_latitude_deg float,
	dme_longitude_deg float,
	dme_elevation_ft int,
	slaved_variation_deg float,
	magnetic_variation_deg float,
	usageType char(10),
	power char(10),
	associated_airport varchar(10)
)

airport=# \copy navaids (id,filename, ident, name, type, frequency_khz, latitude_deg, longitude_deg, elevation_ft,
 iso_country, dme_frequency_khz, dme_channel, dme_latitude_deg, dme_longitude_deg, dme_elevation_ft, 
slaved_variation_deg,magnetic_variation_deg, usageType, power, associated_airport)
 FROM 'C:/Users/Ankita15309/Downloads/navaids.csv' DELIMITER ',' CSV HEADER;
COPY 11018
airport=# SELECT COUNT(*) FROM navaids;
 count
-------
 11018
(1 row)

--2)Create a table for regions and import the CSV file you downloaded.

CREATE TABLE regions (
	id int,
	code varchar(10),
	local_code varchar(10),
	name text,
	continent char(2),
	iso_country varchar(10),
	wikipedia_link text,
	keywords text
)

DROP TABLE  if exists regions


CREATE TABLE regions (
	id int,
	code varchar(10),
	local_code varchar(10),
	name text,
	continent char(2),
	iso_country varchar(10),
	wikipedia_link text,
	keywords text
)



--1
CREATE TABLE navaids (
	id int,
	filename text,
	ident varchar(10),
	name text,
	type varchar(10),
	frequency_khz float,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	iso_country varchar(10),
	dme_frequency_khz float,
	dme_channel varchar(10),
	dme_latitude_deg float,
	dme_longitude_deg float,
	dme_elevation_ft int,
	slaved_variation_deg float,
	magnetic_variation_deg float,
	usageType char(10),
	power char(10),
	associated_airport varchar(10)
)

\copy navaids (		id,filename, ident, name, type, frequency_khz, latitude_deg, longitude_deg, elevation_ft, iso_country, dme_frequency_khz, dme_channel, dme_latitude_deg, dme_longitude_deg, dme_elevation_ft, slaved_variation_deg,magnetic_variation_deg, usageType, power, associated_airport) FROM '/Users/Will/Desktop/airportdata/navaids.csv' DELIMITER ',' CSV HEADER;

--2
CREATE TABLE regions (
	id int,
	code varchar(10),
	local_code varchar(10),
	name text,
	continent char(2),
	iso_country varchar(10),
	wikipedia_link text,
	keywords text
)

\copy regions (		id,code, local_code, name, continent, iso_country, wikipedia_link, keywords) FROM 'C:/Users/Ankita15309/Downloads/regions.csv' DELIMITER ',' CSV HEADER;

--3 country

CREATE TABLE countries (
	id int,
	code varchar(10),
	name text,
	continent char(2),
	wikipedia_link text,
	keywords text
)

\copy countries ( id,code, name, continent, wikipedia_link, keywords) FROM 'C:\Users\Ankita15309\Downloads/countries.csv' DELIMITER ',' CSV HEADER;

--4
CREATE TABLE runways (
	id int,
	airport_ref int,
	airport_ident varchar(10),
	length_ft int,
	width_ft int,
	surface text,
	lighted boolean,
	closed boolean,
	le_ident varchar(10),
	le_latitude_deg float,
	le_longitude_deg float,
	le_elevation_ft int,
	le_heading_degT float,
	le_displaced_threshold_ft int,
	he_ident varchar(10),
	he_latitude_deg float,
	he_longitude_deg float,
	he_elevation_ft int,
	he_heading_degT float,
	he_displaced_threshold_ft int
)

\copy runways ( id,airport_ref, airport_ident, length_ft, width_ft, surface, lighted, closed ,le_ident, le_latitude_deg, 
le_longitude_deg, le_elevation_ft, le_heading_degT, le_displaced_threshold_ft, he_ident, he_latitude_deg,
 he_longitude_deg, he_elevation_ft, he_heading_degT, he_displaced_threshold_ft)  
FROM 'C:/Users/Ankita15309/Downloads/runways.csv' DELIMITER ',' CSV HEADER;
