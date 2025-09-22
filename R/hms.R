setOldClass(c("hms", "difftime"))

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
#'
#' new_hms(as.numeric(1:3))
#' # Supports numeric only!
#' try(new_hms(1:3))
#'
#' as_hms(1)
#' as_hms("12:34:56")
#' as_hms(Sys.time())
#' as.POSIXct(hms(1))
#' data.frame(a = hms(1))
#' d <- data.frame(hours = 1:3)
#' d$hours <- hms(hours = d$hours)
#' d
NULL

# Construction ------------------------------------------------------------

#' hms()
#'
#' `hms()` is a high-level constructor that accepts second, minute, hour and day components
#' as numeric vectors.
#'
#' @rdname hms
#' @details For `hms()`, all arguments must have the same length or be
#'   `NULL`.  Odd combinations (e.g., passing only `seconds` and
#'   `hours` but not `minutes`) are rejected.
#' @param seconds,minutes,hours,days Time since midnight. No bounds checking is
#'   performed.
#' @export
hms <- function(seconds = NULL, minutes = NULL, hours = NULL, days = NULL) {
  error_call <- caller_env()
  args <- list(
    seconds = seconds,
    minutes = minutes,
    hours = hours,
    days = days
  )

  args_df <- data_frame(!!!args, .error_call = error_call)
  args[names(args_df)] <- as.list(args_df)

  check_args(args, error_call)

  arg_secs <- map2(args, c(1, 60, 3600, 86400), `*`)
  secs <- reduce(arg_secs[!map_lgl(args, is.null)], `+`)
  if (is.null(secs)) {
    secs <- numeric()
  }

  new_hms(as.numeric(secs))
}

#' new_hms()
#'
#' `new_hms()` is a low-level constructor that only checks that its input has the correct base type, [numeric].
#'
#' @rdname hms
#' @export
new_hms <- function(x = numeric()) {
  vec_assert(x, numeric())

  out <- new_duration(x, units = "secs")

  # no class argument?
  class(out) <- c("hms", class(out))
  out
}

#' is_hms()
#'
#' `is_hms()` checks if an object is of class `hms`.
#'
#' @rdname hms
#' @export
is_hms <- function(x) inherits(x, "hms")

#' Deprecated functions
#'
#' @name Deprecated
NULL

#' Deprecated is.hms()
#'
#' `is.hms()` has been replaced by [is_hms()].
#'
#' @inheritParams is_hms
#' @rdname Deprecated
#' @export
#' @keywords internal
is.hms <- function(x) {
  deprecate_warn("1.2.0", "hms::is.hms()", "hms::is_hms()")
  is_hms(x)
}

#' @export
vec_ptype_abbr.hms <- function(x, ...) {
  "time"
}

#' @export
vec_ptype_full.hms <- function(x, ...) {
  "time"
}

# Coercion in -------------------------------------------------------------

#' as_hms()
#'
#' `as_hms()` is a generic that supports conversions beyond casting.
#' The default method forwards to [vec_cast()].
#'
#' For arguments of type [POSIXct] and [POSIXlt], `as_hms()` does not perform timezone
#' conversion.
#' Use [lubridate::with_tz()] and [lubridate::force_tz()] as necessary.
#'
#' @rdname hms
#' @param x An object.
#' @export
as_hms <- function(x, ...) {
  check_dots_used()

  UseMethod("as_hms")
}

#' @export
as_hms.default <- function(x, ...) {
  vec_cast(x, new_hms())
}

#' Deprecated as.hms()
#'
#' `as.hms()` has been replaced by [as_hms()], which does not have a `tz` argument.
#' Change the timezone before converting if necessary, e.g. using [lubridate::with_tz()].
#'
#' @inheritParams as_hms
#' @param ... Arguments passed on to further methods.
#' @rdname Deprecated
#' @export
#' @keywords internal
as.hms <- function(x, ...) {
  deprecate_warn("1.2.0", "hms::as.hms()", "hms::as_hms()")
  UseMethod("as.hms", x)
}

#' @rdname Deprecated
#' @export
as.hms.default <- function(x, ...) {
  as_hms(x)
}

#' @rdname Deprecated
#' @param tz The time zone in which to interpret a POSIXt time for extracting
#'   the time of day.  The default is now the zone of `x` but was `"UTC"`
#'   for v0.3 and earlier.  The previous behavior can be restored by calling
#'   `pkgconfig::set_config("hms::default_tz", "UTC")`, see
#'   [pkgconfig::set_config()].
#' @export
as.hms.POSIXt <- function(
  x,
  tz = pkgconfig::get_config("hms::default_tz", ""),
  ...
) {
  time <- as.POSIXlt(x, tz = tz)
  vec_cast(time, new_hms())
}

#' @rdname Deprecated
#' @export
as.hms.POSIXlt <- function(
  x,
  tz = pkgconfig::get_config("hms::default_tz", ""),
  ...
) {
  # We need to roundtrip via as.POSIXct() to respect the time zone
  time <- as.POSIXlt(as.POSIXct(x), tz = tz)
  vec_cast(time, new_hms())
}


# Coercion out ------------------------------------------------------------

#' @rdname hms
#' @inheritParams base::as.data.frame
#' @export
as.POSIXct.hms <- function(x, ...) {
  vec_cast(x, new_datetime())
}

#' @rdname hms
#' @export
as.POSIXlt.hms <- function(x, ...) {
  vec_cast(x, as.POSIXlt(new_datetime()))
}

#' @rdname hms
#' @export
as.character.hms <- function(x, ...) {
  vec_cast(x, character())
}

format_hms <- function(x) {
  xx <- decompose(x)

  ifelse(
    is.na(x),
    NA_character_,
    paste0(
      ifelse(xx$sign, "-", ""),
      format_hours(xx$hours),
      ":",
      format_two_digits(xx$minute_of_hour),
      ":",
      format_two_digits(xx$second_of_minute),
      format_tics(xx$tics)
    )
  )
}


# Subsetting --------------------------------------------------------------

#' @export
`[[.hms` <- function(x, ...) {
  vec_restore(NextMethod(), x)
}

#' @export
`[<-.hms` <- function(x, i, value) {
  if (missing(i)) {
    i <- TRUE
  }

  x <- vec_data(x)

  # Workaround for Ops.difftime() implementation for unary minus
  if (identical(class(value), "numeric")) {
    attr(value, "units") <- NULL
  }

  value <- vec_cast(value, new_hms())
  x[i] <- vec_data(value)
  new_hms(x)
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
    cli_warn("{.pkg hms} always uses seconds as unit.")
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

# Sequence generation -----------------

#' @rdname hms
#' @inheritParams base::seq
#' @export
seq.hms <- function(
  from = hms(1),
  to = hms(1),
  by = NULL,
  ...
) {
  if (!is_hms(to)) {
    abort(sprintf(
      "`to` isn't of class `hms` (current class: `%s`).",
      class(to)[1]
    ))
  }

  from <- vec_cast(as_hms(from), numeric())
  to <- vec_cast(as_hms(to), numeric())

  if (!is.null(by)) {
    if (!(is_hms(by) || inherits(by, "difftime"))) {
      abort(sprintf(
        "`by` isn't of class `hms` or `difftime` (current class: `%s`).",
        class(by)[1]
      ))
    }
    by <- vec_cast(as_hms(by), numeric())
    return(hms(seq(from, to, by, ...)))
  }

  hms(seq(from, to, ...))
}
