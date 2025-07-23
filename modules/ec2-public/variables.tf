variable "ami_id" {
    description = "AMI ID for EC2 instance"
    type = string
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
    description = "Name of the SSH key pair"
    type = string
}

variable "name_prefix" {
    description = "Prefix for naming EC2 and SG"
    type = string
}