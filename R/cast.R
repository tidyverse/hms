#' Casting
#'
#' Double dispatch methods to support [vctrs::vec_cast()].
#'
#' @inheritParams vctrs::vec_cast
#'
#' @method vec_cast hms
#' @export
#' @export vec_cast.hms
vec_cast.hms <- function(x, to) UseMethod("vec_cast.hms")

#' @method vec_cast.hms default
#' @export
vec_cast.hms.default <- function(x, to) stop_incompatible_cast(x, to)

#' @method vec_cast.hms logical
#' @export
vec_cast.hms.logical <- function(x, to) vec_unspecified_cast(x, to)

#' @method vec_cast.hms hms
#' @export
vec_cast.hms.hms <- function(x, to) x

#' @method vec_cast.hms difftime
#' @export
vec_cast.hms.difftime <- function(x, to) {
  units(x) <- "secs"
  new_hms(vec_data(x))
}

#' @method vec_cast.difftime hms
#' @export
vec_cast.difftime.hms <- function(x, to) {
  # as.difftime() doesn't change the class
  class(x) <- "difftime"
  vec_cast(x, to)
}

#' @method vec_cast.hms POSIXct
#' @export
vec_cast.hms.POSIXct <- function(x, to) {
  vec_cast(as.POSIXlt(x), to)
}

#' @method vec_cast.POSIXct hms
#' @export
vec_cast.POSIXct.hms <- function(x, to) {
  structure(as.numeric(x), tzone = "UTC", class = c("POSIXct", "POSIXt"))
}

#' @method vec_cast.hms POSIXlt
#' @export
vec_cast.hms.POSIXlt <- function(x, to) {
  hms(x$sec, x$min, x$hour)
}

#' @method vec_cast.POSIXlt hms
#' @export
vec_cast.POSIXlt.hms <- function(x, to) {
  as.POSIXlt(vec_cast(x, new_datetime()))
}

#' @method vec_cast.hms double
#' @export
vec_cast.hms.double <- function(x, to) new_hms(x)

#' @method vec_cast.double hms
#' @export
vec_cast.double.hms <- function(x, to) vec_data(x)

#' @method vec_cast.hms integer
#' @export
vec_cast.hms.integer <- function(x, to) new_hms(as.numeric(x))

#' @method vec_cast.integer hms
#' @export
vec_cast.integer.hms <- function(x, to) as.integer(vec_data(x))

#' @method vec_cast.hms character
#' @export
vec_cast.hms.character <- function(x, to) {
  ret <- parse_hms(x)
  problems <- which(is.na(ret) && !is.na(x))
  if (has_length(problems)) {
    warn_lossy_cast(x, to, problems)
  }
  ret
}

#' @method vec_cast.character hms
#' @export
vec_cast.character.hms <- function(x, to) format_hms(x)
