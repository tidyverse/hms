# Changelog

## hms 1.1.4.9000

### fledge

- CRAN release v1.1.4
  ([\#185](https://github.com/tidyverse/hms/issues/185)).

## hms 1.1.4

CRAN release: 2025-10-17

### Features

- Sub-second value parsing accurately
  ([@eitsupi](https://github.com/eitsupi),
  [\#127](https://github.com/tidyverse/hms/issues/127),
  [\#128](https://github.com/tidyverse/hms/issues/128)).

- [`is.hms()`](https://hms.tidyverse.org/dev/reference/Deprecated.md)
  and
  [`as.hms()`](https://hms.tidyverse.org/dev/reference/Deprecated.md)
  now warn even when called indirectly
  ([@moodymudskipper](https://github.com/moodymudskipper),
  [\#121](https://github.com/tidyverse/hms/issues/121),
  [\#163](https://github.com/tidyverse/hms/issues/163)).

- Implement
  [`ceiling_hms()`](https://hms.tidyverse.org/dev/reference/round_hms.md)
  and
  [`floor_hms()`](https://hms.tidyverse.org/dev/reference/round_hms.md)
  ([@moodymudskipper](https://github.com/moodymudskipper),
  [\#118](https://github.com/tidyverse/hms/issues/118),
  [\#160](https://github.com/tidyverse/hms/issues/160)).

### Bug fixes

- Parsing now holds the date part fixed, removing unlikely errors during
  clock wraparound.

### Chore

- Spring cleaning ([@schochastics](https://github.com/schochastics),
  [\#174](https://github.com/tidyverse/hms/issues/174),
  [\#175](https://github.com/tidyverse/hms/issues/175)).

- Use rlang instead of ellipsis
  ([\#106](https://github.com/tidyverse/hms/issues/106)).

## hms 1.1.3

CRAN release: 2023-03-21

### Bug fixes

- Fix method consistency, checked by R-devel.

### Internal

- Use rlang instead of ellipsis
  ([\#106](https://github.com/tidyverse/hms/issues/106)).

## hms 1.1.2

CRAN release: 2022-08-19

- Re-rendered documentation for compatibility with R-devel.

## hms 1.1.1

CRAN release: 2021-09-26

- Avoid blanket import for lifecycle package for compatibility with
  upcoming rlang.
- Establish compatibility with development version of testthat
  ([\#101](https://github.com/tidyverse/hms/issues/101),
  [@lionel-](https://github.com/lionel-)).

## hms 1.1.0

CRAN release: 2021-05-17

### Breaking changes

- `"hms"` objects no longer have a common type with `character` and
  `numeric`. Combining such values previously threw a warning, now
  throws an error ([\#94](https://github.com/tidyverse/hms/issues/94)).
- `vec_cast()` and
  [`as_hms()`](https://hms.tidyverse.org/dev/reference/hms.md) throw
  error instead of a warning if input can’t be parsed
  ([\#68](https://github.com/tidyverse/hms/issues/68)).

### Features

- New `unique.hms()` method
  ([\#98](https://github.com/tidyverse/hms/issues/98),
  [@joethorley](https://github.com/joethorley)).
- [`as_hms()`](https://hms.tidyverse.org/dev/reference/hms.md) is a
  generic again ([\#81](https://github.com/tidyverse/hms/issues/81)).

### Internal

- Avoid `LazyData` in `DESCRIPTION`.
- Bump required versions of ellipsis and vctrs to avoid warning during
  package load.
- Using lifecycle package
  ([\#94](https://github.com/tidyverse/hms/issues/94)).

## hms 1.0.0

CRAN release: 2021-01-13

### Life cycle

- hms is now marked as “stable”.

### Breaking changes

- `"hms"` objects no longer have a common type with `character` and
  `numeric`. Combining such values previously threw a warning, now
  throws an error ([\#94](https://github.com/tidyverse/hms/issues/94)).
- `vec_cast()` and
  [`as_hms()`](https://hms.tidyverse.org/dev/reference/hms.md) now throw
  error instead of a warning if input can’t be parsed
  ([\#68](https://github.com/tidyverse/hms/issues/68)).

### Features

- [`as_hms()`](https://hms.tidyverse.org/dev/reference/hms.md) is a
  generic again ([\#81](https://github.com/tidyverse/hms/issues/81)).
- [`round_hms()`](https://hms.tidyverse.org/dev/reference/round_hms.md)
  and
  [`trunc_hms()`](https://hms.tidyverse.org/dev/reference/round_hms.md)
  gain `digits` argument
  ([\#78](https://github.com/tidyverse/hms/issues/78),
  [@hglanz](https://github.com/hglanz)).

### Bug fixes

- [`as_hms()`](https://hms.tidyverse.org/dev/reference/hms.md) and
  `vec_cast()` now correctly treat objects of class `"difftime"` with
  `integer` mode ([\#84](https://github.com/tidyverse/hms/issues/84)).

### Internal

- Using lifecycle package
  ([\#94](https://github.com/tidyverse/hms/issues/94)).
- hms has been re-licensed as MIT
  ([\#86](https://github.com/tidyverse/hms/issues/86)).

## hms 0.5.3

CRAN release: 2020-01-08

- Use `vec_default_ptype2()`, remove `vec_ptype2.hms.unspecified()`
  ([\#80](https://github.com/tidyverse/hms/issues/80),
  [@romainfrancois](https://github.com/romainfrancois)).
- `vec_ptype2.hms.default()` forwards to `vec_default_ptype2()` for
  compatibility with vctrs 0.2.1.
- Remove `as.data.frame.hms()`, handeld by vctrs.

## hms 0.5.2.9000

- Internal changes only.

## hms 0.5.2

CRAN release: 2019-10-30

- Work around parsing error that occurs on DST changeover dates
  (<https://bugs.r-project.org/bugzilla/show_bug.cgi?id=16764>).

## hms 0.5.1

CRAN release: 2019-08-23

- Lossy casts from `character` vectors to `hms` now also trigger a
  warning if the cast succeeds in the first element of the vector but
  fails for other elements.

## hms 0.5.0

CRAN release: 2019-07-09

### Breaking changes

- Now based on vctrs \>= 0.2.0
  ([\#61](https://github.com/tidyverse/hms/issues/61)). This adds
  support for `vec_cast()` and `vec_ptype2()`. Some operations (such as
  subset assignment) are now stricter. The
  [`new_hms()`](https://hms.tidyverse.org/dev/reference/hms.md)
  constructor permits safe construction of `hms` objects from a numeric
  vector.

- The new [`is_hms()`](https://hms.tidyverse.org/dev/reference/hms.md)
  deprecates the existing
  [`is.hms()`](https://hms.tidyverse.org/dev/reference/Deprecated.md).
  [`as.hms()`](https://hms.tidyverse.org/dev/reference/Deprecated.md) is
  deprecated in favor of `vec_cast()` or the new
  [`as_hms()`](https://hms.tidyverse.org/dev/reference/hms.md) (which is
  just a thin wrapper around `vec_cast()`).

### Printing

- Always show seconds in a pillar if they are different from zero
  ([\#54](https://github.com/tidyverse/hms/issues/54)).

- Values with nonzero hours, seconds and split-seconds are now displayed
  correctly in tibbles
  ([\#56](https://github.com/tidyverse/hms/issues/56)), even with a very
  small distance to the full second
  ([\#64](https://github.com/tidyverse/hms/issues/64)).

### Internal

- Don’t test colored output on CRAN.
- Correct reference link on r4ds
  ([\#58](https://github.com/tidyverse/hms/issues/58),
  [@evanhaldane](https://github.com/evanhaldane)).

## hms 0.4.2

CRAN release: 2018-03-10

- Adapted tests to pillar 1.2.1.

## hms 0.4.1

CRAN release: 2018-01-24

- Preserve `NA` when converting to `character`
  ([\#51](https://github.com/tidyverse/hms/issues/51),
  [@jeroen](https://github.com/jeroen)).
- Adapted tests to pillar 1.1.0.

## hms 0.4.0

CRAN release: 2017-11-22

### Breaking changes

- [`as.hms.POSIXt()`](https://hms.tidyverse.org/dev/reference/Deprecated.md)
  now defaults to the current time zone, the previous default was
  `"UTC"` and can be restored by calling
  `pkgconfig::set_config("hms::default_tz", "UTC")`.

### New features

- Pillar support, will display `hms` columns in tibbles in color on
  terminals that support it
  ([\#43](https://github.com/tidyverse/hms/issues/43)).
- New
  [`round_hms()`](https://hms.tidyverse.org/dev/reference/round_hms.md)
  and
  [`trunc_hms()`](https://hms.tidyverse.org/dev/reference/round_hms.md)
  for rounding or truncating to a given multiple of seconds
  ([\#31](https://github.com/tidyverse/hms/issues/31)).
- New
  [`parse_hms()`](https://hms.tidyverse.org/dev/reference/parse_hms.md)
  and
  [`parse_hm()`](https://hms.tidyverse.org/dev/reference/parse_hms.md)
  to parse strings in “HH:MM:SS” and “HH:MM” formats
  ([\#30](https://github.com/tidyverse/hms/issues/30)).
- [`as.hms.POSIXt()`](https://hms.tidyverse.org/dev/reference/Deprecated.md)
  gains `tz` argument, default `"UTC"`
  ([\#28](https://github.com/tidyverse/hms/issues/28)).
- `as.hms.character()` and
  [`parse_hms()`](https://hms.tidyverse.org/dev/reference/parse_hms.md)
  accept fractional seconds
  ([\#33](https://github.com/tidyverse/hms/issues/33)).

### Bug fixes

- [`hms()`](https://hms.tidyverse.org/dev/reference/hms.md) now works
  correctly if all four components (days, hours, minutes, seconds) are
  passed ([\#49](https://github.com/tidyverse/hms/issues/49)).
- [`hms()`](https://hms.tidyverse.org/dev/reference/hms.md) creates a
  zero-length object of class `hms` that prints as `"hms()"`.
- `hms(integer())` and `as.hms(integer())` both work and are identical
  to [`hms()`](https://hms.tidyverse.org/dev/reference/hms.md).
- Values with durations of over 10000 hours are now printed correctly
  ([\#48](https://github.com/tidyverse/hms/issues/48)).
- [`c()`](https://rdrr.io/r/base/c.html) now returns a hms
  ([\#41](https://github.com/tidyverse/hms/issues/41),
  [@qgeissmann](https://github.com/qgeissmann)).

### Documentation and error messages

- Fix and enhance examples in
  [`?hms`](https://hms.tidyverse.org/dev/reference/hms.md).
- Documentation is in Markdown format now.
- Improved error message if calling
  [`hms()`](https://hms.tidyverse.org/dev/reference/hms.md) with a
  character argument
  ([\#29](https://github.com/tidyverse/hms/issues/29)).

## hms 0.3

CRAN release: 2016-11-22

- Fix `lubridate` test for compatibility with 1.6.0
  ([\#23](https://github.com/tidyverse/hms/issues/23),
  [@vspinu](https://github.com/vspinu)).
- NA values are formatted as `NA`
  ([\#22](https://github.com/tidyverse/hms/issues/22)).

## hms 0.2

CRAN release: 2016-06-17

Minor fixes and improvements.

- Subsetting keeps `hms` class
  ([\#16](https://github.com/tidyverse/hms/issues/16)).
- [`format.hms()`](https://hms.tidyverse.org/dev/reference/hms.md)
  right-justifies the output by padding with spaces from the left,
  [`as.character.hms()`](https://hms.tidyverse.org/dev/reference/hms.md)
  remains unchanged.
- Times larger than 24 hours or with split seconds are now formatted
  correctly ([\#12](https://github.com/tidyverse/hms/issues/12),
  [\#13](https://github.com/tidyverse/hms/issues/13)).
- Sub-second part is printed with up to six digits, for even smaller
  values trailing zeros are shown
  ([\#17](https://github.com/tidyverse/hms/issues/17)).

## hms 0.1

CRAN release: 2016-05-02

First CRAN release.

- Values are stored as a numeric vector that contains the number of
  seconds since midnight.
  - Inherits from `difftime` class.
  - Updating units is a no-op, anything different from `"secs"` issues a
    warning.
- Supports construction from time values, coercion to and from various
  data types, and formatting.
  - Conversion from numeric treats input as seconds.
  - Negative times are formatted with a leading `-`.
- Can be used as a regular column in a data frame.
- Full test coverage.
  - Test for arithmetic with `Date`, `POSIXt` and `hms` classes.
  - Test basic compatibility with `lubridate` package
    ([\#5](https://github.com/tidyverse/hms/issues/5)).
- Interface:
  - [`hms()`](https://hms.tidyverse.org/dev/reference/hms.md) (with
    rigorous argument checks)
  - [`as.hms()`](https://hms.tidyverse.org/dev/reference/Deprecated.md)
    for `character`, `numeric`, `POSIXct` and `POSIXlt`
  - `as.xxx.hms()` for `character`, `numeric` (implicitly), `POSIXct`
    and `POSIXlt`
  - [`is.hms()`](https://hms.tidyverse.org/dev/reference/Deprecated.md)
  - `as.data.frame.hms()` (forwards to
    [`as.data.frame.difftime()`](https://rdrr.io/r/base/base-deprecated.html))
  - [`format.hms()`](https://hms.tidyverse.org/dev/reference/hms.md)
  - [`print.hms()`](https://hms.tidyverse.org/dev/reference/hms.md)
    (returns unchanged input invisibly)
