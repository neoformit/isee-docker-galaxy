# Pass a SingleCellExperiment object into the iSEE browser.
# Can be manipulated with the prep() function which is templated from Galaxy
# user input. The user can also pass arbitrary kwards to iSEE() which have been
# templated into the iSEE_PARAMS variable.

library(iSEE)
library(HDF5Array)

args = commandArgs(trailingOnly=TRUE)
if (length(args) != 2) {
  stop("Requires two positional args: [sce_data path], [prep.R path], ", call.=FALSE)
}

source(args[2])  # import prep() and iSEE_PARAMS

sce_file <- args[1]
sce_origin <- loadHDF5SummarizedExperiment(sce_file)
sce <- prep(sce_origin)

app <- iSEE(sce)  # Can add arbitrary user kwargs here
shiny::runApp(app, host="0.0.0.0", port=8888)
