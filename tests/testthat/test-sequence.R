test_that("seq.hms works", {
  expect_snapshot(
    error = TRUE, {
      seq(hms(1), 1)
      seq(hms(10), hms(1), by = hms(1))
      seq(hms(1), hms(10), by = hms(-1))
      seq(hms(1), hms(10), by = "test")
      seq(hms(1), hms(10), by = hms())
      seq(hms(1), hms(10), by = hms(0))
  })

  expect_snapshot({
      seq(hms(1), hms(10), along.with = 1:2)
      seq(hms(1), hms(10), length.out = 2)
  
      seq(hms(1), hms(10))
      seq(hms(1), hms(10), by = hms(1))
  
      seq(hms(10), hms(1))
      seq(hms(10), hms(1), by = hms(-1))
  })
})
