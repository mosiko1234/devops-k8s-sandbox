#!/bin/bash

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./scripts/plan.sh <environment>"
  exit 1
fi

terraform plan -var-file="./env/${ENVIRONMENT}/${ENVIRONMENT}.tfvars"
