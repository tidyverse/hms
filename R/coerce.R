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

#' @method vec_ptype2.hms hms
#' @export
vec_ptype2.hms.hms <- function(x, y, ...) hms::hms()

#' @method vec_ptype2.difftime hms
#' @export
vec_ptype2.difftime.hms <- function(x, y, ...) new_hms()

#' @method vec_ptype2.hms difftime
#' @export
vec_ptype2.hms.difftime <- function(x, y, ...) new_hms()
