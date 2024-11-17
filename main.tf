provider "aws" {
  region = var.region
}


module "vpc" {

  source                  = "./modules/vpc"
  count                   = var.vpc_enabled ? 1 : 0

  env                     = var.env
  vpc_cidr_block          = var.vpc_cidr_block
  vpc_subnet_public       = var.vpc_subnet_public
  vpc_subnet_private      = var.vpc_subnet_private
  vpc_availability_zones  = var.vpc_availability_zones
}


module "eks" {

  source                       = "./modules/eks"
  count                        = var.eks_enabled ? 1 : 0

  tags                         = var.tags
  eks_name                     = var.eks_name
  eks_version                  = var.eks_version
  eks_instance_type            = var.eks_instance_type
  eks_instance_scaling_max     = var.eks_instance_scaling_max
  eks_instance_scaling_min     = var.eks_instance_scaling_min
  eks_instance_scaling_desired = var.eks_instance_scaling_desired

  subnet_ids                   = var.eks_enabled && length(module.vpc) > 0 ? module.vpc[0].public_subnet_ids : []

}
