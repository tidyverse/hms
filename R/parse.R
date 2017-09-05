#' Parsing hms values
#'
#' This function convertd character vectors to objects of the [hms] class.
#' `NA` values are supported.
#'
#' `parse_hms()` accepts values of the form `"DdHH:MM:SS"`, with optional
#' days, and fractional seconds. It also supports minus signs.
#' @param x A character vector
#' @export
#' @examples
#' time_str <- c("12:34:56",         # regular format
#'               "12:34:56.789",     # decimal points
#'               "20:12",            # HH:MM (no seconds)
#'               "-12:34:56.001",    # negative values without days
#'               "1d 12:34:56",      # number of days (integer)
#'               "1d 12:34:56.001",  # decimal points and days
#'               "-1d 12:34:56.001", # negative values
#'               "-1d 12:34:56.001", # negative values and space
#'               "0.5d"              # day only
#' )
#'
#' parse_hms(time_str)
parse_hms <- function(x){
  out <- lapply(x, parse_one_hms)

  issues <- sapply(out, function(time){
                            !is.null(attr(time, "issue"))
                            })

  issue_str <- sapply(out[issues], function(time){
                                        attr(time, "issue")
                                        })
  out <- hms(c(out, recursive = T))

  if(sum(issues) == 0){
    return(out)
  }

  problems <- data.frame(row = which(issues),
                         col = NA_integer_,
                         expected = "hms like",
                         actual = x[issues],
                         detail = issue_str)
  attr(out, "problems") <- problems
  out
}

#' parse a scalar and return a number of second
#' the result has an optional "issue" attribute
#' that can be used to build the "problems"
#' data.table
#' @noRd
parse_one_hms <- function(x, na = c("NA", "")){
  out <- NA
  if(x %in% na | is.na(x))
    return(out)

  pattern <- "^(-)?(\\s*)?((.+)d)?(\\s*)?(.+)?$"
  match <- stringr::str_match(x, pattern)

  colnames(match) <- c("all", "minus", "sp1", "xd", "days", "sp2", "hours")
  neither_days_nor_hours <- x[is.na(match[, "days"]) & is.na(match[,"hours"])]
  if(length(neither_days_nor_hours) > 0){
    attr(out, "issue") <- "Wrong format. Neither days nor hours are provided!"
    return(out)
  }

  n_seconds_hours <-parse_one_time_str(match[, "hours"])
  if(is.na(n_seconds_hours)){
    # returned with the error attr
    return(n_seconds_hours)
  }

  n_seconds_days <- ifelse(is.na(match[, "days"]),
                           0,
                           86400 * as.numeric(match[, "days"]))
  invalid_day_format <- n_seconds_days[is.na(n_seconds_days)]
  if(length(invalid_day_format) > 0){
    attr(out, "issue") <- "Invalid day format!"
    return(out)
  }
  overflow <- x[n_seconds_hours >= 86400 & n_seconds_days != 0]
  if(length(overflow) > 0){
    attr(out, "issue") <- "Overflow in number of hours. Cannot add more than 23h and use days!"
    return(out)
  }

  frac_day <- x[n_seconds_days %% 86400 != 0 & n_seconds_hours != 0]
  if(length(frac_day) > 0){
    attr(out, "issue") <- "Cannot use fractional days AND hours!"
    return(out)
  }

  n_seconds <- n_seconds_hours + n_seconds_days

    # match the tailing `-`
  out <- ifelse(is.na(match[, 2]), n_seconds, -n_seconds)
  names(out) <- NULL
  out
}

#' just parse the "HH:MM:SS.xxx" part
#' @noRd
parse_one_time_str <- function(str){
  out <- NA
  if(length(str) != 1){
    stop("parse_time_str only work on scalars")
  }

  if(is.na(str)){
    return(0)
  }
  pattern <- "^((\\d+):([0-9][0-9]))(:([0-9][0-9])(\\.\\d*)?)?$"
  match = stringr::str_match(str, pattern)
  colnames(match) <- c("all", "hm", "h", "m","all_sec","s","split_sec")

  if(is.na(match[,"hm"])){
    attr(out, "issue") <- "Invalid time format!"
    return(out)
  }

  hours <- as.numeric(match[, "h"])
  mins <- as.numeric(match[, "m"])
  secs <- ifelse(is.na(match[, "s"]), 0, as.numeric(match[, "s"]))
  split_secs <- ifelse(is.na(match[, "split_sec"]),
                       0,
                       as.numeric(match[, "split_sec"]))
  secs <- secs + split_secs

  if(mins >= 60){
    attr(out, "issue") <- "Overflow in number of minutes. Cannot add more than 59min!"
    return(out)
  }

  if(secs >= 60){
    attr(out, "issue") <- "Overflow in number of seconds. Cannot add more than 59s!"
    return(out)
  }

  hours * 3600 + mins * 60 + secs
}


