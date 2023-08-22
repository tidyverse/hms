#' @export
Ops.hms <- function(e1, e2) {
  # This logic is hard-coded in R for difftime
  # cf. https://github.com/wch/r-source/blob/a46559e8f728317da979be60e401899ae60086b2/src/main/eval.c#L3406-L3419
  if (.Generic == "+" && (inherits(e1, "Date") || inherits(e2, "Date"))) {
    return(base::`+.Date`(e1, e2))
  } else if (.Generic == "-" && inherits(e1, "Date")) {
    return(base::`-.Date`(e1, e2))
  } else if (.Generic == "+" && (inherits(e1, "POSIXt") || inherits(e2, "POSIXt"))) {
    return(base::`+.POSIXt`(e1, e2))
  } else if (.Generic == "-" && inherits(e1, "POSIXt")) {
    return(base::`-.POSIXt`(e1, e2))
  }

  # delegate to Ops.difftime
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

#' @export
`+.POSIXt` <- Ops.hms

#' @export
`-.POSIXt` <- Ops.hms
