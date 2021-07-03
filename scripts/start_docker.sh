#!/usr/bin/env bash
set -e pipefail

source .env
export TAG=$(git describe --tags)
export DOCKER_IMAGE=$DOCKER_IMAGE
export HTTP_PORT=$HTTP_PORT
export HTTPS_PORT=$HTTPS_PORT

docker-compose -f docker-compose.prod.yml up -d

unset TAG
unset DOCKER_IMAGE
unset HTTP_PORT
unset HTTPS_PORT
