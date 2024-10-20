#!/bin/bash

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./scripts/init.sh <environment>"
  exit 1
fi

terraform init -var-file="./env/${ENVIRONMENT}/${ENVIRONMENT}.tfvars" -backend-config="./env/${ENVIRONMENT}/${ENVIRONMENT}-backend.tfvars"
