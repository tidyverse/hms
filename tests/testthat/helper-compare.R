expect_hms_equal <- function(x, y) {
  expect_is(x, "hms")
  expect_is(y, "hms")
  expect_equal(as.numeric(x), as.numeric(y))
}
