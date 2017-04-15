DROP TABLE AQ_Annual;

CREATE TABLE AQ_Annual
AS SELECT
  Measureid,
  MeasureName,
  MeasureType,
  stratificationlevel,
  statefips,
  statename,
  countyfips,
  countyname,
  reportyear,
  unit,
  unitname,
  dataorigin,
  monitoronly,
  value as annual_value
FROM air_quality
WHERE unitname = 'Micograms per cubic meter'
;


DROP TABLE T_AQ_Annual;

CREATE TABLE T_AQ_Annual
AS SELECT 
  aqa.countyname,
  MAX(aqa.reportyear) as year,
  zip_code_reference_ca.zipcode,
  zip_code_reference_ca.County,
  aqa.annual_value

FROM AQ_Annual aqa
INNER JOIN zip_code_reference_ca
WHERE zip_code_reference_ca.county LIKE CONCAT(aqa.countyname, '%')
GROUP BY aqa.countyname, zip_code_reference_ca.zipcode, zip_code_reference_ca.County, aqa.annual_value
;



DROP TABLE AQ_Percent;

CREATE TABLE AQ_Percent

AS SELECT
  measureid,
  measurename,
  measuretype,
  stratificationlevel,
  statefips,
  statename,
  countyfips,
  countyname,
  reportyear,
  unit,
  unitname,
  dataorigin,
  monitoronly,
  value as percent
FROM air_quality
WHERE unitname = 'Percent'
;



DROP TABLE T_AQ_Percent;

CREATE TABLE T_AQ_Percent
AS SELECT 
  apa.countyname,
  MAX(apa.reportyear) as year,
  zip_code_reference_ca.zipcode,
  zip_code_reference_ca.County,
  apa.percent

FROM AQ_Percent apa
INNER JOIN zip_code_reference_ca
WHERE zip_code_reference_ca.county LIKE CONCAT(apa.countyname, '%')
GROUP BY apa.countyname, zip_code_reference_ca.zipcode, zip_code_reference_ca.County, apa.percent
;







DROP TABLE AQ_Days;

CREATE TABLE AQ_Days

AS SELECT
  measureid,
  measurename,
  measuretype,
  stratificationlevel,
  statefips,
  statename,
  countyfips,
  countyname,
  reportyear,
  unit,
  unitname,
  dataorigin,
  monitoronly,
  value as days
FROM air_quality
WHERE unitname = 'No Units'
;




DROP TABLE T_AQ_Days;

CREATE TABLE T_AQ_Days
AS SELECT
  ada.countyname,
  MAX(ada.reportyear) as year,
  zip_code_reference_ca.zipcode,
  zip_code_reference_ca.County,
  ada.days

FROM AQ_Days ada
INNER JOIN zip_code_reference_ca
WHERE zip_code_reference_ca.county LIKE CONCAT(ada.countyname, '%')
GROUP BY ada.countyname, zip_code_reference_ca.zipcode, zip_code_reference_ca.County, ada.days
;


