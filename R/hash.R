#' Hash a vector.
#'
#' See \code{\link[digest]{digest}} for additional documentation.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @param ... additional arguments to be based to \code{\link[digest]{digest}}.
#' @export
hash <- function(.x, .algo = "sha256", ...){
  if(!is.atomic((.x))) stop("Vector must be an atomic vector.")
  unq_hashes <- vapply(unique(.x),
                       function(object) digest::digest(object, algo = .algo, ...),
                       character(1))
  return(unname(unq_hashes[.x]))
}
