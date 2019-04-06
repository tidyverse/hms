add_package_checks()

if (ci_has_env("DEV_VERSIONS")) {
  get_stage("install") %>%
    add_step(step_install_github("r-lib/vctrs"))
}
