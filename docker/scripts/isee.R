#
# Pass a SingleCellExperiment object into the iSEE browser.
#
# The user can also pass arbitrary kwards to iSEE() which have been
# templated into the iSEE_PARAMS variable in prep.R.
#
# Currently the tool is configured to accept either *.rds or SCE objects, but
# the SCE objects are the only datatype that is currently working in Galaxy
#


shhh <- suppressPackageStartupMessages # It's a library, so shhh!

shhh(library(iSEE))
shhh(library(HDF5Array))


args = commandArgs(trailingOnly=TRUE)
if (length(args) != 2) {
    stop("Requires two positional args: [path:sce_data], [path:prep.R], ", call.=FALSE)
}

source(args[2], local=TRUE)  # import iSEE_PARAMS

sce_path <- args[1]
if (endsWith(sce_path, ".rds")) {
    sce <- readRDS(sce_path)
} else {
    sce <- loadHDF5SummarizedExperiment(sce_path)
}

# Concatenate data path and user params
# This causes attribute errors with some objects
args <- c(list(sce), list(iSEE_PARAMS))

# Pass arbitrary user arguments to iSEE()
app <- do.call('iSEE', args)
shiny::runApp(app, host="0.0.0.0", port=8888)
