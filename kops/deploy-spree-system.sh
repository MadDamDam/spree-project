#!/bin/bash

echo "===Deploying Helm==="
kubectl create -f helm/helm-rbac-config.yaml
helm init --service-account tiller
echo "Waiting 60 seconds for tiller to deploy"
sleep 60s

echo "===Deploying ExternalDNS==="
helm install stable/external-dns -f helm/xdns-values.yaml --name xdns --namespace spree-route

echo "===Deploying nginx ingress controller==="
helm install stable/nginx-ingress -f helm/nginx-values.yaml --name ingcon --namespace spree-route

echo "===Deploying Heapster HPA controller==="
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/metrics-server/v1.8.x.yaml
helm install stable/heapster -f helm/heapster-values.yaml --name hpacon --namespace spree-system

echo "===Deploying Prometheus==="
helm install stable/prometheus -f helm/prometheus-values.yaml --name prometheus --namespace spree-monitor

echo "===Deploying Grafana==="
helm install stable/grafana -f helm/grafana-values.yaml --name grafana --namespace spree-monitor
#grafana_secret=$(kubectl get secret --namespace spree-monitor grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)
#echo "Grafana initial password is $grafana_secret" | tee spree-grafana-pass.txt
#echo "Password has also been written to spree-grafana-pass.txt"
