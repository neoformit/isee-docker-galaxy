#!/usr/bin/env bash

# Run isee with R passing input file arguments
# WDIR: /import

# Automatically kill container when traffic stops
# /scripts/monitor_traffic.sh &

Rscript                                       \
    --vanilla                                 \
    /scripts/isee.R $1 $2
