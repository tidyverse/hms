#' Parsing hms values
#'
#' These functions convert character vectors to objects of the [hms] class.
#' `NA` values are supported.
#'
#' `parse_hms()` accepts values of the form `"HH:MM:SS"`, with optional
#' fractional seconds.
#' @param x A character vector
#' @export
#' @examples
#' parse_hms("12:34:56")
#' parse_hms("12:34:56.789")
parse_hms <- function(x) {
  as.hms(as.difftime(as.character(x), format = "%H:%M:%OS", units = "secs"))
}

#' @rdname parse_hms
#' @details `parse_hm()` accepts values of the form `"HH:MM"`.
#' @export
#' @examples
#' parse_hm("12:34")
parse_hm <- function(x) {
  as.hms(as.difftime(as.character(x), format = "%H:%M", units = "secs"))
}
