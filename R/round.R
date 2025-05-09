#' Round an hms object
#'
#' Convenience functions to round to a multiple of seconds or digits.
#' @param x A vector of class [hms]
#' @param secs Multiple of seconds, a positive numeric. Values less than one
#'   are supported
#' @param digits Number of digits, a whole number.
#'   Negative numbers are supported.
#' @return The input, rounded or truncated to the nearest multiple of `secs`
#'   (or number of `digits`)
#' @export
#' @examples
#' round_hms(as_hms("12:34:56"), 5)
#' round_hms(as_hms("12:34:56"), 60)
#' round_hms(as_hms("12:34:56.78"), 0.25)
#' round_hms(as_hms("12:34:56.78"), digits = 1)
#' round_hms(as_hms("12:34:56.78"), digits = -2)
round_hms <- function(x, secs = NULL, digits = NULL) {
  secs <- digits_to_secs(secs, digits)

  vec_restore(round(as.numeric(x) / secs) * secs, x)
}

#' @rdname round_hms
#' @export
#' @examples
#' trunc_hms(as_hms("12:34:56"), 60)
trunc_hms <- function(x, secs = NULL, digits = NULL) {
  secs <- digits_to_secs(secs, digits)

  vec_restore(trunc(as.numeric(x) / secs) * secs, x)
}

#' @rdname round_hms
#' @export
#' @examples
#' ceiling_hms(as_hms("12:34:56"), 60)
ceiling_hms <- function(x, secs = NULL, digits = NULL) {
  secs <- digits_to_secs(secs, digits)

  vec_restore(ceiling(as.numeric(x) / secs) * secs, x)
}

#' @rdname round_hms
#' @export
#' @examples
#' floor_hms(as_hms("12:34:56"), 60)
floor_hms <- function(x, secs = NULL, digits = NULL) {
  secs <- digits_to_secs(secs, digits)

  vec_restore(floor(as.numeric(x) / secs) * secs, x)
}

digits_to_secs <- function(secs, digits) {
  if (is.null(digits)) {
    if (is.null(secs)) {
      abort("Exactly one of `secs` or `digits` is required.")
    }

    return(secs)
  }

  if (!is.null(secs)) {
    abort("Exactly one of `secs` or `digits` is required.")
  }

  if (!is_integerish(digits)) {
    abort("`digits` must be a whole number")
  }

  if (digits >= -1) {
    secs <- 10^-digits
  } else if (digits == -2) {
    secs <- 60
  } else if (digits == -3) {
    secs <- 600
  } else if (digits <= -4) {
    secs <- 3600 * (10^(-digits - 4))
  }

  secs
}
