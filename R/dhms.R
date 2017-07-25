#' @importFrom methods setOldClass
setOldClass(c("dhms", "hms"))


#' @rdname hms
#' @export
dhms <- function(seconds = NULL, minutes = NULL, hours = NULL, days = NULL) {
  x <- hms(seconds, minutes, hours, days)
  structure(x, class = unique(c("dhms", class(x))))
}

# Coercion in -------------------------------------------------------------
#' @rdname hms
#' @inheritParams hms
#' @export
as.dhms <- function(x, ...) UseMethod("as.dhms", x)

#' @rdname hms
#' @export
as.dhms.default <- function(x, ...) {
  s <- as.numeric(as.hms(x))
  dhms(seconds=s)
}

# Coercion out ------------------------------------------------------------

#' @rdname hms
#' @export
as.character.dhms <- function(x, ...) {
  ifelse(is.na(x), "NA", paste0(
    ifelse(x < 0, "-", ""),
    abs(days(x)), "d",
    format_two_digits(abs(hour_of_day(x))), ":",
    format_two_digits(minute_of_hour(x)), ":",
    format_two_digits(second_of_minute(x)),
    format_split_seconds(x)))
}

# Subsetting --------------------------------------------------------------
#' @export
`[[.dhms` <- function(x, ...) {
  dhms(NextMethod())
}

# Combination -------------------------------------------------------------
#' @export
c.dhms <- function(x, ...) {
  as.dhms(NextMethod())
}



