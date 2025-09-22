<!-- NEWS.md is maintained by https://fledge.cynkra.com, contributors should not edit this file -->

# hms 1.1.3.9016

## Chore

- Auto-update from GitHub Actions (#182).

- Cynkra spring cleaning (@schochastics, #174, #175).


# hms 1.1.3.9015

## Continuous integration

- Fix \[ci skip\].

- Allow dispatch.

- Allow dispatch.

- Use r-universe for installation of dev dependencies.


# hms 1.1.3.9014

## Features

- `is.hms()` and `as.hms()` now warn even when called indirectly (@moodymudskipper, #121, #163).

- Implement `ceiling_hms()` and `floor_hms()` (@moodymudskipper, #118, #160).

## Chore

- Auto-update from GitHub Actions (#178).

- IDE.

## Continuous integration

- Add Copilot instructions.

- Bump Ubuntu version for dev workflow, run if changed.

- Use reviewdog for external PRs (#179).

- Cleanup and fix macOS (#177).

- Format with air, check detritus, better handling of `extra-packages` (#176).

- Enhance permissions for workflow (#172).

- Permissions, better tests for missing suggests, lints (#171).

- Only fail covr builds if token is given (#170).

- Always use `_R_CHECK_FORCE_SUGGESTS_=false` (#169).

- Correct installation of xml2 (#168).

- Explain (#167).

- Add xml2 for covr, print testthat results (#166).

- Sync (#165).


# hms 1.1.3.9013

## Continuous integration

- Avoid failure in fledge workflow if no changes (#156).


# hms 1.1.3.9012

## Continuous integration

- Fetch tags for fledge workflow to avoid unnecessary NEWS entries (#154).


# hms 1.1.3.9011

## Bug fixes

- Sub-second value parsing accurately (@eitsupi, #127, #128).

## Continuous integration

- Use larger retry count for lock-threads workflow (#152).

- Ignore errors when removing pkg-config on macOS (#142).

- Explicit permissions (#140).

- Use styler from main branch (#138).

- Need to install R on Ubuntu 24.04 (#136).

- Use Ubuntu 24.04 and styler PR (#134).

- Correctly detect branch protection (#130).

## Uncategorized

- PLACEHOLDER https://github.com/tidyverse/hms/pull/16 (#16).


# hms 1.1.3.9010

## Continuous integration

  - Use stable pak (#129).


# hms 1.1.3.9009

## Continuous integration

  - Trigger run (#126).
    
      - ci: Trigger run
    
      - ci: Latest changes


# hms 1.1.3.9008

## Continuous integration

  - Trigger run (#124).

  - Use pkgdown branch (#123).
    
      - ci: Use pkgdown branch
    
      - ci: Updates from duckdb


# hms 1.1.3.9007

## Continuous integration

  - Install via R CMD INSTALL ., not pak (#122).
    
      - ci: Install via R CMD INSTALL ., not pak
    
      - ci: Bump version of upload-artifact action


# hms 1.1.3.9006

## Chore

  - Auto-update from GitHub Actions.
    
    Run: https://github.com/tidyverse/hms/actions/runs/10425483161

  - Auto-update from GitHub Actions.
    
    Run: https://github.com/tidyverse/hms/actions/runs/10200113283

  - Auto-update from GitHub Actions.
    
    Run: https://github.com/tidyverse/hms/actions/runs/9728444063

  - Auto-update from GitHub Actions.
    
    Run: https://github.com/tidyverse/hms/actions/runs/9691617778

## Continuous integration

  - Install local package for pkgdown builds.

  - Improve support for protected branches with fledge.

  - Improve support for protected branches, without fledge.

  - Sync with latest developments.

  - Use v2 instead of master.

  - Inline action.

  - Use dev roxygen2 and decor.

  - Fix on Windows, tweak lock workflow.

  - Avoid checking bashisms on Windows.

  - Better commit message.

  - Bump versions, better default, consume custom matrix.

  - Recent updates.


# hms 1.1.3.9005

- Internal changes only.


# hms 1.1.3.9004

- Internal changes only.


# hms 1.1.3.9003

- Internal changes only.


# hms 1.1.3.9002

- Merged cran-1.1.3 into main.


# hms 1.1.3.9001

- Internal changes only.


# hms 1.1.3.9000

## Bug fixes

- Fix method consistency, checked by R-devel.

## Chore

- Use rlang instead of ellipsis (#106).


# hms 1.1.3

## Bug fixes

- Fix method consistency, checked by R-devel.

## Internal

- Use rlang instead of ellipsis (#106).


# hms 1.1.2

- Re-rendered documentation for compatibility with R-devel.


# hms 1.1.1

- Avoid blanket import for lifecycle package for compatibility with upcoming rlang.
- Establish compatibility with development version of testthat (#101, @lionel-).


# hms 1.1.0

## Breaking changes

- `"hms"` objects no longer have a common type with `character` and `numeric`. Combining such values previously threw a warning, now throws an error (#94).
- `vec_cast()` and `as_hms()` throw error instead of a warning if input can't be parsed (#68).

## Features

- New `unique.hms()` method (#98, @joethorley).
- `as_hms()` is a generic again (#81).

## Internal

- Avoid `LazyData` in `DESCRIPTION`.
- Bump required versions of ellipsis and vctrs to avoid warning during package load.
- Using lifecycle package (#94).


# hms 1.0.0

## Life cycle

- hms is now marked as "stable".

## Breaking changes

- `"hms"` objects no longer have a common type with `character` and `numeric`. Combining such values previously threw a warning, now throws an error (#94).
- `vec_cast()` and `as_hms()` now throw error instead of a warning if input can't be parsed (#68).

## Features

- `as_hms()` is a generic again (#81).
- `round_hms()` and `trunc_hms()` gain `digits` argument (#78, @hglanz).

## Bug fixes

- `as_hms()` and `vec_cast()` now correctly treat objects of class `"difftime"` with `integer` mode (#84).

## Internal

- Using lifecycle package (#94).
- hms has been re-licensed as MIT (#86).


# hms 0.5.3

- Use `vec_default_ptype2()`, remove `vec_ptype2.hms.unspecified()` (#80, @romainfrancois).
- `vec_ptype2.hms.default()` forwards to `vec_default_ptype2()` for compatibility with vctrs 0.2.1.
- Remove `as.data.frame.hms()`, handeld by vctrs.


# hms 0.5.2.9000

- Internal changes only.


# hms 0.5.2

- Work around parsing error that occurs on DST changeover dates (https://bugs.r-project.org/bugzilla/show_bug.cgi?id=16764).


# hms 0.5.1

- Lossy casts from `character` vectors to `hms` now also trigger a warning if the cast succeeds in the first element of the vector but fails for other elements.


# hms 0.5.0

## Breaking changes

- Now based on vctrs >= 0.2.0 (#61). This adds support for `vec_cast()` and `vec_ptype2()`. Some operations (such as subset assignment) are now stricter. The `new_hms()` constructor permits safe construction of `hms` objects from a numeric vector.

- The new `is_hms()` deprecates the existing `is.hms()`. `as.hms()` is deprecated in favor of `vec_cast()` or the new `as_hms()` (which is just a thin wrapper around `vec_cast()`).

## Printing

- Always show seconds in a pillar if they are different from zero (#54).

- Values with nonzero hours, seconds and split-seconds are now displayed correctly in tibbles (#56), even with a very small distance to the full second (#64).

## Internal

- Don't test colored output on CRAN.
- Correct reference link on r4ds (#58, @evanhaldane).


# hms 0.4.2

- Adapted tests to pillar 1.2.1.


# hms 0.4.1

- Preserve `NA` when converting to `character` (#51, @jeroen).
- Adapted tests to pillar 1.1.0.


# hms 0.4.0

## Breaking changes

- `as.hms.POSIXt()` now defaults to the current time zone, the previous default was `"UTC"` and can be restored by calling `pkgconfig::set_config("hms::default_tz", "UTC")`.

## New features

- Pillar support, will display `hms` columns in tibbles in color on terminals
  that support it (#43).
- New `round_hms()` and `trunc_hms()` for rounding or truncating to a given multiple of seconds (#31).
- New `parse_hms()` and `parse_hm()` to parse strings in "HH:MM:SS" and "HH:MM" formats (#30).
- `as.hms.POSIXt()` gains `tz` argument, default `"UTC"` (#28).
- `as.hms.character()` and `parse_hms()` accept fractional seconds (#33).

## Bug fixes

- `hms()` now works correctly if all four components (days, hours, minutes, seconds) are passed (#49).
- `hms()` creates a zero-length object of class `hms` that prints as `"hms()"`.
- `hms(integer())` and `as.hms(integer())` both work and are identical to `hms()`.
- Values with durations of over 10000 hours are now printed correctly (#48).
- `c()` now returns a hms (#41, @qgeissmann).

## Documentation and error messages

- Fix and enhance examples in `?hms`.
- Documentation is in Markdown format now.
- Improved error message if calling `hms()` with a character argument (#29).


# hms 0.3

- Fix `lubridate` test for compatibility with 1.6.0 (#23, @vspinu).
- NA values are formatted as `NA` (#22).


# hms 0.2

Minor fixes and improvements.

- Subsetting keeps `hms` class (#16).
- `format.hms()` right-justifies the output by padding with spaces from the left, `as.character.hms()` remains unchanged.
- Times larger than 24 hours or with split seconds are now formatted correctly (#12, #13).
- Sub-second part is printed with up to six digits, for even smaller values trailing zeros are shown (#17).


# hms 0.1

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
