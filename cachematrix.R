## Creating a special object for calculating properties of matrix
## e.g. inverse with caching options

## Class for creating matrices with 
## ability to cache results of operations

CachedOpsMatrix <- setRefClass("CachedOpsMatrix",
	fields = list(value = "matrix" ),

	methods = list(
		initialize = function(...){
			my.inverse <<- NULL
			callSuper(...)
		},

		getInverse = function(){
			"Calculating inverse of matrix. Once it was calculated result is cached and returned in any consecutive call"
			if(is.null(my.inverse)) 
				my.inverse <<- solve(value)
			else message("getting cached data")
			my.inverse
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
	x$getInverse()
}
