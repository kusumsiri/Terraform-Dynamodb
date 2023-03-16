terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
       version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "myDynamo_table" {
    name    = "my-dynamo-table-example"
    hash_key    = "email"
    billing_mode    = "PAY_PER_REQUEST"
}
