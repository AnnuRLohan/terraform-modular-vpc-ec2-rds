variable "vpc_name" {
    description = "Name of the VPC"
    type = string
}

variable "vpc_cidr" {
   description = "CIDR block for the VPC"
   type = string
}

variable "public_subnet_cidr" {
    description = "CIDR block for the public subnet"
    type = string
}

variable "private_subnet_cidrs" {
    description = "List of CIDRs for private subnets (should be different)"
    type = list(string)
}

variable "availability_zones" {
    description = "List of Availability Zones"
    type = list(string)
}