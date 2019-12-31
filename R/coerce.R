#' Coercion
#'
#' Double dispatch methods to support [vctrs::vec_ptype2()].
#'
#' @inheritParams vctrs::vec_ptype2
#'
#' @method vec_ptype2 hms
#' @export
#' @export vec_ptype2.hms
vec_ptype2.hms <- function(x, y, ..., x_arg = "", y_arg = "") UseMethod("vec_ptype2.hms", y)

#' @method vec_ptype2.hms default
#' @export
vec_ptype2.hms.default <- function(x, y, ..., x_arg = "", y_arg = "") {
  vec_default_ptype2(x, y, x_arg = x_arg, y_arg = y_arg)
}

#' @method vec_ptype2.hms vctrs_unspecified
#' @export
vec_ptype2.hms.vctrs_unspecified <- function(x, y, ...) x

#' @method vec_ptype2.hms hms
#' @export
vec_ptype2.hms.hms <- function(x, y, ...) hms::hms()

#' @method vec_ptype2.difftime hms
#' @export
vec_ptype2.difftime.hms <- function(x, y, ...) new_hms()

#' @method vec_ptype2.hms difftime
#' @export
vec_ptype2.hms.difftime <- function(x, y, ...) new_hms()

#' @method vec_ptype2.double hms
#' @export
vec_ptype2.double.hms <- function(x, y, ...) {
  warn_deprecated("Coercion of <double> to <time> is deprecated and will be removed in a future version. Please use as_hms().")
  new_hms()
}

#' @method vec_ptype2.hms double
#' @export
vec_ptype2.hms.double <- function(x, y, ...) vec_ptype2.double.hms(y, x)

#' @method vec_ptype2.integer hms
#' @export
vec_ptype2.integer.hms <- function(x, y, ...) {
  warn_deprecated("Coercion of <integer> to <time> is deprecated and will be removed in a future version. Please use as_hms().")
  new_hms()
}

#' @method vec_ptype2.hms integer
#' @export
vec_ptype2.hms.integer <- function(x, y, ...) vec_ptype2.integer.hms(y, x)

#' @method vec_ptype2.character hms
#' @export
vec_ptype2.character.hms <- function(x, y, ...) {
  warn_deprecated("Coercion of <character> to <time> is deprecated and will be removed in a future version. Please use as_hms().")
  new_hms()
}

#' @method vec_ptype2.hms character
#' @export
vec_ptype2.hms.character <- function(x, y, ...) vec_ptype2.character.hms(y, x)
