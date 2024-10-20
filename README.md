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

You can use the same DynamoDB table across multiple environments.


Step 3: Configure backend.tfvars

In your environment directory (e.g., env/my-env/), create a my-env-backend.tfvars file with the following content:
```bash
bucket         = "<your-s3-bucket-name>"
key            = "terraform/my-env/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "<your-dynamodb-table-name>"
```

Replace <your-s3-bucket-name> and <your-dynamodb-table-name> with the actual names you created in Step 2.

Step 4: Initialize Terraform
Run the following command to initialize Terraform with your environment's specific configuration:

```bash
./scripts/init.sh my-env
```

Step 5: Run Terraform Commands
Now you can run Terraform commands for your environment.

Plan: Preview the changes Terraform will make:
```bash
./scripts/plan.sh my-env
```

Apply: Apply the changes and deploy the infrastructure:
```bash
./scripts/apply.sh my-env
```

Destroy: Destroy the infrastructure when you're done:
```bash
./scripts/destroy.sh my-env
```

Folder Structure
```bash
devops-k8s-sandbox/
├── main.tf                    # Main Terraform file that links between modules
├── variables.tf               # Global variables file
├── outputs.tf                 # Global outputs file
├── terraform.tfvars           # Default global variable values (can be environment-specific)
├── .gitignore                 # Git ignore file to prevent unwanted files from being committed
├── README.md                  # Project documentation
├── backend.tf                 # Backend configuration for state storage (S3 and DynamoDB)
├── env/                       # Directory for different environments (dev, prod, etc.)
│   ├── dev/                   # Dev environment
│   └── prod/                  # Prod environment
├── modules/                   # Terraform modules (e.g., VPC, EKS)
│   ├── vpc/                   # Module for managing the VPC
│   └── eks/                   # Module for managing the EKS cluster
├── scripts/                   # Scripts to streamline Terraform commands
│   ├── init.sh                # Script to initialize the backend
│   ├── plan.sh                # Script to run terraform plan
│   ├── apply.sh               # Script to run terraform apply
│   └── destroy.sh             # Script to run terraform destroy

```


Important Notes

Each environment has its own S3 bucket for storing the state file and DynamoDB table for state locking.
Always use the correct environment configuration (<env-name>.tfvars) and backend configuration (<env-name>-backend.tfvars) when running Terraform commands.
Cleanup

When you are done working with your environment, you can clean up the resources by running the destroy.sh script:
```bash
./scripts/destroy.sh my-env
```

This will destroy all AWS resources created by Terraform.

Troubleshooting

Ensure that your AWS credentials are properly configured with the AWS CLI.
If you encounter errors related to state locking, you can manually unlock the state using:
```bash
terraform force-unlock <lock-id>
```

if the backend configuration isn't initialized properly, ensure that your backend.tfvars file is correctly configured.