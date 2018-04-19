#!/bin/bash
export KOPS_STATE_STORE=s3://damdam-k8s-aws-io
export KOPS_CLUSTER_NAME=k8s.damdam.me

kops delete cluster --yes
kops create -f kops-k8s.yaml -v 4
kops create secret --name k8s.damdam.me sshpublickey admin -i ~/.ssh/kops-aws.pub
kops update cluster --yes

end_message="Your cluster $KOPS_CLUSTER_NAME is ready"

kops validate cluster > /tmp/kops_cluster_state.txt
cat /tmp/kops_cluster_state.txt
kops_state=$(tail -1 /tmp/kops_cluster_state.txt)

while [ "$kops_state" != "$end_message" ]
do
  echo "Waiting 30 second before validating again..."
  sleep 30s

  kops validate cluster > /tmp/kops_cluster_state.txt
  cat /tmp/kops_cluster_state.txt
  kops_state=$(tail -1 /tmp/kops_cluster_state.txt)
done

echo "===Deploying Helm==="
kubectl create -f helm/helm-rbac-config.yaml
helm init --service-account tiller
echo "Waiting 60 seconds for tiller to deploy"
sleep 60s
echo "===Deploying ExternalDNS==="
helm install --name xdns stable/external-dns -f helm/xdns-values.yaml
echo "===Deploying ingress controller==="
helm install --name ingcon stable/nginx-ingress -f helm/nginx-values.yaml
echo "===Deploying Prometheus==="
helm install --name prometheus stable/prometheus -f helm/prometheus-values.yaml
echo "===Deploying Grafana==="
helm install --name grafana stable/grafana -f helm/grafana-values.yaml
echo "===Deploying spree==="
kubectl create -f k8s/spree-deployment-ingcon.yaml
kubectl create -f k8s/spree-ingress.yaml
