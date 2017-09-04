context("colformat")

test_that("colformat", {
  colformat:::expect_colformat_output(
    xp = hms(c(-3600, -60, -1, -0.001, 0, 0.001, 1, 60, 3600, NA)),
    filename = "hmss.txt"
  )
  colformat:::expect_colformat_output(
    xp = hms(c(-3600, -60, -1, 0, 1, 60, 3600, NA)),
    filename = "hms.txt"
  )
  colformat:::expect_colformat_output(
    xp = hms(c(-3600, -60, 0, 60, 3600, NA)),
    filename = "hm.txt"
  )
})
