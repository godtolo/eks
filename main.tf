# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = var.vpc_tags
}

# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5" 

  cluster_name = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  # network configuration
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets
  cluster_endpoint_public_access  = true

  enable_cluster_creator_admin_permissions = true

  # EKS Node Groups Configuration
  eks_managed_node_groups = {
    worker = {
      min_size     = 2
      max_size     = 2
      desired_size = 2

      instance_types = ["t2.micro"]
      capacity_type  = "ON_DEMAND"
    }
  }

  authentication_mode = "API_AND_CONFIG_MAP"

  cluster_service_ipv4_cidr = "10.100.0.0/16"
}