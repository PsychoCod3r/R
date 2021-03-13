#!/usr/bin/env Rscript
# Command syntax:
#	regression.r filename.csv [--noheader] [--start n] [--end n]
# CSV file must be in one of two formats:
#	independent,dependent
#	index,independent,dependent
# CSV header is optional

args <- commandArgs()
h <- TRUE # CSV file has header?
isnumber <- FALSE
for( arg in args ){
	if( arg == "--noheader" ){
		h <- FALSE
		isnumber <- FALSE
	}
	else if( arg == "--start" || arg == "--end" ){
	    isnumber <- TRUE
	}
	else if( isnumber == TRUE ){
	    isnumber <- FALSE
	}
	else {
	    f <- arg
	    isnumber <- FALSE
	}
}
data <- read.csv( f, header = h )
start <- min( data$x )
end <- max( data$x )
isstart <- FALSE
isend <- FALSE
for( arg in args ){
    if( arg == "--start" ){
	isstart <- TRUE
    }
    else if( arg == "--end" ){
	isend <- TRUE
    }
    else if( isstart == TRUE ){
	isstart <- FALSE
	start <- as.numeric( arg )
    }
    else if( isend == TRUE ){
	isend <- FALSE
	end <- as.numeric( arg )
    }
}
fields <- colnames( data ) # Used for labeling axes
if( ncol( data ) == 2 ){ # No index field
	colnames( data ) <- c( "x", "y" )
}
if( ncol( data ) == 3 ){ # Index field
	colnames( data ) <- c( "x", "q", "y" )
}
subset.data <- subset( data, data$x >= start & data$x <= end )
lm.data <- lm( y ~ x, subset.data )
plot( data$x, data$y, col = "#0000ff", type = "n", pch = 19,
      # I got an error message if I didn't supply xlim and ylim
      xlim = c( min( data$x ), max( data$x ) ),
      ylim = c( min( data$y ), max( data$y ) ),
      xlab = fields[ncol( data )-1],
      ylab = fields[ncol( data )]  )
lines( data$x, data$y, col = "#0000ff", type = "o" )
abline( lm.data, col="#ff0000" )
lm.data # Print slope and intercept
