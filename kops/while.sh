#!/bin/bash

end_message="Your cluster $KOPS_CLUSTER_NAME is ready"

kops validate cluster > /tmp/kops_cluster_state.txt
cat /tmp/kops_cluster_state.txt
kops_state=$(tail -1 /tmp/kops_cluster_state.txt)

while [ "$kops_state" != "$end_message" ]
do
  echo "Waiting 15 second before validating again..."
  sleep 15s

  kops validate cluster > /tmp/kops_cluster_state.txt
  cat /tmp/kops_cluster_state.txt
  kops_state=$(tail -1 /tmp/kops_cluster_state.txt)
done

