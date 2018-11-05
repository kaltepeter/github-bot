#!/usr/bin/env bash

readonly __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Provide the name of host when asked for *Common Name*"
echo ">>>>>>>>>>>><<<<<<<<<<<<<<<<"

if [[ ! -f "${__dir}/tls-cert.crt" ]]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "${__dir}/tls-key.key" -out "${__dir}/tls-cert.crt"
fi

if [[ ! -f "${__dir}/dhparam.pem" ]]; then
    openssl dhparam -out "${__dir}/dhparam.pem" 2048
fi

if [[ ! -f "${__dir}/auth" ]]; then
    htpasswd -c "${__dir}/auth" mrll-svc
fi

echo "Created SSL cert"

echo "start minikube"
minikube start --kubernetes-version v1.11.4 --memory 8192 --cpus 3 --vm-driver hyperkit --disk-size 30g

kubectl create secret tls tls-certificate --key "${__dir}/tls-key.key" --cert "${__dir}/tls-cert.crt"

kubectl create secret generic tls-dhparam --from-file="${__dir}/dhparam.pem"

kubectl create secret generic basic-auth --from-file="${__dir}/auth"

minikube mount "${__dir}/..:/data" &>"${__dir}/volume_mount.log" &
echo $! >> "${__dir}/volume_mount.log"

minikube addons enable ingress

echo "Appending minikube service IP to /etc/hosts"
if grep -q 'elk.core.merrillcorp.com' /etc/hosts; then
    sudo sed -i '' 's/^\([0-9]*\.*\)* *elk\.core\.merrillcorp\.com/'"$(minikube ip)"'     elk.core.merrillcorp.com/' /etc/hosts
else
    echo "$(minikube ip)    elk.core.merrillcorp.com" | sudo tee -a /etc/hosts
fi 

echo "creating kubernetes cluster..."
kubectl create -f "${__dir}"