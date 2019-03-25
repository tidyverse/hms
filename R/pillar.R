# Dynamically exported, see zzz.R
pillar_shaft.hms <- function(x, ...) {
  data <- rep(NA_character_, length(x))

  xx <- decompose(x)
  has_hours <- xx$hours > 0
  highlight_hours <- has_hours
  highlighted <- highlight_hours

  has_minutes <- xx$minute_of_hour > 0
  highlight_minutes <- !highlighted & has_minutes
  highlighted <- highlighted | highlight_minutes

  has_seconds <- xx$second_of_minute > 0
  highlight_seconds <- !highlighted & has_seconds
  highlighted <- highlighted | highlight_seconds

  has_tics <- xx$tics > 0
  highlight_tics <- !highlighted & has_tics

  need_tics <- any(has_tics, na.rm = TRUE)
  need_seconds <- need_tics || any(has_seconds, na.rm = TRUE)
  need_hours <- any(has_hours, na.rm = TRUE)
  need_sign <- any(xx$sign)

  if (need_hours) {
    data_seconds <- paste0(
      if (need_sign) ifelse(xx$sign, "-", " ") else "",
      pillar::style_num(format_hours(xx$hours), xx$sign, highlight_hours),
      pillar::style_subtle(":"),
      pillar::style_num(format_two_digits(xx$minute_of_hour), xx$sign, highlight_minutes),
      if (need_seconds) paste0(
        pillar::style_subtle(":"),
        pillar::style_num(format_two_digits(xx$second_of_minute), xx$sign, highlight_seconds)
      )
    )
    data <- paste0(
      data_seconds,
      if (need_seconds) {
        pillar::style_num(format_tics(xx$tics), xx$sign, highlight_tics)
      }
    )
  } else {
    data_seconds <- paste0(
      if (need_sign) ifelse(xx$sign, "-", " ") else "",
      pillar::style_num(format_two_digits(xx$minute_of_hour), xx$sign, highlight_minutes),
      pillar::style_subtle("'"),
      pillar::style_num(format_two_digits(xx$second_of_minute), xx$sign, highlight_seconds)
    )
    data <- paste0(
      data_seconds,
      pillar::style_num(format_tics(xx$tics), xx$sign, highlight_tics),
      pillar::style_subtle('"')
    )
  }

  na_indent <- crayon::col_nchar(data_seconds[1], type = "width") - 2L
  data[is.na(x)] <- NA

  pillar::new_pillar_shaft_simple(data, na_indent = na_indent)
}
