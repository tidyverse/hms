# Parsing hms values

These functions convert character vectors to objects of the
[hms](https://hms.tidyverse.org/dev/reference/hms.md) class. `NA` values
are supported.

`parse_hms()` accepts values of the form `"HH:MM:SS"`, with optional
fractional seconds.

`parse_hm()` accepts values of the form `"HH:MM"`.

## Usage

``` r
parse_hms(x)

parse_hm(x)
```

## Arguments

- x:

  A character vector

## Value

An object of class
[hms](https://hms.tidyverse.org/dev/reference/hms.md).

## Examples

``` r
parse_hms("12:34:56")
#> 12:34:56
parse_hms("12:34:56.789")
#> 12:34:56.789
parse_hm("12:34")
#> 12:34:00
```
