format_two_digits <- function(x) {
  formatC(x, width = 2, flag = "0")
}

format_split_seconds <- function(x) {
  split_second <- split_second_of_second(x)
  gsub("^0", "", format(split_second, scientific = FALSE))
}
