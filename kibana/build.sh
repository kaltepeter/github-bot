#!/usr/bin/env bash

docker_version=$(cat VERSION)

docker build --no-cache --pull -t mrllsvc/docker-kibana:"${docker_version}" .
docker push mrllsvc/docker-kibana:"${docker_version}"
