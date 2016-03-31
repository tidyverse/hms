context("construct")

test_that("constructor", {
  expect_identical(hms(1:3, 2:4, 3:5),
                   hms(seconds = 1:3 + 2:4 * 60 + 3:5 * 3600))

  expect_error(hms(), "seconds")
})
