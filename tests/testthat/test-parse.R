context("parse")

test_that("parse_hms", {
  expect_equal(parse_hms("12:34:56"), hms(56, 34, 12))
  expect_equal(parse_hms("12:34:56.789"), hms(56.789, 34, 12))
  expect_equal(parse_hms(NA), hms(NA))
  expect_equal(parse_hms(c("12:34:56", NA)), as.hms(c(hms(56, 34, 12), hms(NA))))
})

test_that("parse_hm", {
  expect_equal(parse_hms("12:34"), hms(0, 34, 12))
  expect_equal(parse_hms("00:00"), hms(0))
  expect_equal(parse_hms(c("12:34", NA)), as.hms(c(hms(0, 34, 12), hms(NA))))
})


test_that("decimal point", {
  expect_equal(parse_hms("12:34:56.789"), hms(56.789, 34, 12))
  expect_equal(parse_hms("12:34:56.000"), hms(56, 34, 12))
  #expect_equal(parse_hms("12:34:56."), hms(56, 34, 12))
})

test_that("negative time", {
  expect_equal(parse_hms("-12:34:56.789"), -hms(56.789, 34, 12))
  expect_equal(parse_hms("- 12:34:56.000"), -hms(56, 34, 12))
  expect_equal(parse_hms("-  12:34:56"), -hms(56, 34, 12))
  expect_equal(parse_hms("- 1d"), -hms(days = 1))
  expect_equal(parse_hms("- 0.5d"), -hms(days = 1/2))
  expect_equal(parse_hms("-1d 00:00:01"), -hms(1, hours=0, minutes=0, days = 1))
  #  hms(1,  days = 0.5) fails!
})


test_that("day only", {
  expect_equal(parse_hms("12d"), hms(days=12))
  expect_equal(parse_hms("-12d"), hms(days=-12))
  expect_equal(parse_hms("-0.01d"), hms(days=-0.01))
  expect_equal(parse_hms("-0.01 d"), hms(days=-0.01))
  expect_equal(parse_hms("- 0.01 d"), hms(days=-0.01))
  expect_equal(parse_hms("- 0.01 d "), hms(days=-0.01))
})



test_that("problems attribute is returned", {

  time_str <- c("12:13:14", "a")
  out <- parse_hms(time_str)
  probs <- attr(out, "problems")
  expect_false(is.null(probs))
  expect_equal(as.character(probs$detail), "Invalid time format!")

  time_str <- c("12:13:14", "0.5d 12:23:10")
  out <- parse_hms(time_str)
  probs <- attr(out, "problems")
  expect_false(is.null(probs))
  expect_equal(as.character(probs$detail), "Cannot use fractional days AND hours!")


  time_str <- c("12:13:14", "1d 24:00:00")
  out <- parse_hms(time_str)
  probs <- attr(out, "problems")
  expect_false(is.null(probs))
  expect_equal(as.character(probs$detail), "Overflow in number of hours. Cannot add more than 23h and use days!")

  time_str <- c("12:13:14", "12:60:10")
  out <- parse_hms(time_str)
  probs <- attr(out, "problems")
  expect_false(is.null(probs))
  expect_equal(as.character(probs$detail), "Overflow in number of minutes. Cannot add more than 59min!")


  time_str <- c("12:13:14", "12:00:60")
  out <- parse_hms(time_str)
  probs <- attr(out, "problems")
  expect_false(is.null(probs))
  expect_equal(as.character(probs$detail), "Overflow in number of seconds. Cannot add more than 59s!")

  time_str <- c("12:13:14", "1d 11:102:00")
  out <- parse_hms(time_str)
  probs <- attr(out, "problems")
  expect_false(is.null(probs))
  expect_equal(as.character(probs$detail), "Invalid time format!")

})

