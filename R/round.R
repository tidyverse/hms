#' Round or truncate to a multiple of seconds
#'
#' Convenience functions to round or truncate to a multiple of seconds.
#' @param x A vector of class [hms]
#' @param secs Multiple of seconds, a positive numeric. Values less than one
#'   are supported
#' @return The input, rounded or truncated to the nearest multiple of `secs`
#' @export
#' @examples
#' round_hms(as_hms("12:34:56"), 5)
#' round_hms(as_hms("12:34:56"), 60)
round_hms <- function(x, secs) {
  vec_restore(round(as.numeric(x) / secs) * secs, x)
}

#' @rdname round_hms
#' @export
#' @examples
#' trunc_hms(as_hms("12:34:56"), 60)
trunc_hms <- function(x, secs) {
  vec_restore(trunc(as.numeric(x) / secs) * secs, x)
}
