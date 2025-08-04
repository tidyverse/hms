check_args <- function(args, call = caller_env()) {
  is_null <- map_lgl(args, is.null)
  if (all(is_null)) {
    return()
  }

  valid <- map_lgl(args[!is_null], is_numeric_or_na)
  if (!all(valid)) {
    cli_abort("All arguments must be {.cls numeric} or {.cls NA}", call = call)
  }

  if (!all(diff(which(!is_null)) == 1L)) {
    cli_abort(
      paste(
        "Can't pass only ",
        paste(names(is_null)[!is_null], collapse = ", "),
        " to {.fn hms}."
      ),
      call = call
    )
  }

  lengths <- map_int(args[!is_null], length)
  if (length(unique(lengths)) > 1L) {
    cli_abort(
      paste(
        "All arguments to {.fn hms} must have the same length or be NULL. Found ",
        paste0("length(", names(lengths), ") = ", lengths, collapse = ", "),
        "."
      ),
      call = call
    )
  }
}

is_numeric_or_na <- function(x) {
  is.numeric(x) || all(is.na(x))
}
