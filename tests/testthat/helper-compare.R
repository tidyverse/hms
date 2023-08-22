expect_hms_equal <- function(x, y) {
  expect_s3_class(x, "hms")
  expect_s3_class(y, "hms")
  expect_equal(as.numeric(x), as.numeric(y))
}
