#' Salt a vector.
#'
#' \code{salt} takes a vector \code{.x} and returns a salted version of it.
#' The algorithm for salting a vector is:
#' \enumerate{
#'   \item Select a random sample of characters of length \code{.n_chars} from \code{.chars}. Call this random sample \code{.y}.
#'   \item Concatenate \code{.y}, the vector \code{.x}, and \code{.y} again in a vectorized fashion.
#' }
#'
#' @param .x a vector.
#' @param .chars set of characters to salt with.
#' @param .n_chars an integer; number of characters to salt with.
#' @return A salted version of the vector.
#' @examples
#' set.seed(1)
#' # Use various number of characters
#' salt(letters, .n_chars = 0L)
#' salt(letters, .n_chars = 1L)
#' salt(letters, .n_chars = 5L)
#' salt(letters)
#'
#' # Use other sets of characters to salt with
#' salt(letters, .chars = letters[1:2])
#' @export
salt <- function(.x, .chars = letters, .n_chars = 5L) {
  if(!is.atomic((.x))) stop("Vector must be an atomic vector.")
  .y <- paste0(sample(.chars, .n_chars, replace = TRUE), collapse = "")
  return(paste0(.y, .x, .y, sep = ""))
}
