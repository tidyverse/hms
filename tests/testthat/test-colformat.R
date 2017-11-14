context("pillar")

test_that("pillar", {
  expect_known_pillar_shaft_display(
    hms(c(-3600, -60, -1, -0.001, 0, 0.001, 1, 60, 3600, NA)),
    width = 13,
    file = "hmss.txt"
  )
  expect_known_pillar_shaft_display(
    hms(c(-3600000, -3600, -60, -1, 0, 1, 60, 3600, 3600000, NA)),
    width = 11,
    file = "hms.txt"
  )
  expect_known_pillar_shaft_display(
    hms(c(-3600, -60, 0, 60, 3600, NA)),
    width = 6,
    file = "hm.txt"
  )
  expect_known_pillar_shaft_display(
    hms(c(-60, -1, 0, 1, 60, NA)),
    width = 7,
    file = "ms.txt"
  )
  expect_known_pillar_shaft_display(
    hms(c(-60, -1, -0.001, 0, 0.001, 1, 60, NA)),
    width = 11,
    file = "mss.txt"
  )
})
