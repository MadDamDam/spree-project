#!/bin/bash

echo "===Deploying spree==="
kubectl create -f k8s/spree-deployment-ingcon.yaml
kubectl create -f k8s/spree-ingress.yaml
kubectl create -f k8s/spree-hpa.yaml

sleep 60s
curl --user admin:123456 'http://grafana.damdam.me/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"Prometheus","isDefault":true ,"type":"prometheus","url":"http://prometheus-server:9090","access":"proxy","basicAuth":false}'
