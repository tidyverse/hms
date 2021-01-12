test_that("round_hms()", {
  expect_equal(round_hms(parse_hms("12:34:56"), 5), hms(55, 34, 12))
  expect_equal(round_hms(parse_hms("12:34:56"), 60), hms(0, 35, 12))

  expect_equal(round_hms(parse_hms("12:34:56.78"), digits = 1), hms(56.8, 34, 12))
  expect_equal(round_hms(parse_hms("12:34:56.78"), digits = 0), hms(57, 34, 12))
  expect_equal(round_hms(parse_hms("12:34:36"), digits = -1), hms(40, 34, 12))

  expect_equal(round_hms(parse_hms("12:34:56"), digits = -2), hms(0, 35, 12))
  expect_equal(round_hms(parse_hms("12:34:56"), digits = -3), hms(0, 30, 12))
  expect_equal(round_hms(parse_hms("12:34:56"), digits = -4), hms(0, 0, 13))
  expect_equal(round_hms(parse_hms("12:34:56"), digits = -5), hms(0, 0, 10))
  expect_equal(round_hms(parse_hms("12:34:56"), digits = -6), hms(0, 0, 0))

  expect_equal(round_hms(hms(0.7), 0.25), hms(0.75))
  expect_equal(round_hms(hms(NA), 5), hms(NA))
  expect_equal(round_hms(parse_hms(c("12:34:56", NA)), 5), as_hms(c(hms(55, 34, 12), hms(NA))))
})

test_that("trunc_hms()", {
  expect_equal(trunc_hms(parse_hms("12:34:56"), 5), hms(55, 34, 12))
  expect_equal(trunc_hms(parse_hms("12:34:56"), 60), hms(0, 34, 12))

  expect_equal(trunc_hms(parse_hms("12:34:56.78"), digits = 1), hms(56.7, 34, 12))
  expect_equal(trunc_hms(parse_hms("12:34:56.78"), digits = 0), hms(56, 34, 12))
  expect_equal(trunc_hms(parse_hms("12:34:36"), digits = -1), hms(30, 34, 12))

  expect_equal(trunc_hms(parse_hms("12:34:56"), digits = -2), hms(0, 34, 12))
  expect_equal(trunc_hms(parse_hms("12:34:56"), digits = -3), hms(0, 30, 12))
  expect_equal(trunc_hms(parse_hms("12:34:56"), digits = -4), hms(0, 0, 12))
  expect_equal(trunc_hms(parse_hms("12:34:56"), digits = -5), hms(0, 0, 10))
  expect_equal(trunc_hms(parse_hms("12:34:56"), digits = -6), hms(0, 0, 0))

  expect_equal(trunc_hms(hms(0.7), 0.25), hms(0.5))
  expect_equal(trunc_hms(hms(NA), 5), hms(NA))
  expect_equal(trunc_hms(parse_hms(c("12:34:56", NA)), 5), as_hms(c(hms(55, 34, 12), hms(NA))))
})
