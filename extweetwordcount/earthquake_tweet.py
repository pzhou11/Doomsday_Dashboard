from __future__ import absolute_import, print_function, unicode_literals

import itertools, time
import tweepy, copy 
import Queue, threading
import csv
from streamparse.spout import Spout

################################################################################
# Twitter credentials
################################################################################
twitter_credentials = {
    "consumer_key"        :  "YBBUh4mehGbp6MFkzAFsfDNHl",
    "consumer_secret"     :  "6ttL4wtLIrORgwWzyCyNM33t2Atswbaakwru4uoWg7FTnmuRFd",
    "access_token"        :  "1511952991-pukEYajl8dr8a0kTJqPK6HSLIFsDmfeDl7jpljz",
    "access_token_secret" :  "KUMzwLwWTQbdJ4xxJGoOm3P11xGJhZtEH7qPS1jLZQlSh",
}


def get_tweets(user_name):

        consumer_key = "YBBUh4mehGbp6MFkzAFsfDNHl"
        consumer_secret = "6ttL4wtLIrORgwWzyCyNM33t2Atswbaakwru4uoWg7FTnmuRFd" 
        access_token = "1511952991-pukEYajl8dr8a0kTJqPK6HSLIFsDmfeDl7jpljz"
        access_token_secret = "KUMzwLwWTQbdJ4xxJGoOm3P11xGJhZtEH7qPS1jLZQlSh"

	auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
	
	api = tweepy.API(auth)
	
	# create a list of most recent tweets
	tweet_list = []
	
	# save tweets in the list
	tweet = api.user_timeline(screen_name = user_name, count = 5)
	tweet_list.extend(tweet)

	# convert into an array, include time and text
	csv_tweet = [[post.created_at, post.text.encode("utf-8")] for post in tweet_list]
	
	with open('%s.csv' % user_name, 'w') as f:
		write = csv.writer(f)
		write.writerow(["time_created", "post"])
		write.writerows(csv_tweet)

pass

if __name__ == '__main__':
	get_tweets("MIDStest")
