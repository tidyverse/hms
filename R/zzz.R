# nocov start
.onLoad <- function(...) {
  vctrs::s3_register("pillar::pillar_shaft", "hms")

  invisible()
}
# nocov end
