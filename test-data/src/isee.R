# Test isee.R script
# This file would usually be templated within Galaxy from user input

shhh <- suppressPackageStartupMessages # It's a library, so shhh!

shhh(library(iSEE))
shhh(library(HDF5Array))


sce_path <- '/import/sce_mini'
sce <- loadHDF5SummarizedExperiment(sce_path)
app <- iSEE(sce,
    # Optional params can go here
)
shiny::runApp(app, host="0.0.0.0", port=8888, quiet=TRUE)
