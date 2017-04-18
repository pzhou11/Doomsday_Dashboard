DROP TABLE T_Master;

CREATE TABLE T_Master as
SELECT zip_code_reference_ca.zipcode,
   zip_code_reference_ca.primarycity,
   zip_code_reference_ca.county,
   bridge.bad_bridge_count,
   earthquake.num_of_earthquakes_last_7_days,
   earthquake.most_recent_earthquake,
   earthquake.max_magnitude_last_7_days,
   fire.fire_last_7_days,
   death.top_cause_of_death,
   death.num_of_deaths_of_top_cause,
   water_quality.most_recent_water_quality,
   water_quality.avg_water_quality_concentration
FROM zip_code_reference_ca
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, 
      COUNT(*) as bad_bridge_count
   FROM zip_code_reference_ca LEFT JOIN t_bridge ON zip_code_reference_ca.zipcode=t_bridge.zipcode
   GROUP BY zip_code_reference_ca.zipcode
) bridge ON bridge.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, 
      COUNT(*) as num_of_earthquakes_last_7_days, 
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
         t_death.cause_of_death as top_cause_of_death,
         t_death.sum_count as num_of_deaths_of_top_cause,
         RANK() OVER (PARTITION BY zip_code_reference_ca.zipcode ORDER BY t_death.cause_of_death DESC) AS Rank
      FROM zip_code_reference_ca LEFT JOIN t_death ON zip_code_reference_ca.zipcode=t_death.zip_code
      WHERE t_death.d_rank=1
   ) death_1
   WHERE death_1.rank = 1
) death ON death.zipcode = zip_code_reference_ca.zipcode
LEFT JOIN (
   SELECT zip_code_reference_ca.zipcode, 
      MAX(t_water_quality.date) as most_recent_water_quality, 
      AVG(t_water_quality.concentration) as avg_water_quality_concentration
   FROM zip_code_reference_ca LEFT JOIN t_water_quality ON zip_code_reference_ca.zipcode=t_water_quality.zipcode
   GROUP BY zip_code_reference_ca.zipcode
) water_quality ON water_quality.zipcode = zip_code_reference_ca.zipcode
;


