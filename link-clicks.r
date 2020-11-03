#!/usr/bin/env Rscript
# Prints link clicks for each tweet

file <- commandArgs( 1 )
tweets <- read.csv( file, header = TRUE )

for( row in 1:nrow( tweets ) ) {
	print( paste( tweets[row, "url.clicks"], tweets[row, "permalink.clicks"], tweets[row, "Tweet.text"] ) )
}
