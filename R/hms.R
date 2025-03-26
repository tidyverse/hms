#' @details
#' `r lifecycle::badge("stable")`
#' @importFrom lifecycle deprecate_soft expect_deprecated
#' @import vctrs
#' @import rlang
#' @aliases hms-package NULL
"_PACKAGE"

#' @importFrom methods setOldClass
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
  args <- list(seconds = seconds, minutes = minutes, hours = hours, days = days)
  check_args(args)
  arg_secs <- map2(args, c(1, 60, 3600, 86400), `*`)
  secs <- reduce(arg_secs[!map_lgl(args, is.null)], `+`)
  if (is.null(secs)) secs <- numeric()

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
  deprecate_soft("0.5.0", "hms::is.hms()", "hms::is_hms()")
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
  deprecate_soft("0.5.0", "hms::as.hms()", "hms::as_hms()")
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
#' @importFrom pkgconfig get_config
as.hms.POSIXt <- function(x, tz = pkgconfig::get_config("hms::default_tz", ""), ...) {
  time <- as.POSIXlt(x, tz = tz)
  vec_cast(time, new_hms())
}

#' @rdname Deprecated
#' @export
as.hms.POSIXlt <- function(x, tz = pkgconfig::get_config("hms::default_tz", ""), ...) {
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

  ifelse(is.na(x), NA_character_, paste0(
    ifelse(xx$sign, "-", ""),
    format_hours(xx$hours), ":",
    format_two_digits(xx$minute_of_hour), ":",
    format_two_digits(xx$second_of_minute),
    format_tics(xx$tics)))
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
    warning("hms always uses seconds as unit.", call. = FALSE)
  }
  x
}


# Output ------------------------------------------------------------------

decimal_digits <- function(x) {
  sapply(x, function(num) {
    if (is.na(num) || num %% 1 == 0) return(0)
    
    dec_str <- sub(
      "^[^.]*\\.",
      "",
      sub("0+$", "", format(num, scientific = FALSE, trim = TRUE))
    )
    nchar(dec_str)
  })
}

#' @rdname hms
#' @export
format.hms <- function(x, format = "H:m:s_dec", digits, ...) {
  if (length(x) == 0L) {
    "hms()"
  } else {
    secs_all <- as.numeric(x)
    is_neg <- secs_all < 0
    is_neg[is.na(is_neg)] <- FALSE
    has_digit <- any(secs_all %% 1 != 0, na.rm = TRUE)
    if (has_digit && missing(digits)) {
      digits <- min(max(decimal_digits(secs_all)), 6)
    } else if (!has_digit && missing(digits)) {
      digits <- 0
    }
    secs_all <- abs(secs_all)
    pad2 <- function(n) sprintf("%02d", n)

    format_one <- function(secs, digits) {
      if (is.na(secs)) {
        return("NA")
      }
      h <- floor(secs / 3600)
      m <- floor((secs %% 3600) / 60)
      
      s_dec <- secs %% 60
      s_dec_str <- formatC(
        s_dec,
        format = "f",
        digits = digits,
        flag = "0"
      )
      if (s_dec >= 0 && s_dec < 10) {
        s_dec_str <- paste0("0", s_dec_str)
      }
      out <- format
      out <- gsub("s_dec", s_dec_str, out, fixed = TRUE)
      out <- gsub("H", pad2(h), out, fixed = TRUE)
      out <- gsub("m", pad2(m), out, fixed = TRUE)
      

      out
    }

    raw_vals <- vapply(secs_all, format_one, character(1), digits = digits)
    max_width <- max(nchar(raw_vals, type = "width"))
    non_neg_vals <- sprintf(paste0("%", max_width, "s"), raw_vals)
    if (any(is_neg, na.rm = TRUE)) {
      prefix <- ifelse(is_neg, "-", " ")
      return(paste0(prefix, non_neg_vals))
    }
    non_neg_vals
  }
}

#' @rdname hms
#' @export
print.hms <- function(x, ...) {
  cat(format(x), sep = "\n")
  invisible(x)
}
