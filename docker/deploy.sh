#!/usr/bin/env bash

# Build and push a Docker image

docker build -t isee:galaxy --no-cache .        && \
docker tag isee:galaxy neoformit/galaxy-isee-it && \
docker push neoformit/galaxy-isee-it
