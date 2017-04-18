from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT



class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()

	# Connect to psycog - use psycopg to interact with Postgres
	conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

      	# Create Database: tweetcount
    	try:
		conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
		cur = conn.cursor()
		cur.execute("CREATE DATABASE tweetcount")
		cur.close()
		conn.close()
	except:
		print("Could not create database")

	# Table name: wordcount
        conn = psycopg2.connect(database = "tweetcount", user="postgres", password = "pass", host = "localhost", port = "5432")

        #create cursor
        cur = conn.cursor()
        cur.execute('''DROP TABLE IF EXISTS wordcount; CREATE TABLE wordcount
                        (word TEXT PRIMARY KEY NOT NULL,
                        count INT NOT NULL);''')
        conn.commit()
        cur.close()


    def process(self, tup):
        conn = psycopg2.connect(database = "tweetcount", user="postgres", password = "pass", host = "localhost", port = "5432") 
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

	#create cursor
        cur = conn.cursor()
       	conn.commit()

	word = tup.values[0]
	
        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])
	
	# check the word from table and get counts
	cur.execute("SELECT word, count FROM wordcount WHERE word=%s", (word,))
	record = cur.fetchone()

	# if not in database, then insert word/count, otherwise update word/count
        if record == None:
		cur.execute("INSERT INTO wordcount (word, count) VALUES (%s, %s)", (word, self.counts[word]))
		conn.commit()
		
	else:
		cur.execute("UPDATE wordcount SET count=%s WHERE word=%s", (self.counts[word], word))
		conn.commit()
	

	# Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
