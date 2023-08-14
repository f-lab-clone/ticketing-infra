# module "bastion" {
#   source  = "terraform-aws-modules/ec2-instance/aws"

#   # ami = "ami-0c9c942bd7bf113a2"
#   name = "bastion"
#   key_name = "bastion"
#   associate_public_ip_address = true
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [module.db_security_group.security_group_id]
#   subnet_id = module.vpc.public_subnets[0]

# }


# module "bastion_security_group" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 5.0"

#   name        = "bastion"
#   description = "security group for bastion host"
#   vpc_id      = module.vpc.vpc_id

#   ingress_cidr_blocks = ["0.0.0.0/0"]
#   ingress_rules       = ["ssh-tcp"]

#   egress_cidr_blocks  = ["0.0.0.0/0"]
#   egress_rules = ["mysql-tcp"]
  
# }