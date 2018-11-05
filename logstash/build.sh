#!/usr/bin/env bash

docker_version=1.0

docker build --no-cache --pull -t mrllsvc/docker-logstash:"${docker_version}" .
docker push mrllsvc/docker-logstash:"${docker_version}"