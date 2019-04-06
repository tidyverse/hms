SPLIT_SECOND_DIGITS <- 6L

TICS_PER_SECOND <- 10^SPLIT_SECOND_DIGITS
SECONDS_PER_MINUTE <- 60
MINUTES_PER_HOUR <- 60
HOURS_PER_DAY <- 24

TICS_PER_MINUTE <- SECONDS_PER_MINUTE * TICS_PER_SECOND
TICS_PER_HOUR <- MINUTES_PER_HOUR * TICS_PER_MINUTE
TICS_PER_DAY <- HOURS_PER_DAY * TICS_PER_HOUR

days <- function(x) {
  trunc(x / TICS_PER_DAY)
}

hours <- function(x) {
  trunc(x / TICS_PER_HOUR)
}

hour_of_day <- function(x) {
  abs(hours(x) - days(x) * HOURS_PER_DAY)
}

minutes <- function(x) {
  trunc(x / TICS_PER_MINUTE)
}

minute_of_hour <- function(x) {
  abs(minutes(x) - hours(x) * MINUTES_PER_HOUR)
}

seconds <- function(x) {
  trunc(x / TICS_PER_SECOND)
}

second_of_minute <- function(x) {
  abs(seconds(x) - minutes(x) * SECONDS_PER_MINUTE)
}

tics <- function(x) {
  x
}

tic_of_second <- function(x) {
  abs(tics(x) - seconds(x) * TICS_PER_SECOND)
}

decompose <- function(x) {
  x <- vec_data(x) * TICS_PER_SECOND

  # #140
  xr <- round(x)

  out <- list(
    sign = xr < 0 & !is.na(xr),
    hours = abs(hours(xr)),
    minute_of_hour = minute_of_hour(xr),
    second_of_minute = second_of_minute(xr),
    tics = tic_of_second(xr)
  )

  # #140: Make sure zeros are printed
  fake_zero <- (out$tics == 0) & (xr != x)
  out$tics[fake_zero] <- 0.25

  out
}
