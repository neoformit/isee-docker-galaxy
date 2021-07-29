# Pass a SingleCellExperiment object into the iSEE browser.
# Can be manipulated with the prep() function which is templated from Galaxy
# user input. The user can also pass arbitrary kwards to iSEE() which have been
# templated into the iSEE_PARAMS variable.

shhh <- suppressPackageStartupMessages # It's a library, so shhh!

shhh(library(iSEE))
shhh(library(HDF5Array))


args = commandArgs(trailingOnly=TRUE)
if (length(args) != 2) {
  stop("Requires two positional args: [path:sce_data], [path:prep.R], ", call.=FALSE)
}

source(args[2])  # import prep() and iSEE_PARAMS

sce_path <- args[1]
sce <- loadHDF5SummarizedExperiment(sce_path)

# sce <- prep(sce)  # probably not useful for user

# Concatenate data path and user params
args <- c(list(sce), list(iSEE_PARAMS))

# Pass arbitrary args/kwargs to iSEE()
app <- do.call('iSEE', args)
shiny::runApp(app, host="0.0.0.0", port=8888)
