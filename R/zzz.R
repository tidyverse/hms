known_packages <- c(
  "units"
)

our_methods <- c(
  "as.hms"
)

.onLoad <- function(libname, pkgname) {
  lapply(intersect(loadedNamespaces(), known_packages), load_known_package)
  lapply(known_packages, function(pkgname) {
    setHook(packageEvent(pkgname, "onLoad"), load_known_package)
    setHook(packageEvent(pkgname, "onUnload"), unload_known_package)
  })
}

load_known_package <- function(pkgname, ...) {
  implemented_methods <- find_implemented_methods(getNamespace(pkgname))
  Map(names(implemented_methods), implemented_methods, f = function(name, fun) {
    .__S3MethodsTable__.[[name]] <- fun
  })
}

unload_known_package <- function(pkgname, ...) {
  implemented_method_names <- find_implemented_methods(getNamespace(pkgname))
  Map(implemented_method_names, f = function(name) {
    .__S3MethodsTable__.[[name]] <- NULL
  })
}

find_implemented_method_names <- function(env) {
  pattern <- utils::glob2rx(paste0(our_methods, "*"))
  ls(env, all.names = TRUE, pattern = pattern)
}

find_implemented_methods <- function(env) {
  implemented_method_names <- find_implemented_method_names(env)
  implemented_methods <- mget(
    implemented_method_names, env, mode = "function",
    ifnotfound = rep(list(NULL), length(implemented_method_names)))
  implemented_methods[!vapply(implemented_methods, is.null, logical(1L))]
}
