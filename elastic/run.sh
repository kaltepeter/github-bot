#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker_version=$(cat VERSION)

docker run --rm -d \
    -p 9200:9200 \
    -p 9300:9300 \
    --name mrll-bot-elastic \
    -v "${__dir}/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml" \
     "mrllsvc/docker-elastic:${docker_version}"

docker exec -it mrll-bot-elastic bin/elasticsearch-setup-passwords auto
