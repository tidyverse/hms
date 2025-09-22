check_args <- function(args, call = caller_env()) {
  is_null <- map_lgl(args, is.null)
  if (all(is_null)) {
    return()
  }

  valid <- map_lgl(args[!is_null], is_numeric_or_na)
  if (!all(valid)) {
    cli_abort("All arguments must be {.cls numeric} or {.val {NA}}", call = call)
  }

  if (!all(diff(which(!is_null)) == 1L)) {
    cli_abort(
      paste(
        "Can't pass only {names(is_null)[!is_null]} to {.fn hms}."
      ),
      call = call
    )
  }
}

is_numeric_or_na <- function(x) {
  is.numeric(x) || all(is.na(x))
}
