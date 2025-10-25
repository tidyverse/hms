# Deprecated functions

`is.hms()` has been replaced by
[`is_hms()`](https://hms.tidyverse.org/dev/reference/hms.md).

`as.hms()` has been replaced by
[`as_hms()`](https://hms.tidyverse.org/dev/reference/hms.md), which does
not have a `tz` argument. Change the timezone before converting if
necessary, e.g. using
[`lubridate::with_tz()`](https://lubridate.tidyverse.org/reference/with_tz.html).

## Usage

``` r
is.hms(x)

as.hms(x, ...)

# Default S3 method
as.hms(x, ...)

# S3 method for class 'POSIXt'
as.hms(x, tz = pkgconfig::get_config("hms::default_tz", ""), ...)

# S3 method for class 'POSIXlt'
as.hms(x, tz = pkgconfig::get_config("hms::default_tz", ""), ...)
```

## Arguments

- x:

  An object.

- ...:

  Arguments passed on to further methods.

- tz:

  The time zone in which to interpret a POSIXt time for extracting the
  time of day. The default is now the zone of `x` but was `"UTC"` for
  v0.3 and earlier. The previous behavior can be restored by calling
  `pkgconfig::set_config("hms::default_tz", "UTC")`, see
  [`pkgconfig::set_config()`](https://rdrr.io/pkg/pkgconfig/man/set_config.html).
