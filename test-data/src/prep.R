# A function to prepare sce data for display in iSEE

prep <- function(sce) {
  # A HDF5SummarizedExperiment object that may be manipulated before
  # returning for display in iSEE. You probably want to test this
  # code in RStudio and then paste it in here to ease debugging.

  # Your code here

  return(sce)
}

# myColorMap <- ExperimentColorMap(myColorConfig)

# myPlots <- c(
#   ReducedDimensionPlot(myPlotConfig),
#   FeatureAssayPlot(myPlotConfig),
#   ...
# )

iSEE_PARAMS <- {
    # colormap: myColorMap,
    # initial: myPlots,
}
