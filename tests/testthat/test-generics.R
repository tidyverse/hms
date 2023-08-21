test_that("generic operations work as intended", {
  # Test that all binary operations involving hms and one of Date, POSIXct, POSIXlt, difftime, hms, numeric, integer
  # behave the same as the operation would with a difftime of the same length, except for difftime results, wich should
  # be hms of the same value instead.

  hms_test_vec <- new_hms(c(0.0, NA_real_, 10.0))

  # hms {+-*/} integer
  expect_equal(hms_test_vec + 1L, new_hms(c(1.0, NA_real_, 11.0)))
  expect_equal(hms_test_vec + (1L:3L), new_hms(c(1.0, NA_real_, 13.0)))
  expect_equal(1L + hms_test_vec, new_hms(c(1.0, NA_real_, 11.0)))
  expect_equal((1L:3L) + hms_test_vec, new_hms(c(1.0, NA_real_, 13.0)))

  expect_equal(hms_test_vec - 1L, new_hms(c(-1.0, NA_real_, 9.0)))
  expect_equal(hms_test_vec - (1L:3L), new_hms(c(-1.0, NA_real_, 7.0)))
  expect_equal(1L - hms_test_vec, new_hms(c(1.0, NA_real_, -9.0)))
  expect_equal((1L:3L) - hms_test_vec, new_hms(c(1.0, NA_real_, -7.0)))

  expect_equal(hms_test_vec * 2L, new_hms(c(0.0, NA_real_, 20.0)))
  expect_equal(hms_test_vec * (1L:3L), new_hms(c(0.0, NA_real_, 30.0)))
  expect_equal(2L * hms_test_vec, new_hms(c(0.0, NA_real_, 20.0)))
  expect_equal((1L:3L) * hms_test_vec, new_hms(c(0.0, NA_real_, 30.0)))

  expect_equal(hms_test_vec / 2L, new_hms(c(0.0, NA_real_, 5.0)))
  expect_equal(hms_test_vec / c(1L, 2L, 4L), new_hms(c(0.0, NA_real_, 2.5)))
  expect_error(1L / hms_test_vec, "second argument of / cannot be a \"difftime\" object")

  # hms {+-*/} numeric
  expect_equal(hms_test_vec + 1.0, new_hms(c(1.0, NA_real_, 11.0)))
  expect_equal(hms_test_vec + (1.0:3.0), new_hms(c(1.0, NA_real_, 13.0)))
  expect_equal(1.0 + hms_test_vec, new_hms(c(1.0, NA_real_, 11.0)))
  expect_equal((1.0:3.0) + hms_test_vec, new_hms(c(1.0, NA_real_, 13.0)))

  expect_equal(hms_test_vec - 1.0, new_hms(c(-1.0, NA_real_, 9.0)))
  expect_equal(hms_test_vec - (1.0:3.0), new_hms(c(-1.0, NA_real_, 7.0)))
  expect_equal(1.0 - hms_test_vec, new_hms(c(1.0, NA_real_, -9.0)))
  expect_equal((1.0:3.0) - hms_test_vec, new_hms(c(1.0, NA_real_, -7.0)))

  expect_equal(hms_test_vec * 2.0, new_hms(c(0.0, NA_real_, 20.0)))
  expect_equal(hms_test_vec * (1.0:3.0), new_hms(c(0.0, NA_real_, 30.0)))
  expect_equal(2.0 * hms_test_vec, new_hms(c(0.0, NA_real_, 20.0)))
  expect_equal((1.0:3.0) * hms_test_vec, new_hms(c(0.0, NA_real_, 30.0)))

  expect_equal(hms_test_vec / 2.0, new_hms(c(0.0, NA_real_, 5.0)))
  expect_equal(hms_test_vec / c(1.0, 2.0, 4.0), new_hms(c(0.0, NA_real_, 2.5)))
  expect_error(1.0 / hms_test_vec, "second argument of / cannot be a \"difftime\" object")

  # hms {+-} Date
  # 86400.0 secs = 24 hours
  hms_test_vec <- new_hms(86400.0 * c(1.0, NA_real_, 10.0))
  difftime_test_vec <- as.difftime(86400.0 * c(1.0, NA_real_, 10.0), units = "secs")
  date_vec <- as.Date(c("1970-01-01", NA_character_, "2023-08-21"))

  expect_equal(hms_test_vec + date_vec, difftime_test_vec + date_vec)
  expect_equal(date_vec + hms_test_vec, date_vec + difftime_test_vec)

  # Can't reproduce this warning because we forced compatibility
  hms_result <- hms_test_vec - date_vec
  expect_warning({
    difftime_result <- as_hms(difftime_test_vec - date_vec)
  }, regexp = "Incompatible methods \\(\"Ops.difftime\", \"-.Date\") for \"-\"")
  expect_equal(hms_result, difftime_result)

  expect_equal(date_vec - hms_test_vec, date_vec - difftime_test_vec)
})
