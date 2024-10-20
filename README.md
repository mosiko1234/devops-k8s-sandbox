# DevOps K8s Sandbox Project

This project is designed to easily manage and deploy an EKS cluster and VPC infrastructure on AWS using Terraform. The project supports multiple environments such as `dev` and `prod`.

## Prerequisites

Before starting, ensure that you have the following installed:

- [Terraform](https://www.terraform.io/downloads)
- [AWS CLI](https://aws.amazon.com/cli/)
- An AWS account with proper permissions to create VPC, S3, DynamoDB, and EKS resources.

## Setting Up Your Environment

Each developer should set up a separate environment directory under the `env/` folder. Follow these steps to get started:

### Step 1: Create Your Environment Directory

1. Inside the `env/` folder, create a directory named after your environment (e.g., `dev` or `prod`).
2. Copy the `dev.tfvars` or `prod.tfvars` into your new environment folder and modify it as needed for your environment.

Example:

```bash
mkdir env/my-env
cp dev.tfvars env/my-env/my-env.tfvars
```

Step 2: Create S3 Bucket and DynamoDB Table
Terraform requires an S3 bucket to store the state and a DynamoDB table to handle state locking.

Create S3 Bucket: Replace <bucket-name> with your desired bucket name.
```bash
aws s3api create-bucket --bucket <bucket-name> --region us-east-1
```

Create DynamoDB Table: Replace <table-name> with your desired table name.
```bash

aws dynamodb create-table \
  --table-name <table-name> \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```