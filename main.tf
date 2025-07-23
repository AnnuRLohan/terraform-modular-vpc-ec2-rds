module "vpc" {
  source               = "./modules/vpc"
  vpc_name             = "day8-vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

module "ec2-public" {
  source        = "./modules/ec2-public"
  ami_id        = "ami-0150ccaf51ab55a51"
  subnet_id     = module.vpc.public_subnet_id
  vpc_id        = module.vpc.vpc_id
  instance_type = "t2.micro"
  key_name      = "terraform-key"
  name_prefix   = "day8"
}

module "ec2-private" {
  source        = "./modules/ec2-private"
  ami_id        = "ami-0150ccaf51ab55a51"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  key_name      = "terraform-key"
  name_prefix   = "day8"
  bastion_sg_id = module.ec2-public.sg_id
}

module "rds" {
  source             = "./modules/rds"
  name               = "day8"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.vpc.private_sg_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = var.db_instance_class
}