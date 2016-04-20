context("output")

test_that("output", {
  expect_identical(format(hms(1:2, minutes = c(0, 0), hours = 3:4)),
                   c("03:00:01", "04:00:02"))
  expect_identical(format(hms(minutes = 1:-1)),
                   c("00:01:00", "00:00:00", "-00:01:00"))
  expect_output(
    expect_identical(print(hms(minutes = 1:2, hours = 3:4)),
                     hms(minutes = 1:2, hours = 3:4)),
    "03:01:00\n04:02:00", fixed = TRUE)
})
