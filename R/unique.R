#' @export
unique.hms <- function(x, incomparables = FALSE, ...) {
  x <- as.numeric(x)
  x <- unique(x, incomparables = incomparables, ...)
  new_hms(x)
}
