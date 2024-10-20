#!/bin/bash

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./scripts/apply.sh <environment>"
  exit 1
fi

terraform apply -var-file="./env/${ENVIRONMENT}/${ENVIRONMENT}.tfvars"
