# seq.hms works

    Code
      seq(hms(1), 1)
    Condition
      Error in `seq()`:
      ! `to` isn't of class `hms` (current class: `numeric`).
    Code
      seq(hms(10), hms(1), by = hms(1))
    Condition
      Error in `seq.default()`:
      ! wrong sign in 'by' argument
    Code
      seq(hms(1), hms(10), by = hms(-1))
    Condition
      Error in `seq.default()`:
      ! wrong sign in 'by' argument
    Code
      seq(hms(1), hms(10), by = "test")
    Condition
      Error in `seq()`:
      ! `by` isn't of class `hms` (current class: `character`).
    Code
      seq(hms(1), hms(10), by = hms())
    Condition
      Error in `seq.default()`:
      ! 'by' must be of length 1
    Code
      seq(hms(1), hms(10), by = hms(0))
    Condition
      Error in `seq.default()`:
      ! invalid '(to - from)/by'

---

    Code
      seq(hms(1), hms(10), along.with = 1:2)
    Output
      00:00:01
      00:00:10
    Code
      seq(hms(1), hms(10), length.out = 2)
    Output
      00:00:01
      00:00:10
    Code
      seq(hms(1), hms(10))
    Output
      00:00:01
      00:00:02
      00:00:03
      00:00:04
      00:00:05
      00:00:06
      00:00:07
      00:00:08
      00:00:09
      00:00:10
    Code
      seq(hms(1), hms(10), by = hms(1))
    Output
      00:00:01
      00:00:02
      00:00:03
      00:00:04
      00:00:05
      00:00:06
      00:00:07
      00:00:08
      00:00:09
      00:00:10
    Code
      seq(hms(10), hms(1))
    Output
      00:00:10
      00:00:09
      00:00:08
      00:00:07
      00:00:06
      00:00:05
      00:00:04
      00:00:03
      00:00:02
      00:00:01
    Code
      seq(hms(10), hms(1), by = hms(-1))
    Output
      00:00:10
      00:00:09
      00:00:08
      00:00:07
      00:00:06
      00:00:05
      00:00:04
      00:00:03
      00:00:02
      00:00:01

