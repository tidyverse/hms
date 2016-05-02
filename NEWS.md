# hms 0.1 (2016-04-30)

First CRAN release.

- Values are stored as a numeric vector that contains the number of seconds
  since midnight.
    - Inherits from `difftime` class.
    - Updating units is a no-op, anything different from `"secs"` issues a warning.
- Supports construction from time values, coercion to and from various data
  types, and formatting.
    - Conversion from numeric treats input as seconds.
    - Negative times are formatted with a leading `-`.
- Can be used as a regular column in a data frame.
- Full test coverage.
    - Test for arithmetic with `Date`, `POSIXt` and `hms` classes.
    - Test basic compatibility with `lubridate` package (#5).
- Interface:
    - `hms()` (with rigorous argument checks)
    - `as.hms()` for `character`, `numeric`, `POSIXct` and `POSIXlt`
    - `as.xxx.hms()` for `character`, `numeric` (implicitly), `POSIXct` and
      `POSIXlt`
    - `is.hms()`
    - `as.data.frame.hms()` (forwards to `as.data.frame.difftime()`)
    - `format.hms()`
    - `print.hms()` (returns unchanged input invisibly)
