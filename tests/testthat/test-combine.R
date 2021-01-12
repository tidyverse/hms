test_that("combination keeps class and order", {
  expect_identical(c(hms(1), hms(2)), hms(1:2))
})

test_that("combination errs if not supported", {
  expect_error(c(hms(1), factor(2)))
})

test_that("combination coerces to hms", {
  expect_identical(c(hms(1), hms(2)), hms(1:2))
  if (getRversion() < "3.3") skip("Only for R >= 3.3")

  expect_identical(c(hms(1), new_duration(2)), hms(1:2))
  expect_identical(vec_c(new_duration(1), hms(2)), hms(1:2))
})


# In R base,`c(as.difftime("20:00:00"), NA)` fails
test_that("composition with NA works", {
  expect_identical(
    c(hms(1), NA),
    hms(c(1, NA))
  )

  expect_identical(
    vec_c(hms(1), NA),
    hms(vec_c(1, NA))
  )

  h <- hms(1)
  expect_equal(vec_ptype2(h, NA), vec_ptype(h))
  expect_equal(vec_ptype2(NA, h), vec_ptype(h))
})
