#' Deanonymize a vector.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @param .seed an integer to seed the random number generator.
#' @param .chars set of characters to unsalt with.
#' @param .n_chars an integer; number of characters to unsalt with.
#' @param ... additional arguments to be based to \code{unhash}.
#' @return An deanonymized version of the vector.

#' @export
deanonymize <- function(.x, .algo = "sha256", .seed = 0, .chars = letters, .n_chars = 5L, ...){
  return(unsalt(unhash(.x, .algo = .algo, .seed = .seed, ...), .seed = .seed, .chars = .chars, .n_chars = .n_chars))
}
