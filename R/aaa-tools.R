# nocov start
forward_to <- function(f, envir = parent.frame()) {
  f_fmls <- formals(f)
  f_called_fmls <- stats::setNames(lapply(names(f_fmls), as.symbol), names(f_fmls))

  f_call <- as.call(c(substitute(f), f_called_fmls))

  f_ret <- eval(bquote(
    function() {
      .(f_call)
    }
  ))

  formals(f_ret) <- f_fmls
  environment(f_ret) <- envir
  f_ret
}
# nocov end
