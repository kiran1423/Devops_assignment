provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "aws-s3-bucket-terraform-state-file"
    key            = "demo/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "dynamodb-terraform-state-lock"
    region         = "us-east-1"
  }
}
