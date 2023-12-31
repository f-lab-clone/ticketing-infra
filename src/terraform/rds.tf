module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "ticketingdb"

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t3.micro"

  db_name  = "ticketingdb"
  username = "root"
  port     = 3306
  manage_master_user_password = true

  allocated_storage     = 20
  max_allocated_storage = 40

  iam_database_authentication_enabled = true

  create_db_subnet_group = true
  subnet_ids = module.vpc.private_subnets

  vpc_security_group_ids = [module.db_security_group.security_group_id]
  
  skip_final_snapshot = true
  deletion_protection = false

  create_cloudwatch_log_group = false
  enabled_cloudwatch_logs_exports = []

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    },
    {
      name  = "collation_server"
      value = "utf8mb4_unicode_ci"
      apply_method = "pending-reboot"
    },
    {
      name  = "skip-character-set-client-handshake"
      value = "1"
      apply_method = "pending-reboot"
    },
    {
      name  = "slow_query_log"
      value = "1"
    },
    {
      name  = "long_query_time"
      value = "1"
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
    }
  ]
}