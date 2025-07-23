variable "name" {
  description = "Prefix for naming AWS resources"
  type        = string
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}
variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}
variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}
variable "db_instance_class" {
  description = "RDS instance type (e.g., db.t3.micro)"
  type        = string
}
