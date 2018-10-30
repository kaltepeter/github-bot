#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker run --rm -d \
    -p 9200:9200 \
    -p 9300:9300 \
    --name mrll-bot-elastic \
    -v "${__dir}/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml" \
    docker.elastic.co/elasticsearch/elasticsearch-oss:6.4.2
