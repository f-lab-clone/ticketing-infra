# Set the Terraform version
terraform {
  backend "s3" {
    bucket = "tfstate-bucket-ticketing-infra"
    key = "global/s3/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
  # backend "local" {}

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "= 4.67.0"
      }
  }

  required_version = "~> 1.0"
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "tfstate"{
 bucket = "tfstate-bucket-ticketing-infra"

 lifecycle {
  prevent_destroy = false
 }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
 name = "terraform-state-locking"
 billing_mode = "PAY_PER_REQUEST"
 hash_key = "LockID"

 attribute{
  name = "LockID"
  type = "S"
 }
}