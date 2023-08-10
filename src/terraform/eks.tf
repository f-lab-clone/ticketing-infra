module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = "ticketing-cluster-main"
  cluster_version = "1.27"

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)

  enable_irsa = true

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    disk_size              = 8
  }

  eks_managed_node_groups = {
    backend = {
      desired_size = 2
      min_size     = 1
      max_size     = 2

      labels = {
        role = "backend"
      }

      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"

      subnet_ids = module.vpc.public_subnets
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = module.eks_admins_iam_role.iam_role_arn
      username = module.eks_admins_iam_role.iam_role_name
      groups   = ["system:masters"]
    },
  ]

  tags = {
    Environment = "development"
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}