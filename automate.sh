#!/bin/bash

echo "===Setting enviroment variables==="
export KOPS_STATE_STORE=s3://damdam-k8s-aws-io
export KOPS_CLUSTER_NAME=k8s.damdam.me
echo "Kubernetes cluster name is set to $KOPS_CLUSTER_NAME"
echo "kubernetes state store is at $KOPS_STATE_STORE"

echo "===Deleting existing kubernetes cluster using Kops==="
end_message="Your cluster $KOPS_CLUSTER_NAME is ready"
kops delete cluster --yes

echo "===Creating kubernetes cluster using Kops==="
kops create -f kops-k8s.yaml -v 4
kops create secret --name k8s.damdam.me sshpublickey admin -i ~/.ssh/kops-aws.pub
kops update cluster --yes
kops_state=$(kops validate cluster | tee /dev/tty | tail -1)
while [ "$kops_state" != "$end_message" ]
do
  echo "Waiting 30 second before validating again..."
  sleep 30s
  kops_state=$(kops validate cluster | tee /dev/tty | tail -1)
done

echo "===Deploying Helm==="
kubectl create -f helm/helm-rbac-config.yaml
helm init --service-account tiller
echo "Waiting 60 seconds for tiller to deploy"
sleep 60s

echo "===Deploying ExternalDNS==="
helm install stable/external-dns -f helm/xdns-values.yaml --name xdns --namespace spree-route

echo "===Deploying nginx ingress controller==="
helm install stable/nginx-ingress -f helm/nginx-values.yaml --name ingcon --namespace spree-route

echo "===Deploying Prometheus==="
helm install stable/prometheus -f helm/prometheus-values.yaml --name prometheus --namespace spree-monitor

echo "===Deploying Grafana==="
helm install stable/grafana -f helm/grafana-values.yaml --name grafana --namespace spree-monitor
grafana_secret=$(kubectl get secret --namespace spree-monitor grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)
echo "Grafana initial password is $grafana_secret" | tee spree-grafana-pass.txt
echo "Password has also been written to spree-grafana-pass.txt"

echo "===Deploying spree==="
kubectl create -f k8s/spree-deployment-ingcon.yaml
kubectl create -f k8s/spree-ingress.yaml

sleep 60s
curl --user admin:123456 'http://grafana.damdam.me/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"Prometheus","isDefault":true ,"type":"prometheus","url":"http://prometheus-server:9090","access":"proxy","basicAuth":false}'
