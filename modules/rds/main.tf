resource "aws_db_subnet_group" "rds" {
    name = "${var.name}-subnet-group"
    subnet_ids = var.private_subnet_ids

    tags = {
        Name = "${var.name}-rds-subnet-group"
        VPC_ID = var.vpc_id
    }
}

resource "aws_db_instance" "mysql" {
    identifier = "${var.name}-mysql"
    allocated_storage = 20
    engine = "mysql"
    engine_version = "8.0"
    instance_class = var.db_instance_class
    db_name = var.db_name
    username = var.db_username
    password = var.db_password
    db_subnet_group_name = aws_db_subnet_group.rds.name
    vpc_security_group_ids = [var.security_group_id]
    skip_final_snapshot = true
    publicly_accessible = false

    tags = {
        Name = "${var.name}-mysql"
    }
}