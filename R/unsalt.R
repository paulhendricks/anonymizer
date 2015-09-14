#' Unsalt a vector.
#'
#' \code{salt} takes a vector \code{.x} and returns an unsalted version of it.
#' The algorithm for unsalting a vector is:
#' \enumerate{
#'   \item Select a random sample of characters of length \code{.n_chars} from \code{.chars}. Call this random sample \code{.y}.
#'   \item Substitute \code{.y} out of the vector \code{.x} wherever it occurs, in a vectorized fashion.
#' }
#'
#' The user is advised to check out \href{https://en.wikipedia.org/wiki/Salt_\%28cryptography\%29}{Wikipedia} for more information.
#'
#' @param .x a vector.
#' @param .seed an integer to seed the random number generator.
#' @param .chars set of characters to unsalt with.
#' @param .n_chars an integer; number of characters to unsalt with.
#' @return An unsalted version of the vector.
#' @examples
#' # Use various number of characters
#' unsalt(salt(letters, .n_chars = 0L))
#' unsalt(salt(letters, .n_chars = 1L))
#' unsalt(salt(letters, .n_chars = 5L))
#' unsalt(salt(letters))
#'
#' # Use other sets of characters to salt with
#' unsalt(salt(letters, .chars = letters[1:2]), .chars = letters[1:2])
#' @export
unsalt <- function(.x, .seed = NULL, .chars = letters, .n_chars = 5L){
  if (!is.atomic(.x)) stop("Vector must be an atomic vector.")
  if (!is.null(.seed)) set.seed(.seed)
  .y <- paste0(sample(.chars, .n_chars, replace = TRUE), collapse = "")
  return(gsub(.y, "", .x))
}
