#!/usr/bin/env sh
set -e pipefail

git_tag="$(git describe --tags)"
TAG=":$git_tag" docker-compose up

docker-compose -f docker-compose.prod.yml up
