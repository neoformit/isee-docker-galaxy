# Example user configuration in the Galaxy iSEE Interactive tool

cluster_color_fun <- function(n){
  # pretend these are custom colours, for clusters, or for samples.
  if (n <=12) {
    return(RColorBrewer::brewer.pal(n, "Paired"))
  } else {
    return(rainbow(n))
  }
}

ecm <- ExperimentColorMap(
  colData = list(
    cluster = cluster_color_fun
  ),
  all_continuous = list(
    assays = viridis::plasma
  )
)

initial_plots <- c(
  # Show umap with clusters by default
  ReducedDimensionPlot(Type="UMAP",
                       ColorBy="Column data",
                       ColorByColumnData="cluster",
                       VisualBoxOpen=TRUE,
                       PanelWidth=6L),

  # Show gene expression plot separated (and coloured) by cluster, by default.
  FeatureAssayPlot(XAxis = "Column data",
                   XAxisColumnData = 'cluster',
                   DataBoxOpen=TRUE,
                   ColorBy="Column data",
                   ColorByColumnData="cluster",
                   PanelWidth=6L
  ),

  # Gene list is better wide
  RowDataTable(PanelWidth=12L),

  # For cell level observations
  ColumnDataPlot(PanelWidth=6L)

)

# Keys should be valid iSEE() params
iSEE_PARAMS <- c(
  colormap = "ecm",
  initial = "initial_plots"
)
