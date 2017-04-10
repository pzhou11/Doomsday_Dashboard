DROP TABLE T_Storm;

CREATE TABLE T_Storm as

SELECT storm.CZ_NAME_STR,
   sum(storm.DEATHS_DIRECT and storm.DEATHS_INDIRECT) as deaths,
   sum(storm.INJURIES_DIRECT and INJURIES_INDIRECT) as injuries,
   sum(storm.DAMAGE_PROPERTY_NUM and DAMAGE_CROPS_NUM) as damages,
   storm.EVENT_TYPE,
   storm.MAGNITUDE,
   storm.TOR_F_SCALE 
FROM storm
LEFT JOIN zip_code_reference
   ON storm.CZ_NAME_STR = zip_code_reference_ca.county
GROUP BY storm.CZ_NAME_STR
