check_args <- function(args) {
  lengths <- vapply(args, length, integer(1L))
  if (all(lengths == 0L)) {
    stop("Need to pass at least one entry for seconds, minutes, hours, or days to hms().",
         call. = FALSE)
  }

  valid <- vapply(args[lengths > 0], is_numeric_or_na, logical(1L))
  if (!all(valid)) {
    stop("All arguments must be numeric or NA", call. = FALSE)
  }

  if (!all(diff(which(lengths != 0L)) == 1L)) {
    stop("Can't pass only ", paste(names(lengths)[lengths != 0L], collapse = ", "),
         " to hms().", call. = FALSE)
  }

  lengths <- lengths[lengths != 0]
  if (length(unique(lengths)) > 1L) {
    stop("All arguments to hms() must have the same length or be NULL. Found ",
         paste0("length(", names(lengths), ") = ", lengths, collapse = ", "), ".",
         call. = FALSE)
  }
}

is_numeric_or_na <- function(x) {
  is.numeric(x) || all(is.na(x))
}
