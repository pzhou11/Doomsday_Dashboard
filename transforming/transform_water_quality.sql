DROP TABLE WQ_Sites;

CREATE TABLE WQ_Sites

AS SELECT
  w.SITE_QW_ID as id,
  w.CONSTIT as type,
  w.CONCENTRATION as concentration,
  w.DATE as date,
  s.Station_name as city

FROM WATER_QUALITY w
JOIN WATER_SITES s
ON (w.SITE_QW_ID = s.SITE_QW_ID) 
GROUP BY w.SITE_QW_ID,w.CONSTIT, w.CONCENTRATION, s.Station_name, w.DATE
;





DROP TABLE T_Water_Quality;

CREATE TABLE T_Water_Quality

AS SELECT
  wq.id,
  wq.type,
  wq.concentration,
  wq.date,
  wq.city,
  zip_code_reference_ca.zipcode,
  zip_code_reference_ca.primarycity

FROM WQ_Sites wq
INNER JOIN zip_code_reference_ca
WHERE wq.city LIKE CONCAT('%', zip_code_reference_ca.primarycity, '%')
;
