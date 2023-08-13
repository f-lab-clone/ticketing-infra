module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "ticketingdb"

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t2.micro"

  db_name  = "ticketingdb"
  username = "ticketing_db"
  port     = 3306

  allocated_storage     = 2
  max_allocated_storage = 10

  iam_database_authentication_enabled = true

  # multi_az               = true
  # db_subnet_group_name   = aws_db_subnet_group.private.name
  subnet_ids = [module.vpc.private_subnets[0]]
  vpc_security_group_ids = [module.db_security_group.security_group_id]

  skip_final_snapshot = true
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}

module "db_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "ticketingdb"
  description = "security group for ticketing MySQL db"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]
}