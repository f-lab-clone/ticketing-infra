module "infra_team_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name          = "ticketing-infra-policy"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
        "eks:*",
        "lambda:*",
        "apigateway:*",
        "ec2:*",
        "rds:*",
        "s3:*",
        "sns:*",
        "states:*",
        "ssm:*",
        "sqs:*",
        "iam:*",
        "elasticloadbalancing:*",
        "autoscaling:*",
        "cloudwatch:*",
        "cloudfront:*",
        "route53:*",
        "ecr:*",
        "logs:*",
        "ecs:*",
        "application-autoscaling:*",
        "logs:*",
        "events:*",
        "elasticache:*",
        "es:*",
        "kms:*",
        "dynamodb:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

module "infra_team_iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  name                              = "ticketing-infra"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [module.infra_team_user1.iam_user_name, module.infra_team_user2.iam_user_name, module.infra_team_user3.iam_user_name]
  custom_group_policy_arns          = [module.infra_team_policy.arn]
}

module "infra_team_user1" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "ticketing-infra-junhaahn"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}

module "infra_team_user2" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "ticketing-infra-hihahayoung"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}

module "infra_team_user3" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "ticketing-infra-littlejsp"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}