#' @import vctrs
#' @import rlang
NULL

#' @importFrom methods setOldClass
setOldClass(c("hms", "difftime"))
#setOldClass(c("hms", "vctrs_vctr", "difftime"))

#' A simple class for storing time-of-day values
#'
#' The values are stored as a [difftime] vector with a custom class,
#' and always with "seconds" as unit for robust coercion to numeric.
#' Supports construction from time values, coercion to and from
#' various data types, and formatting.  Can be used as a regular column in a
#' data frame.
#'
#' @name hms
#' @examples
#' hms(56, 34, 12)
#' hms()
#' new_hms(1:3)
#'
#' as.hms(1)
#' as.hms("12:34:56")
#' as.hms(Sys.time())
#' as.POSIXct(hms(1))
#' data.frame(a = hms(1))
#' d <- data.frame(hours = 1:3)
#' d$hours <- hms(hours = d$hours)
#' d
NULL

# Construction ------------------------------------------------------------

#' @rdname hms
#' @details For `hms`, all arguments must have the same length or be
#'   `NULL`.  Odd combinations (e.g., passing only `seconds` and
#'   `hours` but not `minutes`) are rejected.
#' @param seconds,minutes,hours,days Time since midnight. No bounds checking is
#'   performed.
#' @export
hms <- function(seconds = NULL, minutes = NULL, hours = NULL, days = NULL) {
  args <- list(seconds = seconds, minutes = minutes, hours = hours, days = days)
  check_args(args)
  arg_secs <- map2(args, c(1, 60, 3600, 86400), `*`)
  secs <- reduce(arg_secs[!map_lgl(args, is.null)], `+`)
  if (is.null(secs)) secs <- numeric()

  new_hms(as.numeric(secs))
}

#' @rdname hms
#' @export
new_hms <- function(x = numeric()) {
  vec_assert(x, numeric())

  out <- new_duration(x, units = "secs")

  # no class argument?
  class(out) <- c("hms", class(out))
  out
}

#' @rdname hms
#' @export
is_hms <- function(x) inherits(x, "hms")

#' Deprecated functions
#'
#' `is.hms()` has been replaced by [is_hms()].
#'
#' @inheritParams is_hms
#'
#' @export
is.hms <- function(x) {
  signal_soft_deprecated("is.hms() is deprecated, please use is_hms().")
  is_hms(x)
}

#' @export
vec_ptype_abbr.hms <- function(x) {
  "time"
}

#' @export
vec_ptype_full.hms <- function(x) {
  "time"
}

# Coercion in -------------------------------------------------------------

#' @rdname hms
#' @param x An object.
#' @param ... Arguments passed on to further methods.
#' @export
as.hms <- function(x, ...) UseMethod("as.hms", x)

#' @rdname hms
#' @export
as.hms.default <- function(x, ...) {
  vec_cast(x, new_hms())
}

#' @rdname hms
#' @param tz The time zone in which to interpret a POSIXt time for extracting
#'   the time of day.  The default is now the zone of `x` but was `"UTC"`
#'   for v0.3 and earlier.  The previous behavior can be restored by calling
#'   `pkgconfig::set_config("hms::default_tz", "UTC")`, see
#'   [pkgconfig::set_config()].
#' @export
#' @importFrom pkgconfig get_config
as.hms.POSIXt <- function(x, tz = pkgconfig::get_config("hms::default_tz", ""), ...) {
  time <- as.POSIXlt(x, tz = tz)
  hms(time$sec, time$min, time$hour)
}

#' @rdname hms
#' @export
as.hms.POSIXlt <- function(x, tz = pkgconfig::get_config("hms::default_tz", ""), ...) {
  # We need to roundtrip via as.POSIXct() to respect the time zone
  as.hms(as.POSIXct(x), tz = tz, ...)
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
  format_hms(x)
}

format_hms <- function(x) {
  xx <- decompose(x)

  ifelse(is.na(x), NA_character_, paste0(
    ifelse(xx$sign, "-", ""),
    format_hours(xx$hours), ":",
    format_two_digits(xx$minute_of_hour), ":",
    format_two_digits(xx$second_of_minute),
    format_split_seconds(xx$split_seconds)))
}

#' @rdname hms
#' @inheritParams base::as.data.frame
#' @param nm Name of column in new data frame
#' @export
as.data.frame.hms <- forward_to(as.data.frame.difftime)


# Subsetting --------------------------------------------------------------

#' @export
`[[.hms` <- function(x, ...) {
  as.hms(NextMethod())
}

# Combination -------------------------------------------------------------
#' @export
c.hms <- function(x, ...) {
  # Needed to override c.difftime()
  vec_c(x, ...)
}

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
  if (length(x) == 0L) {
    "hms()"
  } else {
    format(as.character(x), justify = "right")
  }
}

#' @rdname hms
#' @export
print.hms <- function(x, ...) {
  cat(format(x), sep = "\n")
  invisible(x)
}
