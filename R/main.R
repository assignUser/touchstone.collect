# n ~ 1000 = 77ms
# n ~ 5000 = 2s
# n ~ 10000 = 8s
fillMatrix <- function(n) {
    matrix <- matrix(0, n, n)
    for (i in 1:n) {
        for (j in 1:n) {
            matrix[i, j] <- i * j
        }
    }
    return(matrix)
}

#' This is faster on base branch
#' 
#' @param n size of matrix
#' @export
base_faster <- function(n) {
    fillMatrix(n)
}

#' This is faster on head branch.
#' 
#' @param n size of matrix
#' @importFrom magrittr %>%
#' @export
head_faster <- function(n) {
    Sys.getenv("TC_DELAY") %>%
        as.numeric() %>%
        Sys.sleep()
        
    fillMatrix(n)
}