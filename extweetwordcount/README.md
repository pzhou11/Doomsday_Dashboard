Instructions for running Tweepy
- assumed hadoop and postgres started
- as root install psycopg2 by using "pip install psycopg2==2.6.2"
- as root install tweepy by using "pip install tweepy"

1)  Navigate into extweetwordcount directory

2)  Type in "sparse run" and enter

3)  Let it run for whatever minutes, then ctrl+C to stop


Programs
- to run, type in "python <program>" and enter

get_tweets.py
- collects 20 most recent tweets from QuakesInCA
- writes it to a MIDStest.csv file within extweetwordcount directory

tweet_count.py
- collects word, count for the tweets involving earthquake AND Trump that were collected by running tweepy
- writes it to wordcount_results.csv file within extweetwordcount directory


AFTER YOU ARE DONE:
- please do not save MIDStest.csv or wordcount_results.csv to github (this is so a fresh version can be made on each use)


ENJOY!!
