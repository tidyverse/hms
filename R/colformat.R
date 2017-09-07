# Dynamically exported, see zzz.R
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

  need_split_seconds <- any(highlight_split_seconds, na.rm = TRUE)
  need_seconds <- need_split_seconds || any(highlight_seconds, na.rm = TRUE)
  need_hours <- any(highlight_hours, na.rm = TRUE)
  need_sign <- any(xx$sign)

  if (need_hours) {
    data_seconds <- paste0(
      if(need_sign) ifelse(xx$sign, "-", " ") else "",
      colformat::style_num(format_hours(xx$hours), xx$sign, highlight_hours),
      colformat::style_subtle(":"),
      colformat::style_num(format_two_digits(xx$minute_of_hour), xx$sign, highlight_minutes),
      if (need_seconds) paste0(
        colformat::style_subtle(":"),
        colformat::style_num(format_two_digits(xx$second_of_minute), xx$sign, highlight_seconds)
      )
    )
    data <- paste0(
      data_seconds,
      colformat::style_num(format_split_seconds(xx$split_seconds), xx$sign, highlight_split_seconds)
    )
  } else {
    data_seconds <- paste0(
      if(need_sign) ifelse(xx$sign, "-", " ") else "",
      colformat::style_num(format_two_digits(xx$minute_of_hour), xx$sign, highlight_minutes),
      colformat::style_subtle("'"),
      colformat::style_num(format_two_digits(xx$second_of_minute), xx$sign, highlight_seconds),
      colformat::style_num(format_split_seconds(xx$split_seconds), xx$sign, highlight_split_seconds),
    )
    data <- paste0(data_seconds, colformat::style_subtle('"'))
  }

  na_indent <- crayon::col_nchar(data_seconds[1], type = "width") - 2L
  data[is.na(x)] <- NA

  colformat::new_cf_data(data, na_indent = na_indent)
}
