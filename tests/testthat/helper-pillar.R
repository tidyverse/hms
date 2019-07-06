expect_known_pillar_shaft_display <- function(x, file, width) {
  object_quo <- rlang::quo(pillar::pillar_shaft(x))

  # Avoid crayon tests on CRAN
  crayon <- identical(Sys.getenv("NOT_CRAN"), "true")

  pillar::expect_known_display(!!object_quo, file = file.path("out", file), crayon = crayon)
}
