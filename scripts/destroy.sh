#!/bin/bash

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./scripts/destroy.sh <environment>"
  exit 1
fi

terraform destroy -var-file="./env/${ENVIRONMENT}/${ENVIRONMENT}.tfvars"
