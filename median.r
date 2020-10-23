#!/usr/bin/env Rscript
# Finds the median engagement rate of the tweets in a CSV file
# and then prints lists for tweets that are above and tweets
# that are below the median.

file <- commandArgs( 1 )
tweets <- read.csv( file, header = TRUE )

# Convert engagement.rate column to number vector
rates <- as.vector( tweets[,"engagement.rate"] )
for( n in 1:length( rates ) ) {
	rates[n] <- as.numeric( rates[n] )
}

median.engagement = median( rates )

# Find subset of table where engagement.rate > median.engagement
print( "Tweets with above-average engagement:" );
for( row in 1:nrow( tweets ) ) {
	engagement <- as.numeric( tweets[row, "engagement.rate"] )
	if( engagement > median.engagement ) {
		print( tweets[row, "Tweet.text"] )
	}
}

# Find subset of table where engagement.rate <= median.engagement
print( "Tweets with below-average engagement:" );
for( row in 1:nrow( tweets ) ) {
	engagement <- as.numeric( tweets[row, "engagement.rate"] )
	if( engagement <= median.engagement ) {
		print( tweets[row, "Tweet.text"] )
	}
}
