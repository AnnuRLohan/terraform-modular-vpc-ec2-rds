variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
    description = "EC2 instance type"
    type = string
}

variable "subnet_id" {
    description = "Subnet ID to launch the EC2 in"
    type = string
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
}

variable "key_name" {
    description = "SSH key pair name"
    type = string
}

variable "name_prefix" {
    description = "Prefix for resource names"
    type = string
}

variable "bastion_sg_id" {
    description = "Security group ID of the bastion (public EC2)"
    type = string
}