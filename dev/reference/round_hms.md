# Round an hms object

Convenience functions to round to a multiple of seconds or digits.

## Usage

``` r
round_hms(x, secs = NULL, digits = NULL)

trunc_hms(x, secs = NULL, digits = NULL)

ceiling_hms(x, secs = NULL, digits = NULL)

floor_hms(x, secs = NULL, digits = NULL)
```

## Arguments

- x:

  A vector of class
  [hms](https://hms.tidyverse.org/dev/reference/hms.md)

- secs:

  Multiple of seconds, a positive numeric. Values less than one are
  supported

- digits:

  Number of digits, a whole number. Negative numbers are supported.

## Value

The input, rounded or truncated to the nearest multiple of `secs` (or
number of `digits`)

## Examples

``` r
round_hms(as_hms("12:34:56"), 5)
#> 12:34:55
round_hms(as_hms("12:34:56"), 60)
#> 12:35:00
round_hms(as_hms("12:34:56.78"), 0.25)
#> 12:34:56.75
round_hms(as_hms("12:34:56.78"), digits = 1)
#> 12:34:56.8
round_hms(as_hms("12:34:56.78"), digits = -2)
#> 12:35:00
trunc_hms(as_hms("12:34:56"), 60)
#> 12:34:00
ceiling_hms(as_hms("12:34:56"), 60)
#> 12:35:00
floor_hms(as_hms("12:34:56"), 60)
#> 12:34:00
```
