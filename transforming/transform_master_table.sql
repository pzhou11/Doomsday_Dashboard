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

DROP TABLE T_Master;

CREATE TABLE T_Master as
SELECT zip_code_reference_ca.zipcode,
   zip_code_reference_ca.primarycity,
   zip_code_reference_ca.county,
   obsolete_bridge.obsolete_bridge_count,
   deficient_bridge.deficient_bridge_count,
   earthquake.num_of_earthquakes_last_7_days,
   earthquake.most_recent_earthquake,
   earthquake.max_magnitude_last_7_days,
   fire.fire_last_7_days,
   death1.cause_of_death1,
   death1.num_of_deaths_of_cause1,
   death2.cause_of_death2,
   death2.num_of_deaths_of_cause2,
   death3.cause_of_death3,
   death3.num_of_deaths_of_cause3,
   death4.cause_of_death4,
   death4.num_of_deaths_of_cause4,
   death5.cause_of_death5,
   death5.num_of_deaths_of_cause5,
   water_quality.most_recent_water_quality,
   water_quality.avg_water_quality_concentration,
   aq_annual.aq_annual_year,
   aq_annual.aq_annual_value,
   aq_percent.aq_percent_year,
   aq_percent.aq_percent_value,
   aq_days.aq_days_year,
   aq_days.aq_days,
   storm.storm_deaths,
   storm.storm_injuries,
   storm.storm_damages,
   storm.storm_type,
   master_by_county.homicide_per_1000,
   master_by_county.violent_per_1000,
   master_by_county.property_per_1000,
   master_by_county.drug_per_1000,
   master_by_county.sex_per_1000,
   master_by_county.other_per_1000,
   master_by_county.landslide_count,
   master_by_county.landslide_rank,
   master_by_county.latest_landslide
FROM zip_code_reference_ca
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, 
      COUNT(*) as obsolete_bridge_count
   FROM zip_code_reference_ca LEFT JOIN t_bridge ON zip_code_reference_ca.zipcode=t_bridge.zipcode
   WHERE t_bridge.status = 'Functionally Obsolete'
   GROUP BY zip_code_reference_ca.zipcode
) obsolete_bridge ON obsolete_bridge.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, 
      COUNT(*) as deficient_bridge_count
   FROM zip_code_reference_ca LEFT JOIN t_bridge ON zip_code_reference_ca.zipcode=t_bridge.zipcode
   WHERE t_bridge.status = 'Structurally Deficient'
   GROUP BY zip_code_reference_ca.zipcode
) deficient_bridge ON deficient_bridge.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, 
      CASE
         WHEN MAX(t_earthquake.time) IS NULL
            THEN 0
            ELSE COUNT(*)
      END as num_of_earthquakes_last_7_days, 
      MAX(t_earthquake.time) as most_recent_earthquake, 
      MAX(t_earthquake.mag) as max_magnitude_last_7_days
   FROM zip_code_reference_ca LEFT JOIN t_earthquake ON zip_code_reference_ca.zipcode=t_earthquake.zipcode
   GROUP BY zip_code_reference_ca.zipcode
) earthquake ON earthquake.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, 
      COUNT(*) as fire_last_7_days
   FROM zip_code_reference_ca LEFT JOIN t_fire5 ON zip_code_reference_ca.zipcode=t_fire5.zipcode
   GROUP BY zip_code_reference_ca.zipcode
) fire ON fire.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_death.cause_of_death as cause_of_death1,
         t_death.sum_count as num_of_deaths_of_cause1,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_death.cause_of_death DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_death ON zip_code_reference_ca.zipcode=t_death.zip_code
      WHERE t_death.d_rank=1
   ) death_1
   WHERE death_1.rank = 1
) death1 ON death1.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_death.cause_of_death as cause_of_death2,
         t_death.sum_count as num_of_deaths_of_cause2,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_death.cause_of_death DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_death ON zip_code_reference_ca.zipcode=t_death.zip_code
      WHERE t_death.d_rank=2
   ) death_2
   WHERE death_2.rank = 1
) death2 ON death2.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_death.cause_of_death as cause_of_death3,
         t_death.sum_count as num_of_deaths_of_cause3,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_death.cause_of_death DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_death ON zip_code_reference_ca.zipcode=t_death.zip_code
      WHERE t_death.d_rank=3
   ) death_3
   WHERE death_3.rank = 1
) death3 ON death3.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_death.cause_of_death as cause_of_death4,
         t_death.sum_count as num_of_deaths_of_cause4,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_death.cause_of_death DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_death ON zip_code_reference_ca.zipcode=t_death.zip_code
      WHERE t_death.d_rank=4
   ) death_4
   WHERE death_4.rank = 1
) death4 ON death4.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_death.cause_of_death as cause_of_death5,
         t_death.sum_count as num_of_deaths_of_cause5,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_death.cause_of_death DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_death ON zip_code_reference_ca.zipcode=t_death.zip_code
      WHERE t_death.d_rank=5
   ) death_5
   WHERE death_5.rank = 1
) death5 ON death5.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, 
      MAX(t_water_quality.date) as most_recent_water_quality, 
      AVG(t_water_quality.concentration) as avg_water_quality_concentration
   FROM zip_code_reference_ca LEFT JOIN t_water_quality ON zip_code_reference_ca.zipcode=t_water_quality.zipcode
   GROUP BY zip_code_reference_ca.zipcode
) water_quality ON water_quality.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_aq_annual.year as aq_annual_year,
         t_aq_annual.annual_value as aq_annual_value,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_aq_annual.year DESC, t_aq_annual.annual_value DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_aq_annual ON zip_code_reference_ca.zipcode=t_aq_annual.zipcode
   ) aq_annual_1
   WHERE aq_annual_1.rank = 1
) aq_annual ON aq_annual.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_aq_percent.year as aq_percent_year,
         t_aq_percent.percent as aq_percent_value,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_aq_percent.year DESC, t_aq_percent.percent DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_aq_percent ON zip_code_reference_ca.zipcode=t_aq_percent.zipcode
   ) aq_percent_1
   WHERE aq_percent_1.rank = 1
) aq_percent ON aq_percent.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_aq_days.year as aq_days_year,
         t_aq_days.days as aq_days,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_aq_days.year DESC, t_aq_days.days DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_aq_days ON zip_code_reference_ca.zipcode=t_aq_days.zipcode
      WHERE t_aq_days.days < 365
   ) aq_days_1
   WHERE aq_days_1.rank = 1
) aq_days ON aq_days.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT * FROM (
      SELECT zip_code_reference_ca.zipcode, 
         t_storm.deaths as storm_deaths,
         t_storm.injuries as storm_injuries,
         t_storm.damages as storm_damages,
         t_storm.event_type as storm_type,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_storm.damages DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_storm ON UPPER(zip_code_reference_ca.primarycity)=UPPER(t_storm.city)
      WHERE t_storm.damages <> 0 
   ) storm_1
   WHERE storm_1.rank = 1
) storm ON storm.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode,
      t_master_by_county.homicide_per_1000,
      t_master_by_county.violent_per_1000,
      t_master_by_county.property_per_1000,
      t_master_by_county.drug_per_1000,
      t_master_by_county.sex_per_1000,
      t_master_by_county.other_per_1000,
      t_master_by_county.landslide_count,
      t_master_by_county.landslide_rank,
      t_master_by_county.latest_landslide
   FROM zip_code_reference_ca LEFT JOIN t_master_by_county ON zip_code_reference_ca.county=t_master_by_county.county
) master_by_county ON master_by_county.zipcode = zip_code_reference_ca.zipcode
;


