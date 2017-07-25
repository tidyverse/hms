context("combine")

test_that("combination keeps class and order", {
  expect_identical(c(hms(1),hms(2)), hms(1:2))
})

test_that("combination coerces to hms", {
  expect_identical(c(hms(1),2), hms(1:2))
  expect_identical(c(hms(1),"00:00:02"), hms(1:2))
})


# this does not work in base R: `c(as.difftime("20:00:00"), NA)`
# so not sure whether we want it to work in hms...
# test_that("composition with NA works", {
#   expect_identical(c(hms(1),NA), hms(c(1, NA)))
# })



