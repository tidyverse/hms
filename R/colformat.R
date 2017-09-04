#' @import colformat
#' @export
cf_data.hms <- function(x, ...) {
  data <- rep(NA_character_, length(x))

  xx <- decompose(x)
  highlight_hours <- xx$hours > 0
  highlighted <- highlight_hours
  highlight_minutes <- !highlighted & xx$minute_of_hour > 0
  highlighted <- highlighted | highlight_minutes
  highlight_seconds <- !highlighted & xx$second_of_minute > 0
  highlighted <- highlighted | highlight_seconds
  highlight_split_seconds <- !highlighted & xx$split_seconds > 0

  need_split_seconds <- any(highlight_split_seconds)
  # need_seconds <- need_split_seconds || any(highlight_seconds)
  # need_hours <- any(highlight_hours)
  need_seconds <- TRUE
  need_hours <- TRUE
  need_sign <- any(xx$sign)

  if (need_hours) {
    if (need_seconds) {
      data <- paste0(
        if(need_sign) ifelse(xx$sign, "-", " ") else "",
        style_num(format_two_digits(xx$hours), xx$sign, highlight_hours),
        style_subtle(":"),
        style_num(format_two_digits(xx$minute_of_hour), xx$sign, highlight_minutes),
        style_subtle(":"),
        style_num(format_two_digits(xx$second_of_minute), xx$sign, highlight_seconds),
        style_num(format_split_seconds(xx$split_seconds), xx$sign, highlight_split_seconds)
      )
    }
  } else {
  }

  data[is.na(x)] <- NA

  new_cf_data(data)
}
