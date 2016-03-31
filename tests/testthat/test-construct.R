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
  expect_hms_equal(as.hms(strptime("12:34:56", format = "%H:%M:%S", tz = "UTC")),
                   hms(56, 34, 12))
  expect_hms_equal(as.hms(strptime("12:34:56", format = "%H:%M:%S", tz = "CEST")),
                   hms(56, 34, 12))
  expect_hms_equal(as.hms(strptime("12:34:56", format = "%H:%M:%S", tz = "PST")),
                   hms(56, 34, 12))

  expect_error(as.hms(FALSE))
})

test_that("coercion out", {
  expect_identical(as.character(hms(56, 34, 12)), "12:34:56")
  expect_identical(as.POSIXlt(hms(hours = 6)),
                   strptime("1970-01-01 06:00:00",
                            format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_identical(as.POSIXct(hms(hours = -6)),
                   strptime("1970-01-01 18:00:00",
                            format = "%Y-%m-%d %H:%M:%S", tz = "UTC") - 86400)

})
