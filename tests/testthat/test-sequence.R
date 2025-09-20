test_that("seq.hms works", {
  expect_snapshot(
    error = TRUE,
    {
      seq(hms(1), 1)
      seq(hms(4), hms(1), by = hms(1))
      seq(hms(1), hms(4), by = hms(-1))
      seq(hms(1), hms(4), by = "test")
      seq(hms(1), hms(4), by = hms())
      seq(hms(1), hms(4), by = hms(0))
    }
  )

  expect_snapshot({
    seq(hms(1), hms(4), along.with = 1:2)
    seq(hms(1), hms(4), length.out = 2)

    seq(hms(1), hms(4))
    seq(hms(1), hms(4), by = hms(1))

    seq(hms(4), hms(1))
    seq(hms(4), hms(1), by = hms(-1))
  })
})
