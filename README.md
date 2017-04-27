# W205_Project
MIDS W205 Project Working Repository

Instructions for instantiating the project:

1) Use the following AWS AMI: UCB MIDS W205 EX2-FULL - ami-d4dd4ec3
2) Mount your EBS volume to the EC2 instance 
   mount -t ext4 /dev/xvdf /data

3) Start Hadoop 
   /root/start-hadoop.sh
   
4) Start postgres
  /data/start_postgres.sh

5) As root user install tweepy and psycopg 2.6.2
   pip install tweepy
   pip install psycopg2==2.6.2

6) Switch user to w205
   su - w205

7) Start metastore
   /data/start_metastore.sh   
      
8) Clone the project repository
   git clone https://github.com/pzhou11/W205_Project.git
   
9) Change directory to /home/w205/W205_Project/loading

10) Run load_data_lake.sh
   ./load_data_lake.sh
   
11) Start Hive
   hive
   
12) Run hive_base_ddl.sql, then exit Hive
    source hive_base_ddl.sql;
    exit;
    
13) Change directories to /home/w205/W205_Project/transforming
    cd /home/w205/W205_Project/transforming
    
14) Start Hive
    hive
    
15) Run run_all_transform_files.sql
   source run_all_transform_files.sql;
   
16) Now would be a good time to take a break or get a snack...estimated run time ~30 minutes
