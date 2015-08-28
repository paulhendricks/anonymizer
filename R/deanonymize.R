#' Deanonymize a vector.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @param .seed an integer to seed the random number generator.
#' @param ... additional arguments to be based to \code{unhash}.
#' @return An deanonymized version of the vector.

#' @export
deanonymize <- function(.x, .algo = "sha256", .seed = 0, ...){
  return(unsalt(unhash(.x, .algo = .algo, .seed = .seed, ...), .seed = .seed))
}
