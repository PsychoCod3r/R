#!/usr/bin/env Rscript
# Syntax: Rscript tweet-engagement.r by-tweet.csv

file <- commandArgs( 1 )
tweets <- read.csv( file, header = TRUE )

# Indicates which tweets garner the most attention
# for my profile
print( "Tweets with more than 5 profile clicks:" )
for( row in 1:nrow( tweets ) ) {
	clicks <- tweets[row, "user.profile.clicks"]
	if( clicks > 5 ) {
		print( tweets[row, "Tweet.text"] )
	}
}

# Indicates which tweets garner the most traffic
# for my off-site content
print( "Tweets with multiple URL clicks:" )
for( row in 1:nrow( tweets ) ) {
	clicks <- tweets[row, "url.clicks"]
	if( clicks > 1 ) {
		print( tweets[row, "Tweet.text"] )
	}
}

# Indicates which tweets get me the most followers
print( "Tweets with follows:" )
for( row in 1:nrow( tweets ) ) {
	follows <- tweets[row, "follows"]
	if( follows > 0 ) {
		print( tweets[row, "Tweet.text"] )
	}
}
