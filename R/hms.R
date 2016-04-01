#' A simple class for storing time-of-day values
#'
#' The values are stored as a \code{\link{difftime}} vector with a custom class,
#' and always with "seconds" as unit for robust coercion to numeric.
#' Supports construction from time values, coercion to and from
#' various data types, and formatting.  Can be used as a regular column in a
#' data frame.
#'
#' @name hms
#' @examples
#' hms(56, 34, 12)
#' as.hms(1)
#' as.hms("12:34:56")
#' as.hms(Sys.time())
#' as.POSIXct(hms(1))
#' \dontrun{
#'   # Will raise an error
#'   data.frame(a = hms(1))
#' }
#' d <- data.frame(hours = 1:3)
#' d$hours <- hms(hours = d$hours)
#' d
NULL

# Construction ------------------------------------------------------------

#' @rdname hms
#' @param seconds,minutes,hours,days Time since midnight. No bounds checking is
#'   performed.
#' @export
hms <- function(seconds = 0, minutes = 0, hours = 0, days = 0) {
  if (missing(seconds) && missing(minutes) && missing(hours) && missing(days)) {
    stop("Need to pass at least one entry for seconds, minutes, hours, or days.",
         call. = FALSE)
  }

  as.hms(as.difftime(
    seconds + minutes * 60 + hours * 3600 + days * 86400, units = "secs"))
}

#' @rdname hms
#' @export
is.hms <- function(x) inherits(x, "hms")

# Coercion in -------------------------------------------------------------

#' @rdname hms
#' @param x An object.
#' @param ... Arguments passed on to further methods.
#' @export
as.hms <- function(x, ...) UseMethod("as.hms", x)

#' @rdname hms
#' @export
as.hms.default <- function(x, ...) {
  stop("Can't convert object of class ", paste(class(x), collapse = ", "),
       " to hms.", call. = FALSE)
}

#' @rdname hms
#' @export
as.hms.difftime <- function(x, ...) {
  units(x) <- "secs"
  structure(x, class = unique(c("hms", class(x))))
}

#' @rdname hms
#' @export
as.hms.numeric <- function(x, ...) hms(days = x)

DATE_TIME_ORIGIN <- as.numeric(lubridate::parse_date_time("00:00:00", "hms"))

#' @rdname hms
#' @export
as.hms.character <- function(x, ...) {
  seconds <- as.numeric(lubridate::parse_date_time(x, "hms")) - DATE_TIME_ORIGIN
  hms(seconds = seconds)
}

#' @rdname hms
#' @export
as.hms.POSIXt <- function(x, ...) {
  seconds <- as.numeric(as.POSIXct(x)) %% 86400
  hms(seconds = seconds)
}


# Coercion out ------------------------------------------------------------

#' @rdname hms
#' @export
as.POSIXct.hms <- function(x, ...) {
  structure(as.numeric(x), tzone = "UTC", class = c("POSIXct", "POSIXt"))
}

#' @rdname hms
#' @export
as.POSIXlt.hms <- function(x, ...) {
  as.POSIXlt(as.POSIXct(x, ...), ...)
}

#' @rdname hms
#' @export
as.character.hms <- function(x, ...) {
  strftime(as.POSIXct(x, ...), format = "%H:%M:%S", tz = "UTC")
}

#' @rdname hms
#' @inheritParams base::as.data.frame
#' @export
as.data.frame.hms <- forward_to(as.data.frame.difftime)

# Output ------------------------------------------------------------------

#' @rdname hms
#' @export
format.hms <- function(x, ...) {
  as.character(x)
}

#' @rdname hms
#' @export
print.hms <- function(x, ...) {
  cat(format(x), sep = "\n")
  invisible(x)
}
