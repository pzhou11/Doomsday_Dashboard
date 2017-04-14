DROP TABLE T_Storm;

CREATE TABLE T_Storm

AS SELECT 
   storm.CZ_NAME_STR as city,
   storm.deaths_direct + storm.DEATHS_INDIRECT as deaths,
   storm.INJURIES_DIRECT + storm.INJURIES_INDIRECT as injuries,
   storm.DAMAGE_PROPERTY_NUM + storm.DAMAGE_CROPS_NUM as damages,
   storm.EVENT_TYPE,
   storm.MAGNITUDE,
   storm.TOR_LENGTH + storm.TOR_WIDTH as tor_size,
   storm.TOR_F_SCALE
FROM storm
INNER JOIN zip_code_reference_ca
   WHERE storm.CZ_NAME_STR LIKE CONCAT('%', zip_code_reference_ca.county, '%')
;




