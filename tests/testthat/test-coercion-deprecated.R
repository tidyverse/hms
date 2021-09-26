test_that("coercion in", {
  expect_deprecated(
    expect_identical(as.hms(0.5 * 86400), hms(hours = 12))
  )
  expect_deprecated(
    expect_identical(as.hms(-0.25 * 86400), hms(hours = -6))
  )
  expect_deprecated(
    expect_hms_equal(as.hms("12:34:56"), hms(56, 34, 12))
  )
  expect_deprecated(
    expect_hms_equal(
      as.hms(strptime("12:34:56", format = "%H:%M:%S", tz = "UTC"), tz = "UTC"),
      hms(56, 34, 12)
    )
  )
  expect_deprecated(
    expect_hms_equal(
      as.hms(strptime("12:34:56", format = "%H:%M:%S", tz = "Europe/Zurich"), tz = "Europe/Zurich"),
      hms(56, 34, 12)
    )
  )
  expect_deprecated(
    expect_hms_equal(
      as.hms(strptime("12:34:56", format = "%H:%M:%S", tz = "PST8PDT"), tz = "PST8PDT"),
      hms(56, 34, 12)
    )
  )

  now <- Sys.time()
  now_lt <- as.POSIXlt(now)
  expect_deprecated(
    expect_hms_equal(as.hms(now), hms(now_lt$sec, now_lt$min, now_lt$hour))
  )
  expect_deprecated(
    expect_hms_equal(as.hms(now_lt), as_hms(now))
  )

  expect_error(expect_deprecated(as.hms(FALSE)))
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
