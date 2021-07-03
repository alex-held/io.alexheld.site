#!/usr/bin/env sh
set -e pipefail

git_tag="$(git describe --tags)"
image_name="alexheld/io.alexheld.site"

docker compose -f docker-compose.yml build
docker tag "$image_name" "$image_name:$git_tag"
docker tag "$image_name" "$image_name:latest"
docker push --all-tags "$image_name"
