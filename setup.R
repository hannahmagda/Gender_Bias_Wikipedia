

# setup.R

# running this script before working with the mardown file will ensure that you have all necessary packages ready to use


required_packages <- c("tidyverse", "Hmisc", "ggplot2", "corrplot", "legislatoR", 
                       "WikipediR", "rvest", "dplyr", "stringr", "tm", "MatchIt", 
                       "quanteda", "purrr", "rstatix", "ggpubr", 
                       "effsize", "kableExtra", "magick", "webshot2", "here", 
                       "httr", "jsonlite", "pbapply", "knitr", "tidyr")

install_missing_packages <- function(packages) {
  missing_packages <- packages[!packages %in% installed.packages()[,"Package"]]
  if (length(missing_packages)) {
    install.packages(missing_packages)
  }
}

install_missing_packages(required_packages)