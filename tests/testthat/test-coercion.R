test_that("coercion in", {
  expect_identical(as_hms(0.5 * 86400), hms(hours = 12))
  expect_identical(as_hms(-0.25 * 86400), hms(hours = -6))
  expect_hms_equal(as_hms("12:34:56"), hms(56, 34, 12))
  expect_hms_equal(as_hms(strptime("12:34:56", format = "%H:%M:%S", tz = "UTC")),
    hms(56, 34, 12))
  expect_hms_equal(as_hms(strptime("12:34:56", format = "%H:%M:%S", tz = "Europe/Zurich")),
    hms(56, 34, 12))
  expect_hms_equal(as_hms(strptime("12:34:56", format = "%H:%M:%S", tz = "PST8PDT")),
    hms(56, 34, 12))
  expect_hms_equal(as_hms(as.POSIXct(strptime("12:34:56", format = "%H:%M:%S", tz = "UTC"))),
    hms(56, 34, 12))
  expect_hms_equal(as_hms(as.POSIXct(strptime("12:34:56", format = "%H:%M:%S", tz = "Europe/Zurich"))),
    hms(56, 34, 12))
  expect_hms_equal(as_hms(as.POSIXct(strptime("12:34:56", format = "%H:%M:%S", tz = "PST8PDT"))),
    hms(56, 34, 12))

  now <- Sys.time()
  now_lt <- as.POSIXlt(now)
  expect_hms_equal(as_hms(now), hms(now_lt$sec, now_lt$min, now_lt$hour))
  expect_hms_equal(as_hms(now_lt), as_hms(now))

  expect_error(as_hms(FALSE))

  x <- c("12:34:56", "ab:cd:ef")
  expect_error(hms::as_hms(x))
})

test_that("coercion out", {
  expect_identical(as.character(hms(56, 34, 12)), "12:34:56")
  expect_identical(as.character(hms(NA)), NA_character_)
  expect_identical(as.POSIXlt(hms(hours = 6)),
    strptime("1970-01-01 06:00:00",
      format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))
  expect_identical(as.POSIXct(hms(hours = -6)),
    strptime("1970-01-01 18:00:00",
      format = "%Y-%m-%d %H:%M:%S", tz = "UTC") - 86400)

  df <- data.frame(a = 1:3)
  df$b <- hms(hours = df$a)
  expect_identical(df, data.frame(a = 1:3, b = hms(hours = 1:3)))
})
