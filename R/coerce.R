#' Coercion
#'
#' Double dispatch methods to support [vctrs::vec_type2()].
#'
#' @inheritParams vctrs::vec_type2
#'
#' @method vec_type2 hms
#' @export
#' @export vec_type2.hms
vec_type2.hms <- function(x, y) UseMethod("vec_type2.hms", y)

#' @method vec_type2.hms default
#' @export
vec_type2.hms.default <- function(x, y) stop_incompatible_type(x, y)

#' @method vec_type2.hms vctrs_unspecified
#' @export
vec_type2.hms.vctrs_unspecified <- function(x, y) x

#' @method vec_type2.hms hms
#' @export
vec_type2.hms.hms <- function(x, y) hms::hms()

#' @method vec_type2.difftime hms
#' @export
vec_type2.difftime.hms <- function(x, y) new_difftime(units = units(x))

#' @method vec_type2.hms difftime
#' @export
vec_type2.hms.difftime <- function(x, y) new_difftime(units = units(y))

#' @method vec_type2.double hms
#' @export
vec_type2.double.hms <- function(x, y) {
  warn_deprecated("Coercion of <double> to <time> is deprecated and will be removed in a future version. Please use as_hms().")
  new_hms()
}

#' @method vec_type2.hms double
#' @export
vec_type2.hms.double <- function(x, y) vec_type2.double.hms(y, x)

#' @method vec_type2.integer hms
#' @export
vec_type2.integer.hms <- function(x, y) {
  warn_deprecated("Coercion of <integer> to <time> is deprecated and will be removed in a future version. Please use as_hms().")
  new_hms()
}

#' @method vec_type2.hms integer
#' @export
vec_type2.hms.integer <- function(x, y) vec_type2.integer.hms(y, x)

#' @method vec_type2.character hms
#' @export
vec_type2.character.hms <- function(x, y) {
  warn_deprecated("Coercion of <character> to <time> is deprecated and will be removed in a future version. Please use as_hms().")
  new_hms()
}

#' @method vec_type2.hms character
#' @export
vec_type2.hms.character <- function(x, y) vec_type2.character.hms(y, x)
