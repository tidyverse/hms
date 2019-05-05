# nocov start
.onLoad <- function(...) {
  vctrs::s3_register("pillar::pillar_shaft", "hms")

  if (packageVersion("vctrs") <= "0.1.0") {
    vec_default_cast <<- vec_default_cast_old
  } else {
    rm("vec_default_cast", inherits = TRUE)
  }

  invisible()
}
# nocov end
