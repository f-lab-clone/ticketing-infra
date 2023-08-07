module "eks_iam_user1" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "junha_ahn"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}

module "eks_iam_user2" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "hihahayoung"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}

module "eks_iam_user3" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "littlejsp"
  create_iam_access_key         = false
  create_iam_user_login_profile = false

  force_destroy = true
}