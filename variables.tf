variable "aws_region" {
  description = "The AWS region to deploy the EC2 instance into"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_id" {
  description = "The VPC to deploy the EC2 instance into"
  type        = string
}

variable "subnet" {
  description = "The subnet to deploy the EC2 instance into"
  type        = string
}

variable "default_tag" {
  type    = string
  default = "terraform_ec2_ansible_provider"
}

variable "self_ip_address" {
  type = string
}