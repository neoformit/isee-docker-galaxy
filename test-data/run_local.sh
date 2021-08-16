#!/usr/bin/env bash

docker run -v "$(pwd)"/src:/import -p 5000:8888 --name isee isee:galaxy \
    /scripts/run.sh \
    /import/isee.R
