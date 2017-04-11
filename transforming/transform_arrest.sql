DROP TABLE T_Arrest;

CREATE TABLE T_Arrest as

SELECT arrest_data.county, 
   sum(arrest_data.homicide_and_manslaughter_total) as homicide_and_manslaughter_count, 
   sum(arrest_data.felony_violent_total) as felony_violent_count, 
   sum(arrest_data.felony_property_total) as felony_property_count, 
   sum(arrest_data.felony_drug_total) as felony_drug_count, 
   sum(arrest_data.felony_sex_total) as felony_sex_count, 
   sum(arrest_data.felony_other_total) as felony_other_count, 
   sum(arrest_data.total_felonies) as total_felony_count,
   sum(arrest_data.total_misdemeanor) as total_misdemeanor_count,
   sum(arrest_data.total_status_offenses) as total_status_offense_count,
   sum(zip_code_reference_ca.irspopulation2014) as county_population
FROM arrest_data 
LEFT JOIN zip_code_reference_ca
   ON arrest_data.county = zip_code_reference_ca.county
GROUP BY arrest_data.county
;


