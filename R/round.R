#' Round or truncate to a multiple of seconds
#'
#' Convenience functions to round or truncate to a multiple of seconds.
#' @param x A vector of class [hms]
#' @param secs Multiple of seconds, a positive numeric. Values less than one
#'   are supported
#' @param digits Number of digits, a whole number between -100 and 100.
#' @return The input, rounded or truncated to the nearest multiple of `secs` (or number of `digits`)
#' @export
#' @examples
#' round_hms(as_hms("12:34:56"), 5)
#' round_hms(as_hms("12:34:56"), 60)
#' round_hms(as_hms("12:34:56"), digits = 1)
#' round_hms(as_hms("12:34:56"), digits = -2)
round_hms <- function(x, secs = NULL, digits = NULL) {
  if (!is.null(digits)) {
    if (d %% 1 == 0) {
      if (d <= 100 & d >= -100) {
        secs <- digits2sec(digits)
      } else {
        # error message here
      }
    } else {
      # error message here
    }
  }

  vec_restore(round(as.numeric(x) / secs) * secs, x)
}

#' @rdname round_hms
#' @export
#' @examples
#' trunc_hms(as_hms("12:34:56"), 60)
trunc_hms <- function(x, secs = NULL, digits = NULL) {
  if (!is.null(digits)) {
    if (d %% 1 == 0) {
      if (d <= 100 & d >= -100) {
        secs <- digits2sec(digits)
      } else {
        # error message here
      }
    } else {
      # error message here
    }
  }

  vec_restore(trunc(as.numeric(x) / secs) * secs, x)
}


digits2sec <- function(digits) {
  if (digits >= -1) {
    secs <- 10 ^ -digits
  } else if (digits < -1) {
    secs <- 60 ^ (-digits - 1)
  }

  return(secs)
}
