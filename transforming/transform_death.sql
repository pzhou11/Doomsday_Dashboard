
DROP VIEW vw_death_causes_by_zip;
DROP TABLE t_death;

CREATE VIEW vw_death_causes_by_zip AS SELECT zip_code, cause_of_death, sum(count) AS sum_count 
FROM death_data 
GROUP BY zip_code, cause_of_death 
SORT BY zip_code, sum_count DESC;

CREATE TABLE t_death AS SELECT zip_code, cause_of_death, sum_count,
RANK() OVER (PARTITION by zip_code ORDER BY sum_count DESC) AS d_rank
FROM vw_death_causes_by_zip;
