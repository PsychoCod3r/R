#!/usr/bin/env Rscript
# Command syntax:
#	regression-part.r [--noheader] [-s start] filename.csv
# CSV file must be in one of two formats:
#	independent,dependent
#	index,independent,dependent
# CSV header is optional

args <- commandArgs()
start <- FALSE
h <- TRUE # CSV file has header?
for( arg in args ){
	if( arg == "--noheader" ){
		h <- FALSE
	}
	else if( arg == "-s" ){
		start <- TRUE
	}
	else if( start == TRUE ){
		start <- as.numeric( arg )
	}
	else{
		f <- arg
	}
}
data <- read.csv( f, header = h )
fields <- colnames( data ) # Used for labeling axes
if( ncol( data ) == 2 ){ # No index field
	colnames( data ) <- c( "x", "y" )
}
if( ncol( data ) == 3 ){ # Index field
	colnames( data ) <- c( "x", "q", "y" )
}
data_for_lm <- subset( data, data$x >= start )
lm.data <- lm( y ~ x, data )
if( start != FALSE ){
	lm.data_for_lm <- lm( y ~ x, data_for_lm )
}
plot( data$x, data$y, col = "#0000ff", type = "n", pch = 19,
      # I got an error message if I didn't supply xlim and ylim
      xlim = c( min( data$x ), max( data$x ) ),
      ylim = c( min( data$y ), max( data$y ) ),
      xlab = fields[ncol( data )-1],
      ylab = fields[ncol( data )]  )
lines( data$x, data$y, col = "#0000ff", type = "o" )
abline( lm.data, col="#ff0000" )
if( start != FALSE ){
	abline( lm.data_for_lm, col="#00bb00" )
	print( "Regression for entire data set:" )
}
lm.data # Print slope and intercept
if( start != FALSE ){
	print( "Regression for partial data set:" )
	lm.data_for_lm
}
