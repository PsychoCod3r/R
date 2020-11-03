#!/usr/bin/env Rscript
# Prints engagement rate for each tweet

file <- commandArgs( 1 )
tweets <- read.csv( file, header = TRUE )

for( row in 1:nrow( tweets ) ) {
	print( paste( tweets[row, "engagement.rate"], " : ", tweets[row, "Tweet.text"] ) )
}
