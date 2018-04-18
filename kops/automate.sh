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

echo "Deploying K8s..."
kubectl create -f k8s/externaldns-rbac-deployment.yaml
helm init
kubectl create -f k8s/spree-deployment.yaml
