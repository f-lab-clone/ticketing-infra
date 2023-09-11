resource "kubernetes_service_account" "backend_account" {
  metadata {
    name = "ticketing-backend-account"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.iam_eks_role.iam_role_arn
    }
  }
}


module "iam_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "backend-role"

  role_policy_arns = {
    policy = module.secrets_manager_access_policy.arn
  }

  oidc_providers = {
    backend = {
      provider_arn               =  module.eks.oidc_provider_arn
      namespace_service_accounts = ["default:ticketing-backend-account"]
    }
  }
}