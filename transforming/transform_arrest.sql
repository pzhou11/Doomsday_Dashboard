DROP TABLE T_Arrest;

CREATE TABLE T_Arrest as

SELECT county, 
   sum(homicide_and_manslaughter_total) as homicide_and_manslaughter_count, 
   sum(felony_violent_total) as felony_violent_count, 
   sum(felony_property_total) as felony_property_count, 
   sum(felony_drug_total) as felony_drug_count, 
   sum(felony_sex_total) as felony_sex_count, 
   sum(felony_other_total) as felony_other_count, 
   sum(total_felonies) as total_felony_count,
   sum(total_misdemeanor) as total_misdemeanor_count,
   sum(total_status_offenses) as total_status_offense_count
FROM arrest_data 
GROUP BY county
;


