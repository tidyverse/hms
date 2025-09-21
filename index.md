
<!-- README.md is generated from README.Rmd. Please edit that file -->



# hms <a href='https:/hms.tidyverse.org'><img src='man/figures/logo.png' align="right" height="139" alt="Hexagonal logo for the R package ‘hms’, featuring a stylized green clock face showing the time 10:05, with the package name ‘hms’ in white text at the center and the rstudio.com URL at the bottom edge."/></a>

<!-- badges: start -->
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![rcc](https://github.com/tidyverse/hms/workflows/rcc/badge.svg)](https://github.com/tidyverse/hms/actions)
[![Codecov test coverage](https://codecov.io/gh/tidyverse/hms/branch/main/graph/badge.svg)](https://app.codecov.io/gh/tidyverse/hms?branch=main)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/hms)](https://cran.r-project.org/package=hms)
<!-- badges: end -->

## Overview

The hms package provides a simple class for storing durations or time-of-day values and displaying them in the hh:mm:ss format.  This class is intended to simplify data exchange with databases, spreadsheets, and other data sources:

- Stores values as a numeric vector that contains the number of seconds
since midnight
- Supports construction from explicit hour, minute, or second values
- Supports coercion to and from various data types, including `POSIXt`
- Can be used as column in a data frame
- Based on the `difftime` class
- Values can exceed the 24-hour boundary or be negative
- By default, fractional seconds up to a microsecond are displayed, regardless of the value of the `"digits.secs"` option

## Installation

```r
# The easiest way to get hms is to install the whole tidyverse:
install.packages("tidyverse")

# Alternatively, install just hms:
install.packages("hms")

# Or the the development version from GitHub:
# install.packages("pak")
pak::pak("tidyverse/hms")
```

## Usage

The following example showcases ways of using the `hms` class standalone or as a data frame column.


``` r
library(hms)

hms(56, 34, 12)
#> 12:34:56
as_hms(Sys.time())
#> 05:57:08.20206
parse_hms("12:34:56")
#> 12:34:56
as.POSIXct(hms(1))
#> [1] "1970-01-01 00:00:01 UTC"

data.frame(hours = 1:3, hms = hms(hours = 1:3))
#>   hours      hms
#> 1     1 01:00:00
#> 2     2 02:00:00
#> 3     3 03:00:00
```

## Internal representation

Objects of the `hms` and its underlying `difftime` classes are stored as number of seconds since `00:00:00`.
Use `as.numeric()` and `as_hms()` to convert to and from numbers.


``` r
times <- parse_hms(c("00:00:00.25", "00:00:01", "00:01:30", "01:00:00"))
times
#> 00:00:00.25
#> 00:00:01.00
#> 00:01:30.00
#> 01:00:00.00
times_num <- as.numeric(times)
times_num
#> [1]    0.25    1.00   90.00 3600.00
as_hms(times_num)
#> 00:00:00.25
#> 00:00:01.00
#> 00:01:30.00
#> 01:00:00.00
```

