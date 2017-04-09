DROP TABLE T_Bridge;

CREATE TABLE T_Bridge as
SELECT
  bridge_data.city,
  bridge_data.county,
  bridge_data.location,
  bridge_data.status,
  zip_code_reference_ca.zipcode,
  zip_code_reference_ca.latitude,
  zip_code_reference_ca.longitude
FROM bridge_data
LEFT JOIN zip_code_reference_ca
  ON UPPER(bridge_data.city) = UPPER(zip_code_reference_ca.primarycity)
WHERE bridge_data.status='Functionally Obsolete' OR bridge_data.status='Structurally Deficient'
;


