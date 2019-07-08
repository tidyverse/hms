expect_known_pillar_shaft_display <- function(x, file, width) {
  # Avoid crayon tests on CRAN
  cran <- !identical(Sys.getenv("NOT_CRAN"), "true")
  if (cran) return()

  object_quo <- rlang::quo(pillar::pillar_shaft(x))
  pillar::expect_known_display(!!object_quo, file = file.path("out", file))
}
