format_hours <- function(x) {
  format(format_two_digits(x), justify = "right")
}

format_two_digits <- function(x) {
  formatC(x, format = "f", digits = 0, width = 2, flag = "0")
}

format_tics <- function(x) {
  x <- x / TICS_PER_SECOND

  out <- format(x, scientific = FALSE, digits = SPLIT_SECOND_DIGITS + 1L)
  digits <- max(min(max(nchar(out) - 2), SPLIT_SECOND_DIGITS), 0)
  out <- formatC(x, format = "f", digits = digits)
  gsub("^0", "", out)
}
