for (f in list.files(pattern = "Video.*.Rmd")) {
  knitr::purl(f, documentation = 1)
}