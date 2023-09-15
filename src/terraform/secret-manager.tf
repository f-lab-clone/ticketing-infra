resource "helm_release" "secrets-store-csi-driver" {
  chart            = "secrets-store-csi-driver"
  name             = "csi-secrets-store"
  namespace        = "kube-system"
  repository       = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"

  set {
    name  = "syncSecret.enabled"
    value = "true"
  }
}
resource "helm_release" "secrets-store-csi-driver-provider-aws" {
  chart            = "secrets-store-csi-driver-provider-aws"
  name             = "secrets-provider-aws"
  namespace        = "kube-system"
  repository       = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
}

module "secrets_manager" {
  source = "terraform-aws-modules/secrets-manager/aws"

  name = "ye/ticketing-backend-secret"


  ignore_secret_changes = true
  secret_string = jsonencode({
    MYSQL_PASSWORD = ""
    MYSQL_USERNAME = ""
    MYSQL_HOST = ""
    MYSQL_PORT = ""
    MYSQL_SCHEMA = ""
    JWT_SECRET = ""
    JWT_EXPIRATION_HOURS = ""
    JWT_ISSUER = ""
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