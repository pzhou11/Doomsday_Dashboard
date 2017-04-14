CREATE TABLE T_Air_Quality 

AS SELECT air_quality.countyname, 
MAX(air_quality.ReportYear) as year, 
zip_code_reference_ca.zipcode, 
zip_code_reference_ca.County, 
air_quality.value
 
FROM air_quality 
INNER JOIN zip_code_reference_ca 
WHERE zip_code_reference_ca.county LIKE CONCAT(air_quality.CountyName, '%') 
GROUP BY air_quality.countyname, zip_code_reference_ca.zipcode, zip_code_reference_ca.County, air_quality.value 
LIMIT 10;




