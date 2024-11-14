#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <environment> <action>"
  echo "Actions: init, plan, apply"
  echo "Example: $0 dev plan"
  exit 1
fi

ENVIRONMENT=$1
ACTION=$2
VARS_FILE="env/${ENVIRONMENT}/${ENVIRONMENT}.tfvars"

if [ ! -f "$VARS_FILE" ]; then
  echo "Error: Variables file for environment '$ENVIRONMENT' not found at '$VARS_FILE'"
  exit 1
fi

case "$ACTION" in
  init)
    echo "Initializing Terraform for environment '$ENVIRONMENT'..."
    terraform init -backend-config="env/${ENVIRONMENT}/${ENVIRONMENT}-backend.tfvars"
    ;;

  plan)
    echo "Running Terraform plan for environment '$ENVIRONMENT'..."
    terraform plan -var-file="$VARS_FILE" -out="plan.tfplan"
    ;;

  apply)
    echo "Applying Terraform plan for environment '$ENVIRONMENT'..."
    terraform apply "plan.tfplan"
    ;;

  *)
    echo "Invalid action: $ACTION. Allowed actions: init, plan, apply."
    exit 1
    ;;
esac

echo "Action '$ACTION' completed for environment '$ENVIRONMENT'"
