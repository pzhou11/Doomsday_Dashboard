DROP TABLE T_Earthquake;

CREATE TABLE T_Earthquake

AS SELECT
  time,
  latitude,
  longitude,
  depth,
  mag,
  updated

FROM Earthquake
WHERE mag > 4
;