#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
[[ ${DEBUG:-} == true ]] && set -o xtrace

elastic_pod=$(kubectl get pod | grep elastic | cut -d ' ' -f 1)

pwout=$(kubectl exec "${elastic_pod}" -- bin/elasticsearch-setup-passwords auto -b)

echo "${pwout}"
echo ''

pwords=$(echo "${pwout}" | grep 'PASSWORD' | sed 's/PASSWORD \(.*\) = \(.*\)/\1 \2/g')

while read -r username password; do
  # line="$REPLY"
  echo "configure secret for: ${username} with pw: ${password}"
  kube_username="${username/_/-}"
  kubectl create secret generic "user-${kube_username}" --from-literal=username="${username}" --from-literal=password="${password}"
done <<< "${pwords}"

echo ''
exit 0
