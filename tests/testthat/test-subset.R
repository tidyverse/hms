context("subset")

test_that("range subsetting keeps class", {
  expect_identical(hms(1:3)[2], hms(2))
  expect_identical(hms(1:3)[2:3], hms(2:3))
})

test_that("range updating keeps class", {
  skip_if(packageVersion("vctrs") <= "0.1.0")

  x <- hms(1:3)
  x[2] <- hms(4)
  expect_identical(x, hms(c(1,4,3)))
  x <- hms(1:4)
  x[2:3] <- hms(5:6)
  expect_identical(x, hms(c(1,5,6,4)))
})

test_that("range updating warns if lossy cast", {
  skip_if(packageVersion("vctrs") <= "0.1.0")

  x <- hms(1:3)

  # r-lib/testthat#783
  expect_warning(x[2] <- "a")
})

test_that("index subsetting keeps class", {
  expect_identical(hms(1:3)[[2]], hms(2))
})

test_that("index updating keeps class", {
  x <- hms(1:3)
  x[[2]] <- 4
  expect_identical(x, hms(c(1,4,3)))
})
