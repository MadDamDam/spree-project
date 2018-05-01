#!/bin/bash

echo "===Delete spree deployment==="
kubectl delete svc spree -n spree-app
kubectl delete deployment spree -n spree-app

echo "===Deploying spree==="
kubectl create -f k8s/spree-deployment-ingcon.yaml
