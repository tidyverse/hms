# A simple class for storing time-of-day values

The values are stored as a
[difftime](https://rdrr.io/r/base/difftime.html) vector with a custom
class, and always with "seconds" as unit for robust coercion to numeric.
Supports construction from time values, coercion to and from various
data types, and formatting. Can be used as a regular column in a data
frame.

`hms()` is a high-level constructor that accepts second, minute, hour
and day components as numeric vectors.

`new_hms()` is a low-level constructor that only checks that its input
has the correct base type,
[numeric](https://rdrr.io/r/base/numeric.html).

`is_hms()` checks if an object is of class `hms`.

`as_hms()` is a generic that supports conversions beyond casting. The
default method forwards to
[`vctrs::vec_cast()`](https://vctrs.r-lib.org/reference/vec_cast.html).

## Usage

``` r
hms(seconds = NULL, minutes = NULL, hours = NULL, days = NULL)

new_hms(x = numeric())

is_hms(x)

as_hms(x, ...)

# S3 method for class 'hms'
as.POSIXct(x, ...)

# S3 method for class 'hms'
as.POSIXlt(x, ...)

# S3 method for class 'hms'
as.character(x, ...)

# S3 method for class 'hms'
format(x, ...)

# S3 method for class 'hms'
print(x, ...)

# S3 method for class 'hms'
seq(from = hms(1), to = hms(1), by = NULL, ...)
```

## Arguments

- seconds, minutes, hours, days:

  Time since midnight. No bounds checking is performed.

- x:

  An object.

- ...:

  additional arguments to be passed to or from methods.

- from, to:

  the starting and (maximal) end values of the sequence. Of length `1`
  unless just `from` is supplied as an unnamed argument.

- by:

  number: increment of the sequence.

## Details

For `hms()`, all arguments must have the same length or be `NULL`. Odd
combinations (e.g., passing only `seconds` and `hours` but not
`minutes`) are rejected.

For arguments of type lubridate::POSIXct and
[POSIXlt](https://rdrr.io/r/base/DateTimeClasses.html), `as_hms()` does
not perform timezone conversion. Use
[`lubridate::with_tz()`](https://lubridate.tidyverse.org/reference/with_tz.html)
and
[`lubridate::force_tz()`](https://lubridate.tidyverse.org/reference/force_tz.html)
as necessary.

## Examples

``` r
hms(56, 34, 12)
#> 12:34:56
hms()
#> hms()

new_hms(as.numeric(1:3))
#> 00:00:01
#> 00:00:02
#> 00:00:03
# Supports numeric only!
try(new_hms(1:3))
#> Error in new_hms(1:3) : `x` must be a vector with type <double>.
#> Instead, it has type <integer>.

as_hms(1)
#> 00:00:01
as_hms("12:34:56")
#> 12:34:56
as_hms(Sys.time())
#> 06:52:06.275106
as.POSIXct(hms(1))
#> [1] "1970-01-01 00:00:01 UTC"
data.frame(a = hms(1))
#>          a
#> 1 00:00:01
d <- data.frame(hours = 1:3)
d$hours <- hms(hours = d$hours)
d
#>      hours
#> 1 01:00:00
#> 2 02:00:00
#> 3 03:00:00
```
