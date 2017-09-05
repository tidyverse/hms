context("dhms construct")

test_that("constructor", {
  expect_identical(dhms(1:3, 2:4, 3:5),
                   dhms(seconds = 1:3 + 2:4 * 60 + 3:5 * 3600))
  expect_identical(dhms(-1, 1), dhms(59))
  expect_identical(dhms(3600), dhms(hours = 1))

  expect_equal(length(dhms(1)), 1L)
  expect_true(is.dhms(dhms(1)))
  expect_is(dhms(1), "difftime")

  # dhms derives from hms
  expect_is(dhms(1), "hms")

  expect_identical(as.numeric(dhms(1)), 1)
  expect_identical(as.difftime(dhms(1)), dhms(1))

  expect_identical(units(as.dhms(as.difftime(1, units = "mins"))), "secs")
  expect_identical(as.dhms(dhms(1)), dhms(1))
})

test_that("zero length (#35)", {
  expect_equal(length(dhms()), 0L)
  expect_true(is.dhms(dhms()))
  expect_is(dhms(), "difftime")
  expect_identical(as.numeric(dhms()), numeric())
  expect_identical(as.difftime(dhms()), dhms())

  expect_identical(dhms(), dhms(seconds = numeric()))
  expect_identical(dhms(), dhms(minutes = numeric()))
  expect_identical(dhms(), dhms(hours = numeric()))
  expect_identical(dhms(), dhms(days = numeric()))
  expect_identical(dhms(), as.dhms(numeric()))
})

test_that("bad input", {
  expect_error(dhms(hours = 1, seconds = 3), "only")
  expect_error(dhms(minutes = 1, days = 3), "only")
  expect_error(dhms(minutes = 1, hours = 2:3), "same length or be NULL")
  expect_error(dhms(seconds = 1:5, minutes = 6:10, hours = 11:17), "same length or be NULL")
  expect_error(dhms("05:00"), "must be numeric")
})
