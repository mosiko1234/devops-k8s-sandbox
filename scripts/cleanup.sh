#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: ./cleanup.sh <environment>"
  echo "Example: ./cleanup.sh dev"
  exit 1
fi

ENV=$1

if [ ! -d "env/$ENV" ]; then
  echo "Error: Environment '$ENV' does not exist."
  exit 1
fi

cd env/$ENV

echo "Running Terraform destroy for environment '$ENV'..."

terraform init
terraform plan -destroy
terraform destroy -auto-approve

cd ../..

echo "Cleanup complete for environment '$ENV'. All resources have been destroyed."

