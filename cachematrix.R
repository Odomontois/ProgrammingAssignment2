## Creating a special object for calculating properties of matrix
## e.g. inverse with caching options

## Class for creating matrices with 
## ability to cache results of operations

CachedOpsMatrix <- setRefClass("CachedOpsMatrix",
	fields = list(
		value = "matrix", 
		inverse = function(){
			if(is.null(my.inverse)) 
				my.inverse <<- solve(value)
			else message("getting cached data")
			my.inverse
		}),
	methods = list(
		initialize = function(...){
			my.inverse <<- NULL
			callSuper(...)
		})
	)

## Creating new caching object

makeCacheMatrix <- function(x = matrix()) {
	CachedOpsMatrix$new(value = x)
}


## Calculating inverse of matrix
## once it was calculated result is cached
## and returned in any consecutive call

cacheSolve <- function(x, ...) {
	x$inverse
}
