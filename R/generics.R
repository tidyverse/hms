#' @export
Ops.hms <- function(e1, e2) {
  if (.Generic == "+" && (inherits(e1, "Date") || inherits(e2, "Date"))) {
    return(base::`+.Date`(e1, e2))
  } else if (.Generic == "-" && inherits(e1, "Date")) {
    return(base::`-.Date`(e1, e2))
  }
  res <- NextMethod(.Generic)
  if (inherits(res, "difftime")) {
    as_hms(res)
  } else {
    res
  }
}

#' @export
`+.Date` <- Ops.hms

#' @export
`-.Date` <- Ops.hms
