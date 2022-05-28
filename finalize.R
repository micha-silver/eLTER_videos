for (f in list.files(pattern = "Demo.*Rmd")) {
  knitr::purl(f, documentation = 1)
}