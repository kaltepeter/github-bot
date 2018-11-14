#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker_version=$(cat VERSION)

docker run --rm -d \
    -p 9400:9400 \
    -p 5044:5044 \
    -p 9600:9600 \
    -p 444:443 \
    -e xpack.monitoring.elasticsearch.username=logstash_system \
    -e xpack.monitoring.elasticsearch.password='${ELASTIC_MONITORING_PASSWORD}' \
    -e ELASTIC_PASSWORD="${ELASTIC_PASSWORD}" \
    -e ELASTIC_HOST="https://elk.core.merrillcorp.com:443/elastic" \
    --name mrll-bot-logstash \
    -v "${__dir}/pipeline/.:/usr/share/logstash/pipeline/" \
    "mrllsvc/docker-logstash:${docker_version}"
