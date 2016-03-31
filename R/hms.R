#' @export
hms <- function(seconds, minutes = 0, hours = 0, days = 0) {
  structure(
    seconds / 86400 + minutes / 1440 + hours / 24 + days,
    class = "hms")
}

#' @export
as.hms <- function(x, ...) UseMethod("as.hms", x)

#' @export
as.hms.default <- function(x, ...) {
  stop("Can't convert object of class ", paste(class(x), collapse = ", "),
       " to hms.", call. = FALSE)
}

#' @export
as.hms.numeric <- function(x, ...) hms(days = x)

DATE_TIME_ORIGIN <- as.numeric(lubridate::parse_date_time("00:00:00", "hms"))

#' @export
as.hms.character <- function(x, ...) {
  seconds <- as.numeric(lubridate::parse_date_time(x, "hms")) - DATE_TIME_ORIGIN
  hms(seconds = seconds)
}
