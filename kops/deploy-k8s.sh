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

echo "===Kubernetes cluster deployed successfully==="
