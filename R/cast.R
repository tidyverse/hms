#' Casting
#'
#' Double dispatch methods to support [vctrs::vec_cast()].
#'
#' @inheritParams vctrs::vec_cast
#'
#' @method vec_cast hms
#' @export
#' @export vec_cast.hms
vec_cast.hms <- function(x, to, ...) UseMethod("vec_cast.hms")

#' @method vec_cast.hms default
#' @export
vec_cast.hms.default <- function(x, to, ...) vec_default_cast(x, to, ...)

#' @method vec_cast.hms hms
#' @export
vec_cast.hms.hms <- function(x, to, ...) x

#' @method vec_cast.hms difftime
#' @export
vec_cast.hms.difftime <- function(x, to, ...) {
  units(x) <- "secs"
  new_hms(vec_data(x))
}

#' @method vec_cast.difftime hms
#' @export
vec_cast.difftime.hms <- function(x, to, ...) {
  # as.difftime() doesn't change the class
  class(x) <- "difftime"
  vec_cast(x, to, ...)
}

#' @method vec_cast.hms POSIXct
#' @export
vec_cast.hms.POSIXct <- function(x, to, ...) {
  vec_cast(as.POSIXlt(x), to)
}

#' @method vec_cast.POSIXct hms
#' @export
vec_cast.POSIXct.hms <- function(x, to, ...) {
  structure(as.numeric(x), tzone = "UTC", class = c("POSIXct", "POSIXt"))
}

#' @method vec_cast.hms POSIXlt
#' @export
vec_cast.hms.POSIXlt <- function(x, to, ...) {
  hms(x$sec, x$min, x$hour)
}

#' @method vec_cast.POSIXlt hms
#' @export
vec_cast.POSIXlt.hms <- function(x, to, ...) {
  as.POSIXlt(vec_cast(x, new_datetime()))
}

#' @method vec_cast.hms double
#' @export
vec_cast.hms.double <- function(x, to, ...) new_hms(x)

#' @method vec_cast.double hms
#' @export
vec_cast.double.hms <- function(x, to, ...) vec_data(x)

#' @method vec_cast.hms integer
#' @export
vec_cast.hms.integer <- function(x, to, ...) new_hms(as.numeric(x))

#' @method vec_cast.integer hms
#' @export
vec_cast.integer.hms <- function(x, to, ...) as.integer(vec_data(x))

#' @method vec_cast.hms character
#' @export
vec_cast.hms.character <- function(x, to, ...) {
  ret <- parse_hms(x)
  lossy <- is.na(ret) & !is.na(x)
  warn_lossy_cast(x, to, ..., lossy = lossy)
  ret
}

#' @method vec_cast.character hms
#' @export
vec_cast.character.hms <- function(x, to, ...) format_hms(x)

# Requires vctrs > 0.1.0
vec_default_cast <- NULL

utils::globalVariables("vec_unspecified_cast")
vec_default_cast_old <- function(x, to, ...) {
  if (is.logical(x)) {
    vec_unspecified_cast(x, to, ...)
  } else {
    stop_incompatible_cast(x, to, ...)
  }
}

warn_lossy_cast <- function(x, to, ..., lossy) {
  problems <- which(lossy)
  if (is_empty(problems)) return()

  warn(
    paste0("Lossy cast from <character> to <hms> at position(s) ", commas(problems)),
    .subclass = "hms_lossy_cast"
  )
}

commas <- function(problems) {
  MAX_BULLETS <- 6L
  if (length(problems) >= MAX_BULLETS) {
    n_more <- length(problems) - MAX_BULLETS + 1L
    problems[[MAX_BULLETS]] <-
      paste0(pre_dots("(and "), n_more, " more)")
    length(problems) <- MAX_BULLETS
  }

  paste0(problems, collapse = ", ")
}

pre_dots <- function(x) {
  if (length(x) > 0) {
    paste0("... ", x)
  } else {
    character()
  }
}
