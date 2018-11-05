#!/usr/bin/env bash

docker_version=$(cat VERSION)

docker build --no-cache --pull -t mrllsvc/docker-logstash:"${docker_version}" .
docker push mrllsvc/docker-logstash:"${docker_version}"