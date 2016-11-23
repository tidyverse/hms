# hms 0.3 (2016-11-22)

- Fix `lubridate` test for compatibility with 1.6.0 (#23, @vspinu).
- NA values are formatted as `NA` (#22).


# hms 0.2 (2016-06-17)

Minor fixes and improvements.

- Subsetting keeps `hms` class (#16).
- `format.hms()` right-justifies the output by padding with spaces from the left, `as.character.hms()` remains unchanged.
- Times larger than 24 hours or with split seconds are now formatted correctly (#12, #13).
- Sub-second part is printed with up to six digits, for even smaller values trailing zeros are shown (#17).


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
