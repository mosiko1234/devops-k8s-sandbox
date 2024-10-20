region               = "us-east-1"
vpc_cidr_block       = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.3.0/24"]
private_subnet_cidrs = ["10.1.2.0/24", "10.1.4.0/24"]
env_name             = "prod"
cluster_name         = "prod-sandbox-cluster"
instance_type        = "t3.medium"
desired_capacity     = 3
max_capacity         = 5
min_capacity         = 2
tags = {
  Environment = "prod"
}
