module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  ami = local.ubuntu_22_ami
  name = "bastion"
  key_name = module.key_pair.key_pair_name
  associate_public_ip_address = true
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.bastion_security_group.security_group_id]
  subnet_id = module.vpc.public_subnets[0]
}


module "bastion_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "bastion"
  description = "security group for bastion host"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      cidr_blocks = "0.0.0.0/0"
    }
  ] 
  egress_with_cidr_blocks = [
    {
      from_port   = 3306                
      to_port     = 3306              
      protocol    = "tcp"          
      description = "mysql"                    
      cidr_blocks = "0.0.0.0/0"                   
    }
  ]
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  key_name           = "bastion"
  create_private_key = true
}

resource "local_file" "private_key_pem" {
    content  = module.key_pair.private_key_pem
    filename = "bastion.pem"
}
