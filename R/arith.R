SECONDS_PER_MINUTE <- 60
MINUTES_PER_HOUR <- 60
HOURS_PER_DAY <- 24

SECONDS_PER_HOUR <- MINUTES_PER_HOUR * SECONDS_PER_MINUTE
SECONDS_PER_DAY <- HOURS_PER_DAY * SECONDS_PER_HOUR

days <- function(x) {
  trunc(as.numeric(x) / SECONDS_PER_DAY)
}

hours <- function(x) {
  trunc(as.numeric(x) / SECONDS_PER_HOUR)
}

hour_of_day <- function(x) {
  abs(hours(x) - days(x) * HOURS_PER_DAY)
}

minutes <- function(x) {
  trunc(as.numeric(x) / SECONDS_PER_MINUTE)
}

minute_of_hour <- function(x) {
  abs(minutes(x) - hours(x) * MINUTES_PER_HOUR)
}

seconds <- function(x) {
  trunc(as.numeric(x))
}

second_of_minute <- function(x) {
  abs(seconds(x) - minutes(x) * SECONDS_PER_MINUTE)
}

split_seconds <- function(x) {
  as.numeric(x)
}

split_second_of_second <- function(x) {
  abs(split_seconds(x) - seconds(x))
}

decompose <- function(x) {
  list(
    sign = x < 0,
    hours = abs(hours(x)),
    minute_of_hour = minute_of_hour(x),
    second_of_minute = second_of_minute(x),
    split_seconds = split_second_of_second(x)
  )
}
