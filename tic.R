do_package_checks()

if (ci_has_env("DEV_VERSIONS")) {
  get_stage("install") %>%
    add_step(step_install_github(c("r-lib/rlang", "r-lib/pkgconfig", "r-lib/vctrs")))
}

if (ci_has_env("BUILD_PKGDOWN")) {
  do_pkgdown()
}
