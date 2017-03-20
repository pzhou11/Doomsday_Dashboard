DROP TABLE Zip_Code_Reference;

CREATE EXTERNAL TABLE Zip_Code_Reference 
(
  RecordNumber string, 
  Zipcode string,
  ZipCodeType string,
  City string,
  State string,
  LocationType string,
  Latitude string,
  Longitude string,
  Xaxis string,
  Yaxis string,
  Zaxis string,
  WorldRegion string,
  Country string,
  LocationText string,
  Location string,
  Decommisioned string,
  TaxReturns string,
  EstimatedPopulation string,
  TotalWages string,
  Notes string
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
  Year string, 
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

