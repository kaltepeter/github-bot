#!/usr/bin/env bash
#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker_version=$(cat VERSION)

docker run --rm -d \
    -p 5601:5601 \
    -e ELASTIC_PASSWORD="${ELASTIC_PASSWORD}" \
    -v "$(pwd)/kibana.yml:/usr/share/kibana/config/kibana.yml" \
    --name mrll-bot-kibana \
    "mrllsvc/docker-kibana:${docker_version}"
