context("construct")

test_that("constructor", {
  expect_identical(hms(1:3, 2:4, 3:5),
                   hms(seconds = 1:3 + 2:4 * 60 + 3:5 * 3600))

  expect_error(hms(), "seconds")
})

test_that("coercion", {
  expect_identical(as.hms(0.5), hms(hours = 12))
  expect_identical(as.hms(-0.25), hms(hours = -6))
  expect_hms_equal(as.hms("12:34:56"), hms(56, 34, 12))

  expect_error(as.hms(FALSE))
})
