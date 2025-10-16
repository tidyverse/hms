#' Parsing hms values
#'
#' @description
#' These functions convert character vectors to objects of the [hms] class.
#' `NA` values are supported.
#'
#' `parse_hms()` accepts values of the form `"HH:MM:SS"`, with optional
#' fractional seconds.
#' @param x A character vector
#' @return An object of class [hms].
#'
#' @export
#' @examples
#' parse_hms("12:34:56")
#' parse_hms("12:34:56.789")
parse_hms <- function(x) {
  parse_time(x, format = "%H:%M:%OS")
}

#' @rdname parse_hms
#' @description
#' `parse_hm()` accepts values of the form `"HH:MM"`.
#' @export
#' @examples
#' parse_hm("12:34")
parse_hm <- function(x) {
  parse_time(x, format = "%H:%M")
}

parse_time <- function(x, format) {
  parsed <- strptime(
    paste0("1970-01-01 ", as.character(x)),
    format = paste0("%Y-%m-%d ", format),
    tz = "UTC"
  )
  hms(
    seconds = parsed$sec,
    minutes = parsed$min,
    hours = parsed$hour + (parsed$mday - 1L) * 24L
  )
}
