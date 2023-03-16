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
    name        = "terraform-table-example"
    hash_key    = "email"
    range_key   = "reminder_title"
    billing_mode= "PAY_PER_REQUEST"

    attribute {
      name = "email"
      type = "S"
    }

    attribute {
      name = "reminder_title"
      type = "S"
    }

    ttl {
      attribute_name = "remindTime"
      enabled = true
    }
}
