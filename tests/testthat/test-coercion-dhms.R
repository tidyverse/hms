context("dhms coercion")

test_that("coercion in", {
  expect_identical(as.dhms(0.5 * 86400 + 86400), dhms(hours = 12, days = 1))
  expect_identical(as.hms(-0.25 * 86400 - 86400), hms(hours = -6, days = -1))
  expect_dhms_equal(as.dhms("12:34:56"), dhms(56, 34, 12))

  # parser tests, to do when working on
  # https://github.com/tidyverse/hms/issues/39
  # expect_dhms_equal(as.dhms("5d12:34:56"), dhms(56, 34, 12, 5))
  # expect_dhms_equal(as.dhms("-5d12:34:56"), -dhms(56, 34, 12, 5))
  # expect_dhms_equal(as.dhms("-0.5d"), -dhms(hours=12))
  # expect_dhms_equal(as.dhms("0.5d"), dhms(hours=12))
  #  ...

  expect_dhms_equal(as.dhms(strptime("12:34:56", format = "%H:%M:%S", tz = "UTC"), tz = "UTC"),
                   dhms(56, 34, 12))
  expect_hms_equal(as.dhms(strptime("12:34:56", format = "%H:%M:%S", tz = "CEST"), tz = "CEST"),
                   dhms(56, 34, 12))
  expect_hms_equal(as.dhms(strptime("12:34:56", format = "%H:%M:%S", tz = "PST8PDT"), tz = "PST8PDT"),
                   dhms(56, 34, 12))

  now <- Sys.time()
  now_lt <- as.POSIXlt(now)
  expect_dhms_equal(as.dhms(now), dhms(now_lt$sec, now_lt$min, now_lt$hour))
  expect_dhms_equal(as.dhms(now_lt), as.dhms(now))
  expect_error(as.dhms(FALSE))
})

test_that("coercion out", {
  expect_identical(as.character(dhms(56, 34, 12)), "0d12:34:56")
  expect_identical(as.character(-dhms(56, 34, 12, 2)), "-2d12:34:56")
  expect_identical(as.POSIXlt(dhms(hours = 6)),
                   strptime("1970-01-01 06:00:00",
                            format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_identical(as.POSIXct(dhms(hours = -6)),
                   strptime("1970-01-01 18:00:00",
                            format = "%Y-%m-%d %H:%M:%S", tz = "UTC") - 86400)

  df <- data.frame(a = 1:3)
  df$b <- dhms(hours = df$a)
  expect_identical(df, data.frame(a = 1:3, b = dhms(hours = 1:3)))
})
