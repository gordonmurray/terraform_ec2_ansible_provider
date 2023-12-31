terraform {

  required_version = "1.5.6"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"

    }

    ansible = {
      version = "1.1.0"
      source  = "ansible/ansible"
    }

  }

}

# Configure the AWS Provider
provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "gordonmurray"

  default_tags {
    tags = {
      Repo = "https://github.com/gordonmurray/terraform_ec2_ansible_provider"
    }
  }
}
