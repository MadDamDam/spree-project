#!/bin/bash
export KOPS_STATE_STORE=s3://damdam-k8s-aws-io
export KOPS_CLUSTER_NAME=k8s.damdam.me

export SPREE_DATABASE_URL=damdam-spree-db.cjcgajttvn7u.us-east-1.rds.amazonaws.com
export SPREE_DATABASE_DEV=dev-rds
export SPREE_DATABASE_PROD=prod-rds
export SPREE_DATABASE_USER=damdam
export SPREE_DATABASE_PASSWORD=12345678
export SECRET_KEY_BASE=a1439297db90eb32fc048a1d5ca3f8df4da1e284538670b9ca94b312534a7b0c0ddec3f933d9d0aee8a0064bee207c9da39fa334b63c164ece6a72a06355d4c3
export RAILS_ENV=production
export AUTO_ACCEPT=1
