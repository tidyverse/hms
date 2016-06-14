format_two_digits <- function(x) {
  formatC(x, width = 2, flag = "0")
}

format_split_seconds <- function(x) {
  split_second <- split_second_of_second(x)
  out <- format(split_second, scientific = FALSE)
  digits <- max(min(max(nchar(out) - 2), 6), 0)
  out <- formatC(split_second, format = "f", digits = digits)
  gsub("^0", "", out)
}
