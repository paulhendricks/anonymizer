#' Anonymize a vector.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @param .chars set of characters to salt with.
#' @param .n_chars an integer; number of characters to salt with.
#' @param ... additional arguments to be based to \code{hash}.
#' @return An anonymized version of the data object.
#' @export
anonymize <- function(.x, .algo = "sha256", .chars = letters, .n_chars = 5L, ...){
  hash(salt(.x, .chars = .chars, .n_chars = .n_chars), .algo = .algo, ...)
}
