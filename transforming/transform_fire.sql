DROP TABLE T_Fire1;

CREATE TABLE T_Fire1 AS
SELECT concat(ROUND(fire_data.latitude,2), ROUND(fire_data.longitude,2), acq_date) as fire_id,
   ROUND(fire_data.latitude,2) as fire_lat,
   ROUND(fire_data.longitude,2) as fire_long,
   fire_data.acq_date,
   fire_data.acq_time,
   zip_code_reference_ca.latitude as zip_lat,
   zip_code_reference_ca.longitude as zip_long,
   zip_code_reference_ca.primarycity,
   zip_code_reference_ca.zipcode,
   zip_code_reference_ca.state,
   zip_code_reference_ca.county,
   ABS(ROUND(fire_data.latitude,2) - zip_code_reference_ca.latitude) as lat_diff,
   ABS(ROUND(fire_data.longitude,2) - zip_code_reference_ca.longitude) as long_diff
FROM fire_data
LEFT JOIN zip_code_reference_ca
   ON ROUND(fire_data.latitude,0)=ROUND(zip_code_reference_ca.latitude,0)
   AND ROUND(fire_data.longitude,0)=ROUND(zip_code_reference_ca.longitude,0)
WHERE abs(fire_data.latitude - zip_code_reference_ca.latitude) IS NOT NULL
;


DROP TABLE T_Fire2;

CREATE TABLE T_Fire2 AS
SELECT fire_id,
   MIN(lat_diff) as min_lat
FROM T_Fire1
GROUP BY fire_id
;


DROP TABLE T_Fire3;

CREATE TABLE T_Fire3 AS
SELECT T_Fire1.fire_id,
   T_Fire1.fire_lat,
   T_Fire1.fire_long,
   T_Fire1.acq_date as date,
   T_Fire1.primarycity as city,
   T_Fire1.zipcode,
   T_Fire1.county,
   T_Fire1.state,
   T_Fire2.min_lat,
   T_Fire1.long_diff
FROM T_Fire1
INNER JOIN T_Fire2
   ON T_Fire1.fire_id=T_Fire2.fire_id 
   AND T_Fire1.lat_diff=T_Fire2.min_lat
;



DROP TABLE T_Fire4;

CREATE TABLE T_Fire4 AS
SELECT fire_id,
   min(long_diff) as min_long
FROM T_Fire3
GROUP BY fire_id
;



DROP TABLE T_Fire5;

CREATE TABLE T_Fire5 AS
SELECT T_Fire3.fire_id,
   T_Fire3.fire_lat,
   T_Fire3.fire_long,
   T_Fire3.date,
   T_Fire3.city,
   T_Fire3.zipcode,
   T_Fire3.county,
   T_Fire3.state
FROM T_Fire3
INNER JOIN T_Fire4
   ON T_Fire3.fire_id=T_Fire4.fire_id
   AND T_Fire3.long_diff=T_Fire4.min_long
;

