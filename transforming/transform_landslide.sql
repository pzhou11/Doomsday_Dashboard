DROP TABLE t_landslide; 
CREATE TABLE t_landslide AS SELECT
  county, 
  count(id) as landslide_count,
  rank() OVER (
    ORDER BY count(id) DESC) as county_rank,
  max(cast (concat
            (substr(date_, 7, 4),
            '-',
            substr(date_, 1, 2),
            '-',
            substr(date_, 4, 2)
            )
        as date)) AS latest_date 
 
FROM landslide_data 
WHERE state = "California" AND county <> "obe"
GROUP BY county
SORT BY landslide_count DESC;
