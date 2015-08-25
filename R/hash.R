#' Hash a vector.
#'
#' @param .x a vector.
#' @param .algo the name of the algorithm.
#' @return An anonymized version of the data object.
#' @export
hash <- function(.x, .algo = "sha256"){
  if(!is.atomic((.x))) stop("Vector must be an atomic vector.")
  unq_hashes <- vapply(unique(.x),
                       function(object) digest::digest(object, algo = .algo),
                       character(1))
  return(unname(unq_hashes[.x]))
}
