#' @title OnLoad File
#' @description Loads files from local environment after initial load
#' @importFrom utils read.table

.onLoad <- function(libname, pkgname) {
    utils::data("request_table", "argument_table",
     package=pkgname, envir=parent.env(environment()))
  }