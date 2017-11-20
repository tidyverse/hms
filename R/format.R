format_hours <- function(x) {
  format(format_two_digits(x), justify = "right")
}

format_two_digits <- function(x) {
  formatC(x, format = "f", digits = 0, width = 2, flag = "0")
}

format_split_seconds <- function(x) {
  out <- format(x, scientific = FALSE)
  digits <- max(min(max(nchar(out) - 2), 6), 0)
  out <- formatC(x, format = "f", digits = digits)
  gsub("^0", "", out)
}
