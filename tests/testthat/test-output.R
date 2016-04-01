context("output")

test_that("output", {
  expect_identical(format(hms(1:2, hours = 3:4)),
                   c("03:00:01", "04:00:02"))
  expect_output(
    expect_identical(print(hms(minutes = 1:2, hours = 3:4)),
                     hms(minutes = 1:2, hours = 3:4)),
    "03:01:00\n04:02:00", fixed = TRUE)
})
