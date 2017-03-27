#! /bin/bash

# save the current directory
MY_CWD=$(pwd)

# create staging directories
mkdir ~/project
mkdir ~/project/loading

# change to staging directory
cd ~/project/loading

# california arrest data from 2005-2014
ARREST_URL="https://oag.ca.gov/sites/all/files/agweb/pdfs/cjsc/stats/arrest_data_2005-2014.zip"
wget "$ARREST_URL" -O arrest_data.zip

# US fire data for last 7 days
FIRE_URL="https://firms.modaps.eosdis.nasa.gov/active_fire/viirs/text/VNP14IMGTDL_NRT_USA_contiguous_and_Hawaii_7d.csv"
wget "$FIRE_URL" -O fire_data.csv

# california bridge data through 2015
BRIDGE_URL="https://github.com/pzhou11/W205_Project/raw/master/data/merged_bridge.csv"
wget "$BRIDGE_URL" -O bridge_data.csv

# zip code reference file
ZIP_URL="http://federalgovernmentzipcodes.us/free-zipcode-database.csv"
wget "$ZIP_URL" -O zip_reference.csv

# leading causes of death file 1999-2013
DEATH_URL="https://chhs.data.ca.gov/api/views/q4et-a8rk/rows.csv?accessType=DOWNLOAD"
wget "$DEATH_URL" -O death_data.csv

# landslide data 2014-2015
LANSDLIDE_URL="https://data.nasa.gov/api/views/9ns5-uuif/rows.csv?accessType=DOWNLOAD"
wget "$LANSDLIDE_URL" -O landslide_data.csv

# unzip data
unzip arrest_data.zip

# remove first line of files and rename
tail -n +2 arrest_data_2005-2014.csv >arrest_data.csv
tail -n +2 fire_data.csv >fire_data.csv
tail -n +2 bridge_data.csv >bridge_data.csv
tail -n +2 zip_reference.csv >zip_reference.csv
tail -n +2 death_data.csv >death_data.csv
tail -n +2 landslide_data.csv >lanslide_data.csv

# create hdfs director
hdfs dfs -mkdir /user/w205/project

#create hdfs directory for each file and copy each file to hdfs
hdfs dfs -mkdir /user/w205/project/arrest
hdfs dfs -put arrest_data.csv /user/w205/project/arrest

hdfs dfs -mkdir /user/w205/project/fire
hdfs dfs -put fire_data.csv /user/w205/project/fire

hdfs dfs -mkdir /user/w205/project/bridge
hdfs dfs -put bridge_data.csv /user/w205/project/bridge

hdfs dfs -mkdir /user/w205/project/bridge
hdfs dfs -put bridge_data.csv /user/w205/project/zip_reference

hdfs dfs -mkdir /user/w205/project/death
hdfs dfs -put death_data.csv /user/w205/project/death

hdfs dfs -mkdir /user/w205/project/lansdlide
hdfs dfs -put landslide_data.csv /user/w205/project/lansdlide



# change directory back to original
cd $MY_CWD

# clean exit
exit


