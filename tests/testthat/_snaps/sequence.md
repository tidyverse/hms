# seq.hms works

    Code
      seq(hms(1), 1)
    Condition
      Error in `seq()`:
      ! `to` isn't of class `hms` (current class: `numeric`).
    Code
      seq(hms(4), hms(1), by = hms(1))
    Condition
      Error in `seq.default()`:
      ! wrong sign in 'by' argument
    Code
      seq(hms(1), hms(4), by = hms(-1))
    Condition
      Error in `seq.default()`:
      ! wrong sign in 'by' argument
    Code
      seq(hms(1), hms(4), by = "test")
    Condition
      Error in `seq()`:
      ! `by` isn't of class `hms` or `difftime` (current class: `character`).
    Code
      seq(hms(1), hms(4), by = hms())
    Condition
      Error in `seq.default()`:
      ! 'by' must be of length 1
    Code
      seq(hms(1), hms(4), by = hms(0))
    Condition
      Error in `seq.default()`:
      ! invalid '(to - from)/by'

---

    Code
      seq(hms(1), hms(4), along.with = 1:2)
    Output
      00:00:01
      00:00:04
    Code
      seq(hms(1), hms(4), length.out = 2)
    Output
      00:00:01
      00:00:04
    Code
      seq(hms(1), hms(4))
    Output
      00:00:01
      00:00:02
      00:00:03
      00:00:04
    Code
      seq(hms(1), hms(4), by = hms(1))
    Output
      00:00:01
      00:00:02
      00:00:03
      00:00:04
    Code
      seq(hms(4), hms(1))
    Output
      00:00:04
      00:00:03
      00:00:02
      00:00:01
    Code
      seq(hms(4), hms(1), by = hms(-1))
    Output
      00:00:04
      00:00:03
      00:00:02
      00:00:01

