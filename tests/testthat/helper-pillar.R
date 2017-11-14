expect_known_pillar_shaft_display <- function(x, file, width) {
  object_quo <- rlang::quo(format(pillar::pillar_shaft(x), width = width))
  pillar::expect_known_display(!!object_quo, file = file.path("out", file))
}
