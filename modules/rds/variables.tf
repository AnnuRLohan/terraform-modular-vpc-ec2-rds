variable "name" {
    description = "Prefix for resource names"
    type = string
}

variable "private_subnet_ids" {
    description = "List of private subnet IDs for RDS subnet group"
    type = list(string)
}

variable "db_name" {
    description = "Name of the database"
    type = string
}

variable "db_username" {
    description = "Master Username"
    type = string
}

variable "db_password" {
    description = "Master Password"
    type = string
    sensitive = true
}

variable "db_instance_class" {
    description = "RDS instance type (e.g., db.t3.micro)"
    type = string
}

variable "security_group_id" {
    description = "Security group ID to attach to RDS"
    type = string
}

variable "vpc_id" {
    description = "The VPC ID to launch RDS in"
    type = string
}