#' Hash a vector.
#'
#' See \code{\link[digest]{digest}} for additional documentation.
#'
#' The user is advised to check out \href{https://en.wikipedia.org/wiki/Hash_function}{Wikipedia} for more information.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @param .seed an integer to seed the random number generator.
#' @param ... additional arguments to be based to \code{\link[digest]{digest}}.
#' @return A hashed version of the vector.
#' @examples
#' # All algorithms available to digest::digest are available here
#' set.seed(1)
#' hash(letters, .algo = "sha256")
#' hash(letters, .algo = "crc32")
#' @export
hash <- function(.x, .algo = "sha256", .seed = 0, ...){
  if(!is.atomic((.x))) stop("Vector must be an atomic vector.")
  return(unname(vapply(.x, function(object) digest::digest(object, algo = .algo, seed = .seed, ...), character(1))))
}
