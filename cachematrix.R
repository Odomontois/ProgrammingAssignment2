## Creating a special object for caching calculations
# example:
# m <- matrix(1:4,c(2,2))
# mci <- makeCacheMatrix({message("calculating");solve(m)})
# cacheSolve(mci)
# cacheSolve(mci) # should not print message again, should insted inform about cache use 
# mcs <- makeCacheMatrix(solve(m,c(1,1))
# cacheSolve(mcs)

# Class for creating matrices with 
# ability to cache results of operations
# see CacheOps$help(getResult)
CachedOps <- setRefClass("CachedOps",
	fields = list(func = "function", cache = "ANY"),

	methods = list(
		initialize = function(expr,...){
			cache <<- NULL
      func <<- function(){
        expr
      }
			callSuper(...)
		},

		getResult = function(){
			"Calculating result of operation on matrix. 
Once it was calculated result is cached and returned in any consecutive call"
			if(is.null(cache)) 
				cache <<- func()
			else message("getting cached data")
			cache
		})
	)

makeCacheMatrix <- function(expr,...) {
  # Creating new caching object
  # Args:
  #   func - function, result of calculation is need to cache
  #   ... - parameters for function calling
	CachedOps$new(expr,...)
}

cacheSolve <- function(x) {
  # Calculating result of function on matrix
  # once it was calculated result is cached
  # and returned in any consecutive call
	x$getResult()
}
