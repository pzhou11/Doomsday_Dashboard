DROP TABLE Zip_Code_Reference;

CREATE EXTERNAL TABLE Zip_Code_Reference
(
  Zipcode int,
  ZipCodeType string,
  Decommissioned string,
  PrimaryCity string,
  AcceptableCity string,
  UnacceptableCity string,
  State string,
  County string,
  TimeZone string,
  AreaCode string,
  WorldRegion string,
  Country string,
  Latitude int,
  Longitude int,
  IRSPopulation2014 int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/zip_reference'
;


DROP TABLE Arrest_Data;

CREATE EXTERNAL TABLE Arrest_Data
(
  Year date,
  Agency string,
  Gender string,
  Race string,
  Age_Group string,
  County string,
  Homicide string,
  Manslaughter_Non_Vehicular string,
  Manslaughter_Vehicular string,
  Rape string,
  Robbery string,
  Assault string,
  Kidnapping string,
  Burglary string,
  Theft string,
  Motor_Vehicle_Theft string,
  Forgery_Money string,
  Narcotics string,
  Marijuana string,
  Dangerous_Drugs string,
  Other_Drugs string,
  Lewd string,
  Unlawful_Sex string,
  Other_Sex_Violations string,
  Weapons string,
  DUI string,
  Hit_and_Run string,
  Escape_Felony string,
  Bookmaking string,
  Arson string,
  Other_Felonies string,
  Vehicle_Manslaughter string,
  Assault_and_Battery string,
  Petty_Theft string,
  Other_Theft string,
  Checks_and_Credit_Cards string,
  Marijuana2 string,
  Dangerous_Drugs2 string,
  Other_Drugs2 string,
  Indecent_Exposure string,
  Annoying_Children string,
  Obscene string,
  Lewd2 string,
  Prostitution string,
  Delinquency_Minor string,
  Drunk string,
  Liquor string,
  Disorderly_Conduct string,
  Disturbing_the_Peace string,
  Vandalism string,
  Malicious_Mischief string,
  Trespassing string,
  Weapons2 string,
  DUI2 string,
  Hit_and_Run2 string,
  Traffic_Violations string,
  Joyriding string,
  Gambling string,
  Nonsupport string,
  Glue_Sniffing string,
  City_Ordinances string,
  FTA_Non_Traffic string,
  Other_Misdemeanors string,
  Burglary_Tools string,
  Other_Sex string,
  Escape2 string,
  Arson_Misdemeanor string,
  Truancy string,
  Runaway string,
  Curfew string,
  Incorrigble string,
  Other_Status_Offenses string,
  Burglary_Misdemeanor string,
  Homicide_and_Manslaughter_Total string,
  Felony_Violent_Total string,
  Felony_Property_Total string,
  Felony_Drug_Total string,
  Felony_Sex_Total string,
  Felony_Other_Total string,
  Total_Felonies string,
  Total_Misdemeanor string,
  Total_Status_Offenses string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/arrest'
;


DROP TABLE Fire_Data;

CREATE EXTERNAL TABLE Fire_Data
(
  Latitude string,
  Longitude string,
  Brightness_Temp_I4 string,
  Scan string,
  Track string,
  Acq_Date string,
  Acq_Time string,
  Satellite string,
  Confidence string,
  Version string,
  Brightness_Temp_I5 string,
  Fire_Power string,
  Day_Night string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/fire'
;


DROP TABLE Bridge_Data;

CREATE EXTERNAL TABLE Bridge_Data
(
  NBINumber string,
  Route string,
  City string,
  County string,
  Intersection string,
  FacilityCarried string,
  Location string,
  Built string,
  Reconstructed string,
  Length string,
  Suff_Rat string,
  Material string,
  Design string,
  Status string,
  Func string,
  Vw string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/bridge'
;

DROP TABLE Death_Data;

CREATE EXTERNAL TABLE Death_Data
(
  year date,
  ZIP_code string,
  cause_of_death string,
  count int,
  location string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/death'
;

DROP TABLE Landslide_Data;

CREATE EXTERNAL TABLE Landslide_Data
(
  the_geom string,
  objectid string,
  id string,
  date_ date,
  time_ string,
  country_ignore string,
  nearest_pl string,
  hazard_typ string,
  lanslide_ string,
  trigger string,
  strom_name string,
  fatalities int,
  injuries int,
  source_nam string,
  source_lin string,
  location_a string,
  landslide1 string,
  photos_lin string,
  cat_src string,
  cat_id int,
  country string,
  near string,
  distance decimal,
  state string,
  county string,
  population int,
  countrycod string,
  continentc string,
  key_ string,
  version int,
  user_id int,
  tstamp string,
  changeset_ string,
  latitude decimal,
  longitude decimal
  )

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/landslide'
;


DROP TABLE Air_Quality;

CREATE EXTERNAL TABLE Air_Quality
(
 MeasureId string,
 MeasureName string,
 MeasureType string,
 StratificationLevel string,
 StateFips int,
 StateName string,
 CountyFips string,
 CountyName string,
 ReportYear int,
 value int,
 Unit string,
 UnitName string,
 DataOrigin string,
 MonitorOnly int
  )

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/air_quality'
;



DROP TABLE Water_Quality;

CREATE EXTERNAL TABLE Water_Quality
(
 SITE_QW_ID int,
 SITE_FLOW_ID int,
 CONSTIT string,
 DATE date,
 WY int,
 CONCENTRATION float,
 REMARK string
  )

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/water_quality'
;


DROP TABLE Water_Sites;

CREATE EXTERNAL TABLE Water_Sites
(
 Station_name string,
 SITE_QW_ID int,
 SITE_FLOW_ID int,
 Site_type string,
 Drainage int,
 Water_years int
  )

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/water_sites'
;



DROP TABLE Earthquake;

CREATE EXTERNAL TABLE Earthquake
(
 time timestamp,
 latitude float,
 longitude float,
 depth float,
 mag float,
 magType string,
 nst int,
 gap int,
 dmin float,
 rms float,
 net string,
 id string,
 updated timestamp,
 place string,
 type string,
 horizontalError float,
 depthError float,
 magError float,
 magNet int,
 status string,
 locationSource string,
 magSource string
  )

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/earthquake'
;


DROP TABLE Civil_Unrest;

CREATE EXTERNAL TABLE Civil_Unrest
(
 month int,
 year int,
 eventid string,
 country string,
 day int,
 N_INJURD int,
 GP3 string,
 GP4 string,
 GP7 float,
 GP8 float,
 AD_VIOL int,
 N_KILLED_P int,
 N_KILLED_A INT,
 E_LENGTH INT,
 N_INJURD_D INT,
 DAM_PROP INT,
 arrests int,
 PER_ATK_E int,
 STAT_VIOL float,
 coup int
  )

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/civil_unrest'
;

DROP TABLE Storm;

CREATE EXTERNAL TABLE Storm
(
  EVENT_ID int,
  CZ_NAME_STR string,
  BEGIN_LOCATION string,
  BEGIN_DATE date,
  BEGIN_TIME int,
  EVENT_TYPE string,
  MAGNITUDE int,
  TOR_F_SCALE int,
  DEATHS_DIRECT int,
  INJURIES_DIRECT int,
  DAMAGE_PROPERTY_NUM int,
  DAMAGE_CROPS_NUM int,
  CZ_TIMEZONE string,
  MAGNITUDE_TYPE string,
  EPISODE_ID int,
  CZ_TYPE string,
  CZ_FIPS int,
  INJURIES_INDIRECT int,
  DEATHS_INDIRECT int,
  FLOOD_CAUSE string,
  TOR_LENGTH int,
  TOR_WIDTH int,
  BEGIN_LAT int,
  BEGIN_LONG int,
  END_LAT int,
  END_LONG int
  )

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = '"',
  "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/project/storm'
;
