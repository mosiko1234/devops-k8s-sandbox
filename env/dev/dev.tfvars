region               = "us-east-1"
vpc_cidr_block       = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
env_name             = "dev"
cluster_name         = "dev-sandbox-cluster"
instance_type        = "t3.medium"
desired_capacity     = 2
max_capacity         = 3
min_capacity         = 1
tags = {
  Environment = "dev"
}
enable_eks = "true"
