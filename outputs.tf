output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_ec2_public_ip" {
  value = module.ec2-public.public_ip
}

output "private_ec2_id" {
  value = module.ec2-private.ec2_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}