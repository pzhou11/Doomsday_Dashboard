# combines water_quality and water_sites

DROP TABLE T_Water_Quality;

CREATE TABLE T_Water_Quality

AS SELECT
  w.SITE_QW_ID,
  w.CONSTIT,
  w.CONCENTRATION,
  w. DATE,
  s.Station_name

FROM WATER_QUALITY w
JOIN WATER_SITES s
ON (w.SITE_QW_ID = s.SITE_QW_ID) 
GROUP BY w.SITE_QW_ID,w.CONSTIT, w.CONCENTRATION, s.Station_name, w.DATE
;