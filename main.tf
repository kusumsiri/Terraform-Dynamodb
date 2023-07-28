terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         	   = "terraform-state-kusumsiri" 
    key              	 = "state_1/terraform.tfstate"
    region         	   = "us-east-1"
    encrypt        	   = true
    dynamodb_table     = "terraform-state-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "state_locking" {
  hash_key = "LockID"
  name     = "terraform-state-locking"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}

resource "aws_dynamodb_table" "DynamoDB_reminder-app" {
    name        = var.table_name
    hash_key    = "email"
    range_key   = "reminder_title"
    billing_mode= "PAY_PER_REQUEST"
    stream_enabled   = true
    stream_view_type = "NEW_AND_OLD_IMAGES"

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
