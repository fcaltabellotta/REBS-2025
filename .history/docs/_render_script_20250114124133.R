library(sa4ss)

dir <- "C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs"
setwd(dir)

rmarkdown::render("index.Rmd")

dir <- "C:/Users/Jason.Cope/Documents/Github/REBS-2025/docs/Pre_assessment"
setwd(dir)

rmarkdown::render("index.Rmd")
