# hms <a href='https:/hms.tidyverse.org'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Lifecycle: maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing) [![rcc](https://github.com/tidyverse/hms/workflows/rcc/badge.svg)](https://github.com/tidyverse/hms/actions) [![codecov](https://codecov.io/gh/tidyverse/hms/branch/master/graph/badge.svg)](https://codecov.io/gh/tidyverse/hms) [![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/hms)](https://cran.r-project.org/package=hms)

<!-- badges: end -->

## Overview

The hms package provides a simple class for storing durations or time-of-day values and displaying them in the hh:mm:ss format. This class is intended to simplify data exchange with databases, spreadsheets, and other data sources:

-   Stores values as a numeric vector that contains the number of seconds since midnight
-   Supports construction from explicit hour, minute, or second values
-   Supports coercion to and from various data types, including `POSIXt`
-   Can be used as column in a data frame
-   Based on the `difftime` class
-   Values can exceed the 24-hour boundary or be negative
-   By default, fractional seconds up to a microsecond are displayed, regardless of the value of the `"digits.secs"` option

## Installation

<pre class='chroma'>
<span class='c'># The easiest way to get hms is to install the whole tidyverse:</span>
<span class='nf'><a href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='o'>(</span><span class='s'>"tidyverse"</span><span class='o'>)</span>

<span class='c'># Alternatively, install just hms:</span>
<span class='nf'><a href='https://rdrr.io/r/utils/install.packages.html'>install.packages</a></span><span class='o'>(</span><span class='s'>"hms"</span><span class='o'>)</span>

<span class='c'># Or the the development version from GitHub:</span>
<span class='c'># install.packages("devtools")</span>
<span class='nf'>devtools</span><span class='nf'>::</span><span class='nf'><a href='https://devtools.r-lib.org//reference/remote-reexports.html'>install_github</a></span><span class='o'>(</span><span class='s'>"tidyverse/hms"</span><span class='o'>)</span></pre>

## Usage

The following example showcases ways of using the `hms` class standalone or as a data frame column.

<pre class='chroma'>
<span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='nv'><a href='https://hms.tidyverse.org/'>hms</a></span><span class='o'>)</span>

<span class='nf'><a href='https://hms.tidyverse.org/reference/hms.html'>hms</a></span><span class='o'>(</span><span class='m'>56</span>, <span class='m'>34</span>, <span class='m'>12</span><span class='o'>)</span>
<span class='c'>#&gt; 12:34:56</span>
<span class='nf'><a href='https://hms.tidyverse.org/reference/hms.html'>as_hms</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/Sys.time.html'>Sys.time</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='c'>#&gt; 06:10:37.753343</span>
<span class='nf'><a href='https://hms.tidyverse.org/reference/parse_hms.html'>parse_hms</a></span><span class='o'>(</span><span class='s'>"12:34:56"</span><span class='o'>)</span>
<span class='c'>#&gt; 12:34:56</span>
<span class='nf'><a href='https://rdrr.io/r/base/as.POSIXlt.html'>as.POSIXct</a></span><span class='o'>(</span><span class='nf'><a href='https://hms.tidyverse.org/reference/hms.html'>hms</a></span><span class='o'>(</span><span class='m'>1</span><span class='o'>)</span><span class='o'>)</span>
<span class='c'>#&gt; [1] "1970-01-01 00:00:01 UTC"</span>

<span class='nf'><a href='https://rdrr.io/r/base/data.frame.html'>data.frame</a></span><span class='o'>(</span>hours <span class='o'>=</span> <span class='m'>1</span><span class='o'>:</span><span class='m'>3</span>, hms <span class='o'>=</span> <span class='nf'><a href='https://hms.tidyverse.org/reference/hms.html'>hms</a></span><span class='o'>(</span>hours <span class='o'>=</span> <span class='m'>1</span><span class='o'>:</span><span class='m'>3</span><span class='o'>)</span><span class='o'>)</span>
<span class='c'>#&gt;   hours      hms</span>
<span class='c'>#&gt; 1     1 01:00:00</span>
<span class='c'>#&gt; 2     2 02:00:00</span>
<span class='c'>#&gt; 3     3 03:00:00</span></pre>

## Internal representation

Objects of the `hms` and its underlying `difftime` classes are stored as number of seconds since `00:00:00`. Use [`as.numeric()`](https://rdrr.io/r/base/numeric.html) and [`as_hms()`](https://hms.tidyverse.org/reference/hms.html) to convert to and from numbers.

<pre class='chroma'>
<span class='nv'>times</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://hms.tidyverse.org/reference/parse_hms.html'>parse_hms</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"00:00:00.25"</span>, <span class='s'>"00:00:01"</span>, <span class='s'>"00:01:30"</span>, <span class='s'>"01:00:00"</span><span class='o'>)</span><span class='o'>)</span>
<span class='nv'>times</span>
<span class='c'>#&gt; 00:00:00.25</span>
<span class='c'>#&gt; 00:00:01.00</span>
<span class='c'>#&gt; 00:01:30.00</span>
<span class='c'>#&gt; 01:00:00.00</span>
<span class='nv'>times_num</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/numeric.html'>as.numeric</a></span><span class='o'>(</span><span class='nv'>times</span><span class='o'>)</span>
<span class='nv'>times_num</span>
<span class='c'>#&gt; [1]    0.25    1.00   90.00 3600.00</span>
<span class='nf'><a href='https://hms.tidyverse.org/reference/hms.html'>as_hms</a></span><span class='o'>(</span><span class='nv'>times_num</span><span class='o'>)</span>
<span class='c'>#&gt; 00:00:00.25</span>
<span class='c'>#&gt; 00:00:01.00</span>
<span class='c'>#&gt; 00:01:30.00</span>
<span class='c'>#&gt; 01:00:00.00</span></pre>

------------------------------------------------------------------------

Please note that the ‘hms’ project is released with a [Contributor Code of Conduct](https://github.com/tidyverse/hms/blob/master/CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.
