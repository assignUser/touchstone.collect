.onLoad <- function(libname, pkgname) {
    if (!nzchar(Sys.getenv("TC_DELAY"))) {
        Sys.setenv(TC_DELAY = "0.1")
    }
}
