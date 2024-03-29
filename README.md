# Creating DynamoDB Table on AWS by Terraform via Github Actions

## Introduction
Creating a [DynamoDB](https://youtu.be/sI-zciHAh-4) table on the AWS cloud with Terraform for use with other serverless applications. In this DynamoDB table contains partition key, sort key and a Time to Live (TTL) attribute. The Capacity mode is set as On-demand. 

This repository uses the GitHub CI/CD pipeline to deploy DynamoDB on AWS.

## Workflow
The [main.yml](https://github.com/kusumsiri/Terraform-Dynamodb/blob/main/.github/workflows/main.yml) file handles the CD process. It contains several steps as follows.
1. `aws-actions/configure-aws-credentials@v1` This provides AWS credentials for virtual environments hosted on GitHub (Runners).
2. `actions/checkout@v2` Checkout the code from Git repository
3. `hashicorp/setup-terraform@v2` sets up Terraform CLI in workflow
4. `Terraform Init` initializes working directory
5. `Terraform Validate` validate the configuration internally
6. `Terraform Plan` creates the execution plan
7. `Terraform Apply` executes the actions

## Locking the Terraform state file
By default, Terraform stores state locally in `terraform.tfstate` file. When working with Terraform in a team, use of a local file makes Terraform usage complicated because each user must make sure they always have the latest state data before running Terraform and make sure that nobody else runs Terraform at the same time.

With remote state, Terraform writes the state data to a remote data store (In this case S3), which can then be shared between all members of a team. With support of DynamoDB, Terraform will lock state for all operations. This prevents others from acquiring the lock and potentially corrupting state.
