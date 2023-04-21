module "spoke11" {
  source          = "./aws"
  vpc_name        = format("%s-spoke11", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "10.10.1.0/24"
  owner_tag       = var.owner_tag
  bastion_cidr    = var.bastion_cidr
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "10.10.1.0/26" },
    { availability_zone = "b", cidr_block = "10.10.1.64/26" },
    { availability_zone = "c", cidr_block = "10.10.1.128/26" }
  ]
  aws_region      = "us-west-2"
  providers       = {
    aws           = aws.us-west-2
  }
}

module "spoke12" {
  source          = "./aws"
  vpc_name        = format("%s-spoke12", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "10.200.2.0/24"
  owner_tag       = var.owner_tag
  bastion_cidr    = var.bastion_cidr
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "10.200.2.0/26" },
    { availability_zone = "b", cidr_block = "10.200.2.64/26" },
    { availability_zone = "c", cidr_block = "10.200.2.128/26" }
  ]
  aws_region      = "us-west-2"
  providers       = {
    aws           = aws.us-west-2
  }
}

output "spoke11" {
  value = module.spoke11
}
output "spoke12" {
 value = module.spoke12
}

