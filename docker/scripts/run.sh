#!/usr/bin/env bash

# Run isee with R passing input file arguments

# We need a folder of two files: <assay.h5> and <se.rds>
# (maybe a composite datatype? Is the rdata.sce datatype appropriate?)

# Also requires an R script which has been templated with user input
# (not sure how this will be implemented yet, maybe Jinja2, maybe just basic
# concatenation ... )

# ------------------------------------------------------------------------------

# Galaxy:

# WDIR: /import

# Send output to host machine data directory for debugging (unsure if necessary)
echo "" >> docker.out
echo "Running iSEE at $(date +"%F | %H:%M:%S")" >> /import/docker.out
echo "" >> docker.out

# Automatically kill container when traffic stops
/scripts/monitor_traffic.sh &

# Rename input files and run iSEE
get -i ${input_rds} && get -i ${input_h5}  && \
get -i ${input_rscript}                    && \
mkdir sce                                  && \
mv ${input_rds} sce/se.rds                 && \
mv ${input_h5} sce/assay.h5                && \
mv ${input_rscript} sce/prep.R             && \
Rscript                                       \
    --vanilla                                 \
    /scripts/isee.R                           \
    sce                                       \
    sce/prep.R                                \
    >> docker.out
