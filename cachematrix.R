## Creating a special object for caching calculations
# example:
# m <- matrix(1:4,c(2,2))
# mci <- makeCacheMatrix({message("calculating");solve(m)})
# cacheSolve(mci)
# cacheSolve(mci) # should not print message again, should insted inform about cache use 
# mcs <- makeCacheMatrix(m, c(1,1))
# cacheSolve(mcs)

# Class for creating matrices with 
# ability to cache results of operations
CachedOps <- setRefClass("CachedOps",
  fields = list( func = "function", cache = "ANY"),

  methods = list(
    initialize = function(...,func){
    cache <<- NULL
    func <<- function() func(...)
    callSuper()
    },

    getResult = function(){
      "Calculating result of operation on matrix. 
Once it was calculated result is cached and returned in any consecutive call"
      if(is.null(cache)) {
        cache <<- func()
      }else{
        message("getting cached data")
      }
      cache
    })
  )

makeCacheMatrix <- function(..., func = solve) {
  # Creating new caching object
  # Args:
  #   func - function, result of calculation is need to cache
  #   ... - parameters for function calling
  CachedOps$new(..., func = func)
}

cacheSolve <- function(x, ...) {
  # Calculating result of function on matrix
  # once it was calculated result is cached
  # and returned in any consecutive call
  x$getResult()
}
