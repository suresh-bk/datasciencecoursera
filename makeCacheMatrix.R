## There are 2 functions in this file
## makeCacheMatrix functions sets a matrix, sets the inverse and gets the inverse of the matrix
## cacheSolve computes the inverse of the matrix


makeCacheMatrix <- function(mainmat = matrix()){
	invmat <- NULL
	setmat <- function(usermat){
		if(dim(usermat)[1] != dim(usermat)[2]){
			## This if condition checks if the number of rows is same as the number of columns i.e., if it is square matrix. If not give an error message
			message("Non invertible matrix")
		} else if(!identical(mainmat,usermat)){
			## This condition checks if in case earlier a set function was called if the earlier input from the user is same as the current one
			## if it is not same set the values. Else do not do anything
			mainmat <<- usermat
			invmat <<- NULL
		}
	}
	getmat <- function() mainmat
	setinv <- function(inverse) invmat <<- inverse
	getinv <- function() invmat
	list(setmat = setmat, getmat = getmat, setinv = setinv, getinv = getinv)
}

cacheSolve <- function(mainmat,...) {
	## This function computes the inverse of a matirx. Before computing it checks if the inverse already exists. If so, it retrives from the cache and
	## returns it. Else it computes the inverse
	invmat <- mainmat$getinv()
	if(!is.null(invmat)) {
		## Check if the inverse is available in the cache
		message("getting cached data")
		return(invmat)
	}
	data <- mainmat$getmat()
	invmat <- solve(data,...)
	mainmat$setinv(invmat)
	invmat
}