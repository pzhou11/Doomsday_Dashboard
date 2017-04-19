import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# connect to psycopg2 and tweetcount database
conn = psycopg2.connect(database = "tweetcount", user="postgres", password = "pass", host = "localhost", port = "5432") 
conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

cur = conn.cursor()

# query to copy table "wordcount"
sql_query = """SELECT * FROM  wordcount GROUP BY word, count ORDER BY count DESC"""
csv_query = "COPY ({0}) TO STDOUT WITH CSV HEADER".format(sql_query)

# write "wordcount" to csv
with open('wordcount_results.csv', 'w') as f:
	cur.copy_expert(csv_query, f)

conn.close()
