#!/bin/bash

# Stop execution if a step fails
set -e

DOCKER_USERNAME=carlosdgomes # Replace by your docker hub username
IMAGE_NAME=lbaw1813

docker build -t $DOCKER_USERNAME/$IMAGE_NAME .
docker push $DOCKER_USERNAME/$IMAGE_NAME
