# Coercion

Double dispatch methods to support
[`vctrs::vec_ptype2()`](https://vctrs.r-lib.org/reference/vec_ptype2.html).

## Usage

``` r
# S3 method for class 'hms'
vec_ptype2(x, y, ..., x_arg = "", y_arg = "")
```

## Arguments

- x, y:

  Vector types.

- ...:

  These dots are for future extensions and must be empty.

- x_arg, y_arg:

  Argument names for `x` and `y`. These are used in error messages to
  inform the user about the locations of incompatible types (see
  [`stop_incompatible_type()`](https://vctrs.r-lib.org/reference/vctrs-conditions.html)).
