#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly HOSTIP=$(ifconfig en0 inet | grep inet | awk '{print $2}')

docker run --rm -d \
    -p 9400:9400 \
    -p 5044:5044 \
    -p 443:443 \
    -p 9600:9600 \
    --name mrll-bot-logstash \
    -v "${__dir}/config:/usr/share/logstash/config" \
    -v "${__dir}/pipeline:/usr/share/logstash/pipeline" \
    mrll/logstash-oss:6.4.2
