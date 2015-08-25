#' Anonymize a vector.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @return An anonymized version of the data object.
#' @export
anonymize <- function(.x, .algo = "sha256", ...){
  hash(salt(.x), .algo = .algo)
}
