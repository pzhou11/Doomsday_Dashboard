DROP TABLE T_Master_by_County;

CREATE TABLE T_Master_by_County as
SELECT DISTINCT zip_code_reference_ca.county,
   arrest.homicide_per_1000,
   arrest.violent_per_1000,
   arrest.property_per_1000,
   arrest.drug_per_1000,
   arrest.sex_per_1000,
   arrest.other_per_1000,
   landslide.landslide_count,
   landslide.landslide_rank,
   landslide.latest_landslide
FROM zip_code_reference_ca
LEFT JOIN (
   SELECT DISTINCT zip_code_reference_ca.county, 
      round((t_arrest.homicide_and_manslaughter_count/t_arrest.county_population) * 1000, 2) as homicide_per_1000,
      round((t_arrest.felony_violent_count/t_arrest.county_population) * 1000,2) as violent_per_1000,
      round((t_arrest.felony_property_count/t_arrest.county_population) * 1000, 2) as property_per_1000,
      round((t_arrest.felony_drug_count/t_arrest.county_population) * 1000, 2) as drug_per_1000,
      round((t_arrest.felony_sex_count/t_arrest.county_population) * 1000, 2) as sex_per_1000,
      round((t_arrest.felony_other_count/t_arrest.county_population) * 1000, 2) as other_per_1000
   FROM zip_code_reference_ca LEFT JOIN t_arrest ON zip_code_reference_ca.county=t_arrest.county
) arrest ON arrest.county = zip_code_reference_ca.county
LEFT JOIN (
   SELECT DISTINCT zip_code_reference_ca.county, 
      t_landslide.landslide_count as landslide_count, 
      t_landslide.county_rank as landslide_rank,
      t_landslide.latest_date as latest_landslide
   FROM zip_code_reference_ca LEFT JOIN t_landslide ON zip_code_reference_ca.county=t_landslide.county
) landslide ON landslide.county = zip_code_reference_ca.county
;
