#!/usr/bin/env bash
set -e pipefail

source .env
export TAG=$(git describe --tags)
export DOCKER_IMAGE=$DOCKER_IMAGE
export HTTP_PORT=$HTTP_PORT
export HTTPS_PORT=$HTTPS_PORT

docker compose -f docker-compose.yml build
docker tag "$DOCKER_IMAGE" "$DOCKER_IMAGE:$TAG"
docker tag "$DOCKER_IMAGE" "$DOCKER_IMAGE:latest"

docker push "$DOCKER_IMAGE:$TAG"
docker push "$DOCKER_IMAGE:latest"

echo "pushed $DOCKER_IMAGE:$TAG as latest ✅"

unset TAG
unset DOCKER_IMAGE
unset HTTP_PORT
unset HTTPS_PORT
