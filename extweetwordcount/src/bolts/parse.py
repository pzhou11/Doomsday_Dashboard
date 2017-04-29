from __future__ import absolute_import, print_function, unicode_literals
import re
from streamparse.bolt import Bolt

################################################################################
# Function to check if the string contains only ascii chars
################################################################################
def ascii_string(s):
  return all(ord(c) < 128 for c in s)

class ParseTweet(Bolt):

    def process(self, tup):
        tweet = tup.values[0]  # extract the tweet

        # Split the tweet into words
        words = tweet.split()

	# Change all words to lowercase
	words = [x.lower() for x in words]

        # Filter out the RT, @, stopwords and urls
        valid_words = []
	stop_words = ["i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours", "yourself", "yourselves", "he", 
			"him", "his", "himself", "she", "her", "hers", "herself", "it", "its", "itself", "they", "them", "their", "theirs",
			"themselves", "what", "which", "who", "whom", "this", "that", "these", "those", "am", "is", "are", "was", "were", 
			"be", "been", "being", "have", "has", "had", "having", "do", "does", "did", "doing", "a", "an", "the", "and", "but", 
			"if", "or", "because", "as", "until", "while", "of", "at", "by", "for", "with", "about", "against", "between", "into", 
			"through", "during", "before", "after", "above", "below", "to", "from", "up", "down", "in", "out", "on", "off", "over", 
			"under", "again", "further", "then", "once", "here", "there", "when", "where", "why", "how", "all", "any", "both", 
			"each", "few", "more", "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so", "than", "too", 
			"very", "can", "will", "just", "dont", "should", "now", "want", "will", "rt", "trump", "president", "donald", "trumps",
			"trump's", "would", "via", "it's", "its", "got", "get", "dont", "don't", "he's", "hes", "thats", "that's", "potus", "his"]


        for word in words:

            # Filter the user mentions
            if word.startswith("@"): continue

            # Filter out retweet tags
            if word.startswith("RT"): continue

            # Filter out the urls
            if word.startswith("http"): continue

	    # Strip leading and lagging punctuations
            aword = word.strip("\"?><#,'&-.:;)")

	    # Filter out commonly used words
	    if word in stop_words: continue

            # now check if the word contains only ascii
            if len(aword) > 0 and ascii_string(word):
                valid_words.append([aword])

        if not valid_words: return

        # Emit all the words
        self.emit_many(valid_words)

        # tuple acknowledgement is handled automatically
