module "spoke11" {
  source          = "./aws"
  vpc_name        = format("%s-spoke11", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "172.16.16.0/22"
  owner_tag       = var.owner_tag
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "172.16.16.0/24" },
    { availability_zone = "b", cidr_block = "172.16.17.0/24" },
    { availability_zone = "c", cidr_block = "172.16.18.0/24" }
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
  vpc_cidr        = "172.16.20.0/22"
  owner_tag       = var.owner_tag
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "172.16.20.0/24" },
    { availability_zone = "b", cidr_block = "172.16.21.0/24" },
    { availability_zone = "c", cidr_block = "172.16.22.0/24" }
  ]
  aws_region      = "us-west-2"
  providers       = {
    aws           = aws.us-west-2
  }
}

module "spoke21" {
  source          = "./aws"
  vpc_name        = format("%s-spoke21", var.project_prefix)
  project_prefix  = var.project_prefix
  vpc_cidr        = "172.16.24.0/22"
  owner_tag       = var.owner_tag
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "172.16.24.0/24" },
    { availability_zone = "b", cidr_block = "172.16.25.0/24" },
    { availability_zone = "c", cidr_block = "172.16.26.0/24" }
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
  vpc_cidr        = "172.16.28.0/22"
  owner_tag       = var.owner_tag
  vpc_subnets     = [
    { availability_zone = "a", cidr_block = "172.16.28.0/24" },
    { availability_zone = "b", cidr_block = "172.16.29.0/24" },
    { availability_zone = "c", cidr_block = "172.16.30.0/24" }
  ]
  aws_region      = "us-east-1"
  providers       = {
    aws           = aws.us-east-1
  }
}

