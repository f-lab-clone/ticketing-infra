module "allow_ecr_push_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name          = "allow-ecr-push"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

}

module "allow_ecr_pull_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name          = "allow-ecr-pull"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

module "ecr_push_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  name                              = "ecr-push"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [module.eks_iam_user_push.iam_user_name]
  custom_group_policy_arns          = [module.allow_ecr_push_iam_policy.arn]
}

module "ecr_pull_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  name                              = "ecr-pull"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [module.eks_iam_user_pull_only.iam_user_name]
  custom_group_policy_arns          = [module.allow_ecr_pull_iam_policy.arn]
}

module "eks_iam_user_pull_only" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "ecr_pull_user"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}

module "eks_iam_user_push" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "ecr_push_user"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}
