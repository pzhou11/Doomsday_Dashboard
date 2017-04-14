DROP TABLE T_Earthquake;

CREATE TABLE T_Earthquake

AS SELECT
  e.time,
  e.latitude,
  e.longitude,
  e.place,
  e.depth,
  e.mag,
  zip_code_reference_ca.zipcode,
  zip_code_reference_ca.primarycity
 
FROM earthquake e
INNER JOIN zip_code_reference_ca
WHERE e.place LIKE CONCAT('%', zip_code_reference_ca.primarycity, '%')
;
