#Block-1: **Terraform Settings Block**
terraform {
  required_version = "~> 1.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

backend "s3" {
    bucket = "terraform-eks-bucket1"
    key    = "prod/terraform.tfstate"
    region = "us-west-2"
    # For State Locking
    dynamodb_table = "terraform-lock"
  }
}

resource "aws_dynamodb_table" “tf_lock" {
  name = "terraform-lock"
  hash_key = "LockID"
  read_capacity = 3
  write_capacity = 3
  attribute {
     name = "LockID"
     type = "S"
   }
  tags  {
    Name = "Terraform Lock Table"
   }
 }
