#!/usr/bin/env bash
readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

minikube mount "${__dir}/..:/data" &>"${__dir}/volume_mount.log" 2>&1
