module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "ticketing-backend-ecr"

  repository_image_tag_mutability = "MUTABLE"
  repository_force_delete = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 10 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 10
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

module "ecr-queuing" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "ticketing-queuing-ecr"

  repository_image_tag_mutability = "MUTABLE"
  repository_force_delete = true

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 10 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 10
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