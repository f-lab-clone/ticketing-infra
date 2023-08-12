output "eks_admins_iam_role_arn" {
  value = module.eks_admins_iam_role.iam_role_arn	
}

output "eks_admins_iam_role_name" {
  value = module.eks_admins_iam_role.iam_role_name	
}

output "cluster_name" {
  value = module.eks.cluster_name
}

# output "aws_auth_configmap_yaml" {
#   value = module.eks.aws_auth_configmap_yaml
# }