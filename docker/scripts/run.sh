#!/usr/bin/env bash

# Run isee with R passing input file arguments

# We need a folder of two files: <assay.h5> and <se.rds>
# (maybe a composite datatype? Is the rdata.sce datatype appropriate?)

# Also requires an R script which has been templated with user input
# (not sure how this will be implemented yet, maybe Jinja2, maybe just basic
# concatenation ... )

# ------------------------------------------------------------------------------

# Galaxy:

# Where on earth will this end up? Should mv it to /import/prep.R
# get -i ${CONFIG_R_SCRIPT} && \

# WDIR: /import

echo "" >> /import/docker.out
echo "Running iSEE at $(date +"%F | %H:%M:%S")" >> /import/docker.out
echo "" >> /import/docker.out

get -i ${input_rds} && get -i ${input_h5}  && \
mkdir sce                                  && \
mv ${input_rds} sce/se.rds                 && \
mv ${input_h5} sce/assay.h5                && \
Rscript                                       \
    --vanilla                                 \
    /scripts/isee.R                           \
    /import/sce                               \
    # /import/${CONFIG_R_SCRIPT}              \
    >> /import/docker.out
