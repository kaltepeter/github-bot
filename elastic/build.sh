#!/usr/bin/env bash
docker_version=$(cat VERSION)

docker build --no-cache --pull -t mrllsvc/docker-elastic:"${docker_version}" .
docker push mrllsvc/docker-elastic:"${docker_version}"
