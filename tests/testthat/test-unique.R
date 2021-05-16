test_that("unique", {
  expect_identical(unique(new_hms(numeric(0))), new_hms(numeric(0)))
  expect_identical(unique(new_hms(NA_real_)), new_hms(NA_real_))
  expect_identical(unique(new_hms(101)), new_hms(101))
  expect_identical(unique(new_hms(c(101, 101, 99, 101))), new_hms(c(101, 99)))
  expect_identical(unique(new_hms(c(101, NA_real_, 101, 99, 101))), new_hms(c(101, NA_real_, 99)))
})
