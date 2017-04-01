DROP TABLE T_Air_Quality;

CREATE TABLE T_Air_Quality

AS SELECT
  StateName,
  CountyName,
  Value,
  Unit

FROM Air_Quality
;