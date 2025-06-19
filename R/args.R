check_args <- function(args) {
  is_null <- map_lgl(args, is.null)
  if (all(is_null)) {
    return()
  }

  valid <- map_lgl(args[!is_null], is_numeric_or_na)
  if (!all(valid)) {
    stop("All arguments must be numeric or NA", call. = FALSE)
  }

  if (!all(diff(which(!is_null)) == 1L)) {
    stop(
      "Can't pass only ",
      paste(names(is_null)[!is_null], collapse = ", "),
      " to hms().",
      call. = FALSE
    )
  }

  lengths <- map_int(args[!is_null], length)
  if (length(unique(lengths)) > 1L) {
    stop(
      "All arguments to hms() must have the same length or be NULL. Found ",
      paste0("length(", names(lengths), ") = ", lengths, collapse = ", "),
      ".",
      call. = FALSE
    )
  }
}

is_numeric_or_na <- function(x) {
  is.numeric(x) || all(is.na(x))
}
