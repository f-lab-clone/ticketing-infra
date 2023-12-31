module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = "ticketing-main-eks"
  cluster_version = "1.27"

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  vpc_id= module.vpc.vpc_id
  subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)

  enable_irsa = true

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    disk_size              = 8
  }

  eks_managed_node_groups = {
    ingress = {
      desired_size = 1
      min_size     = 1
      max_size     = 1

      labels = {
        role = "ingress"
      }

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"

      subnet_ids = module.vpc.public_subnets
    }
    backend = {
      desired_size = 4
      min_size     = 3
      max_size     = 4

      labels = {
        role = "backend"
      }

      instance_types = ["t2.small", "t3.small"]
      capacity_type  = "SPOT"

      subnet_ids = module.vpc.public_subnets
    }
  }

  manage_aws_auth_configmap = true
  create_cloudwatch_log_group = false
  cluster_enabled_log_types = []

  aws_auth_roles = concat([
    {
      rolearn  = module.eks_admins_iam_role.iam_role_arn
      username = module.eks_admins_iam_role.iam_role_name
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${module.vpc.vpc_owner_id}:root", 
      username = "hihahayoung"
      groups   = ["system:masters"]
    },
  ],
  [
      for user in local.infra_users : {
      rolearn  = user.iam_user_arn
      username = user.iam_user_name
      groups   = ["system:masters"]
    }
  ])

  kms_key_administrators = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root", 
    module.infra_team_user1.iam_user_arn, 
    module.infra_team_user2.iam_user_arn, 
    module.infra_team_user3.iam_user_arn
  ]


  node_security_group_additional_rules = {
    ingress_http = {
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
    }
    nodeport_http = {
      protocol    = "tcp"
      from_port   = 30000
      to_port     = 30010
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  tags = {
    Environment = "development"
  }
}  
