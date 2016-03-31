#' @export
hms <- function(seconds = 0, minutes = 0, hours = 0, days = 0) {
  if (missing(seconds) && missing(minutes) && missing(hours) && missing(days)) {
    stop("Need to pass at least one entry for seconds, minutes, hours, or days.",
         call. = FALSE)
  }
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

#' @export
as.hms.POSIXt <- function(x, ...) {
  seconds <- as.numeric(as.POSIXct(x)) %% 86400
  hms(seconds = seconds)
}
