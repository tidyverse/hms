context("output")

test_that("output", {
  expect_identical(format(hms(1:2, minutes = c(0, 0), hours = 3:4)),
                   c("03:00:01", "04:00:02"))
  expect_identical(format(hms(minutes = 1:-1)),
                   c(" 00:01:00", " 00:00:00", "-00:01:00"))
  expect_output(
    expect_identical(print(hms(minutes = 1:2, hours = 3:4)),
                     hms(minutes = 1:2, hours = 3:4)),
    "03:01:00\n04:02:00", fixed = TRUE)
})

test_that("beyond 24 hours", {
  expect_identical(format(hms(hours = 23:25)),
                   c("23:00:00", "24:00:00", "25:00:00"))
  expect_identical(format(hms(hours = 99:101)),
                   c(" 99:00:00", "100:00:00", "101:00:00"))
  expect_identical(format(hms(hours = c(-99, 100))),
                   c("-99:00:00", "100:00:00"))
  expect_identical(format(hms(hours = c(-100, 99))),
                   c("-100:00:00", "  99:00:00"))
})
