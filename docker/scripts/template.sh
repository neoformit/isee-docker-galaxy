#!/usr/bin/env bash

# Template R script to be passed to isee.R

# Should be passed iSEE args as positional arg
# May end up more complex than this at some stage

if [[ $1 == "" ]]; then
    echo "iSEE_PARAMS <- {}"
else
    echo $1
fi
