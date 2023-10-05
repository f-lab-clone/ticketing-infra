module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "main"
  cidr = "10.0.0.0/16"

  azs             = ["ap-northeast-2a", "ap-northeast-2b"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"]

  map_public_ip_on_launch = true
  enable_nat_gateway = false
  
  tags = {
    Environment = "development"
  }
}