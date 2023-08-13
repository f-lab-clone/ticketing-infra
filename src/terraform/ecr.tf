module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "ticketing-ecr"

  # repository_read_access_arns = [module.allow_ecr_pull_iam_policy.arn]
  # repository_read_write_access_arns = [module.allow_ecr_push_iam_policy.arn]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = {
    Environment = "development"
  }
}