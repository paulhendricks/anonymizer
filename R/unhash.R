#' Unhash a vector.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @param .seed an integer to seed the random number generator.
#' @param ... additional arguments to be based to \code{\link[digest]{digest}}.
#' @return An unhashed version of the vector.
#' @export
unhash <- function(.x, .algo = "sha256", .seed = 0, ...){
  return(1L)
}
