module "secrets_manager" {
  source = "terraform-aws-modules/secrets-manager/aws"

  name = "development/ticketing-backend"


  ignore_secret_changes = true
  secret_string = jsonencode({
    MYSQL_PASSWORD   = ""
#    PORT: ""
#    MYSQL_HOST: ""
#    MYSQL_PORT: ""
#    MYSQL_USERNAME: ""
#    MYSQL_SCHEMA: ""
#    JWT_SECRET: ""
#    JWT_EXPIRATION_HOURS: ""
#    JWT_ISSUER: ""
  })
}

module "secrets_manager_access_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name          = "secrets-manager-access-policy"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue", 
          "secretsmanager:DescribeSecret"
        ]
        Effect   = "Allow"
        Resource = [
          module.secrets_manager.secret_arn
        ]
      }
    ]
  })
}