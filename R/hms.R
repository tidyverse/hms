#' @importFrom methods setOldClass
setOldClass(c("hms", "difftime"))

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
#' @details For \code{hms}, all arguments must have the same length or be
#'   \code{NULL}.  Odd combinations (e.g., passing only \code{seconds} and
#'   \code{hours} but not \code{minutes}) are rejected.
#' @param seconds,minutes,hours,days Time since midnight. No bounds checking is
#'   performed.
#' @export
hms <- function(seconds = NULL, minutes = NULL, hours = NULL, days = NULL) {
  args <- list(seconds = seconds, minutes = minutes, hours = hours, days = days)
  check_args(args)
  arg_secs <- mapply(`*`, args, c(1, 60, 3600, 86400))
  secs <- Reduce(`+`, arg_secs[vapply(arg_secs, length, integer(1L)) > 0L])

  as.hms(as.difftime(secs, units = "secs"))
}

check_args <- function(args) {
  lengths <- vapply(args, length, integer(1L))
  if (all(lengths == 0L)) {
    stop("Need to pass at least one entry for seconds, minutes, hours, or days to hms().",
         call. = FALSE)
  }

  if (!all(diff(which(lengths != 0L)) == 1L)) {
    stop("Can't pass only ", paste(names(lengths)[lengths != 0L], collapse = ", "),
         " to hms().", call. = FALSE)
  }

  lengths <- lengths[lengths != 0]
  if (length(unique(lengths)) > 1L) {
    stop("All arguments to hms() must have the same length or be NULL. Found ",
         paste0("length(", names(lengths), ") = ", lengths, collapse = ", "), ".",
         call. = FALSE)
  }
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
as.hms.numeric <- function(x, ...) hms(seconds = x)

#' @rdname hms
#' @export
as.hms.character <- function(x, ...) {
  as.hms(as.difftime(x))
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
  paste0(ifelse(x < 0, "-", ""),
         strftime(as.POSIXct.hms(abs(x), ...), format = "%H:%M:%S", tz = "UTC"))
}

#' @rdname hms
#' @inheritParams base::as.data.frame
#' @param nm Name of column in new data frame
#' @export
as.data.frame.hms <- forward_to(as.data.frame.difftime)


# Updating ----------------------------------------------------------------

#' @export
`units<-.hms` <- function(x, value) {
  if (!identical(value, "secs")) {
    warning("hms always uses seconds as unit.", call. = FALSE)
  }
  x
}


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
