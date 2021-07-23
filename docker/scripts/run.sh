#!/usr/bin/env bash

# Run isee with R passing input file arguments

# We need a folder of two files: <data.h5> and <data.rds>
# (maybe a dataset collection (pair)? rdata.sce datatype?)

# Also requires an R script which has been templated with user input
# (not sure how this will be implemented yet, maybe Jinja2, maybe just basic
# concatenation ... )

# ------------------------------------------------------------------------------

# Locally:
# (run with docker run -v "$(pwd)"/src:/src -p 5000:5000 <image_name>)
Rscript --vanilla /scripts/isee.R /import/sce_mini /import/prep.R

# ------------------------------------------------------------------------------

# Galaxy:

# Where on earth will this end up? Should mv it to /import/prep.R
# get -i ${CONFIG_R_SCRIPT} && \

get -i ${DATASET_HID} && \
Rscript --vanilla /scripts/isee.R /import/${DATASET_HID} # /import/${CONFIG_R_SCRIPT}
