context("construct")

test_that("constructor", {
  expect_identical(hms(1:3, 2:4, 3:5),
                   hms(seconds = 1:3 + 2:4 * 60 + 3:5 * 3600))
  expect_identical(hms(-1, 1), hms(59))
  expect_identical(hms(3600), hms(hours = 1))

  expect_true(is.hms(hms(1)))
  expect_true(is.numeric(hms(1)))
  expect_identical(as.numeric(hms(1)), 1)

  expect_error(hms(), "seconds")
})
