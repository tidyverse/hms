hms [![Travis-CI Build Status](https://travis-ci.org/rstats-db/hms.svg?branch=master)](https://travis-ci.org/rstats-db/hms) [![Coverage Status](https://img.shields.io/codecov/c/github/rstats-db/hms/master.svg)](https://codecov.io/github/rstats-db/hms?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/hms)](https://cran.r-project.org/package=hms)
=======================================================================================================================================================================================================================================================================================================================================================================

A simple class for storing time-of-day values

The values are stored as a numeric vector that contains the number of seconds since midnight, based on the `difftime` class. Supports construction from time values, coercion to and from various data types, and formatting. Can be used in a data frame.

Compared to `POSIXct`, no date is stored, although the values can exceed the 24-hour boundary.

``` r
library(hms)
hms(56, 34, 12)
#> 12:34:56
as.hms(1)
#> 00:00:00
as.hms("12:34:56")
#> 12:34:56
as.hms(Sys.time())
#> 15:16:00
as.POSIXct(hms(1))
#> [1] "1970-01-01 00:00:01 UTC"

data.frame(hours = 1:3, hms = hms(hours = 1:3))
#>   hours      hms
#> 1     1 01:00:00
#> 2     2 02:00:00
#> 3     3 03:00:00
```

Install the package from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("rstats-db/hms")
```
