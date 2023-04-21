module "spoke21" {
  source          = "./aws"
  vpc_name        = format("%s-spoke21", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "10.100.5.0/24"
  owner_tag       = var.owner_tag
  bastion_cidr    = var.bastion_cidr
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "10.100.5.0/26" },
    { availability_zone = "b", cidr_block = "10.100.5.64/26" },
    { availability_zone = "c", cidr_block = "10.100.5.128/26" }
  ]
  aws_region      = "us-east-1"
  providers       = {
    aws           = aws.us-east-1
  }
}

module "spoke22" {
  source          = "./aws"
  vpc_name        = format("%s-spoke22", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "10.100.6.0/24"
  owner_tag       = var.owner_tag
  bastion_cidr    = var.bastion_cidr
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "10.100.6.0/26" },
    { availability_zone = "b", cidr_block = "10.100.6.64/26" },
    { availability_zone = "c", cidr_block = "10.100.6.128/26" }
  ]
  aws_region      = "us-east-1"
  providers       = {
    aws           = aws.us-east-1
  }
}

output "spoke21" {
  value = module.spoke21
}
output "spoke22" {
  value = module.spoke22
}
