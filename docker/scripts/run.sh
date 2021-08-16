#!/usr/bin/env bash

# Run isee with R passing input file arguments
# WDIR: /import

# Automatically kill container when traffic stops
/scripts/monitor_traffic.sh &

Rscript                                       \
    --vanilla                                 \
    $1  # templated R script
