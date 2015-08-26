#' Anonymize a vector.
#'
#' \code{anonymize} anonymizes a vector \code{.x} by first salting it with
#'  \code{\link{salt}} and then hashing it with \code{\link{hash}}. See
#'  both functions for additional documentation.
#'
#' The user is advised to check out \href{https://en.wikipedia.org/wiki/Data_anonymization}{Wikipedia} for more information.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @param .chars set of characters to salt with.
#' @param .n_chars an integer; number of characters to salt with.
#' @param ... additional arguments to be based to \code{hash}.
#' @return An anonymized version of the vector.
#' @examples
#' set.seed(1)
#' anonymize(letters)
#' @export
anonymize <- function(.x, .algo = "sha256", .chars = letters, .n_chars = 5L, ...){
  hash(salt(.x, .chars = .chars, .n_chars = .n_chars), .algo = .algo, ...)
}
