context("pillar")

test_that("pillar", {
  pillar:::expect_pillar_output(
    xp = hms(c(-3600, -60, -1, -0.001, 0, 0.001, 1, 60, 3600, NA)),
    filename = "hmss.txt"
  )
  pillar:::expect_pillar_output(
    xp = hms(c(-3600000, -3600, -60, -1, 0, 1, 60, 3600, 3600000, NA)),
    filename = "hms.txt"
  )
  pillar:::expect_pillar_output(
    xp = hms(c(-3600, -60, 0, 60, 3600, NA)),
    filename = "hm.txt"
  )
  pillar:::expect_pillar_output(
    xp = hms(c(-60, -1, 0, 1, 60, NA)),
    filename = "ms.txt"
  )
  pillar:::expect_pillar_output(
    xp = hms(c(-60, -1, -0.001, 0, 0.001, 1, 60, NA)),
    filename = "mss.txt"
  )
})
