provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr_block      = var.vpc_cidr_block
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  env_name            = var.env_name
  availability_zones  = var.availability_zones
  count               = var.enable_vpc ? 1 : 0
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = var.enable_eks && length(module.vpc) > 0 ? module.vpc[0].public_subnet_ids : []
  instance_type   = var.instance_type
  desired_capacity = var.desired_capacity
  max_capacity     = var.max_capacity
  min_capacity     = var.min_capacity
  tags            = var.tags
  count           = var.enable_eks ? 1 : 0
}
