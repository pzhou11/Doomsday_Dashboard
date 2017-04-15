DROP TABLE T_Master;

CREATE TABLE T_Master as
SELECT zip_code_reference_ca.zipcode,
   zip_code_reference_ca.primarycity,
   zip_code_reference_ca.county,
   bridge.bad_bridge_count,
   earthquake.earthquake_last_7_days,
   fire.fire_last_7_days
FROM zip_code_reference_ca
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, COUNT(*) as bad_bridge_count
   FROM zip_code_reference_ca LEFT JOIN t_bridge ON zip_code_reference_ca.zipcode=t_bridge.zipcode
   GROUP BY zip_code_reference_ca.zipcode
) bridge ON bridge.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, COUNT(*) as earthquake_last_7_days
   FROM zip_code_reference_ca LEFT JOIN t_earthquake ON zip_code_reference_ca.zipcode=t_earthquake.zipcode
   GROUP BY zip_code_reference_ca.zipcode
) earthquake ON earthquake.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, COUNT(*) as fire_last_7_days
   FROM zip_code_reference_ca LEFT JOIN t_fire5 ON zip_code_reference_ca.zipcode=t_fire5.zipcode
   GROUP BY zip_code_reference_ca.zipcode
) fire ON fire.zipcode = zip_code_reference_ca.zipcode
;


