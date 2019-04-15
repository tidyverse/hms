context("combine")

test_that("combination keeps class and order", {
  expect_identical(c(hms(1), hms(2)), hms(1:2))
})

test_that("combination errs if not supported", {
  expect_error(c(hms(1), factor(2)))
})

test_that("combination coerces to hms", {
  # Deprecated in v0.5.0
  scoped_lifecycle_silence()

  expect_identical(c(hms(1), 2), hms(1:2))
  if (getRversion() < "3.3") skip("Only for R >= 3.3")
  expect_identical(c(hms(1), "00:00:02"), hms(1:2))
  expect_identical(vec_c("00:00:01", hms(2)), hms(1:2))
  expect_identical(c(hms(1), 2L), hms(1:2))
  expect_identical(vec_c(1L, hms(2)), hms(1:2))

  expect_identical(c(hms(1), new_duration(2)), hms(1:2))
  expect_identical(vec_c(new_duration(1), hms(2)), hms(1:2))
})


# In R base,`c(as.difftime("20:00:00"), NA)` fails
test_that("composition with NA works", {
  expect_identical(
    c(hms(1), NA),
    hms(c(1, NA))
  )
})
