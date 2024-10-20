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
Step 2: Create S3 Bucket and DynamoDB Table
Terraform requires an S3 bucket to store the state and a DynamoDB table to handle state locking.

Create S3 Bucket: Replace <bucket-name> with your desired bucket name.
bash
Copy code
aws s3api create-bucket --bucket <bucket-name> --region us-east-1
Create DynamoDB Table: Replace <table-name> with your desired table name.
bash
Copy code
aws dynamodb create-table \
  --table-name <table-name> \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
You can use the same DynamoDB table across multiple environments.
Step 3: Configure backend.tfvars
In your environment directory (e.g., env/my-env/), create a my-env-backend.tfvars file with the following content:

hcl
Copy code
bucket         = "<your-s3-bucket-name>"
key            = "terraform/my-env/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "<your-dynamodb-table-name>"
Replace <your-s3-bucket-name> and <your-dynamodb-table-name> with the actual names you created in Step 2.

Step 4: Initialize Terraform
Run the following command to initialize Terraform with your environment's specific configuration:

bash
Copy code
./scripts/init.sh my-env
Step 5: Run Terraform Commands
Now you can run Terraform commands for your environment.

Plan: Preview the changes Terraform will make:
bash
Copy code
./scripts/plan.sh my-env
Apply: Apply the changes and deploy the infrastructure:
bash
Copy code
./scripts/apply.sh my-env
Destroy: Destroy the infrastructure when you're done:
bash
Copy code
./scripts/destroy.sh my-env
Folder Structure

plaintext
Copy code
devops-k8s-sandbox/
├── modules/               # Terraform modules for VPC and EKS
│   ├── vpc/               # VPC module
│   └── eks/               # EKS module
├── env/                   # Environment-specific folders
│   ├── dev/               # Dev environment
│   ├── prod/              # Prod environment
├── scripts/               # Scripts to run Terraform commands
│   ├── init.sh            # Script to initialize the backend for each environment
│   ├── plan.sh            # Script to run Terraform plan for each environment
│   ├── apply.sh           # Script to run Terraform apply for each environment
│   ├── destroy.sh         # Script to run Terraform destroy for each environment
├── .gitignore             # Git ignore file
├── README.md              # Project documentation
Important Notes

Each environment has its own S3 bucket for storing the state file and DynamoDB table for state locking.
Always use the correct environment configuration (<env-name>.tfvars) and backend configuration (<env-name>-backend.tfvars) when running Terraform commands.
Cleanup

When you are done working with your environment, you can clean up the resources by running the destroy.sh script:

bash
Copy code
./scripts/destroy.sh my-env
This will destroy all AWS resources created by Terraform.

Troubleshooting

Ensure that your AWS credentials are properly configured with the AWS CLI.
If you encounter errors related to state locking, you can manually unlock the state using:
bash
Copy code
terraform force-unlock <lock-id>
If the backend configuration isn't initialized properly, ensure that your backend.tfvars file is correctly configured.