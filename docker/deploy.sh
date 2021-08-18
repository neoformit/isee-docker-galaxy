#!/usr/bin/env bash

# Build and push a Docker image
# This script is made redundant by makefile

docker build -t isee:galaxy --no-cache .        && \
docker tag isee:galaxy neoformit/galaxy-isee-it && \
docker push neoformit/galaxy-isee-it
