module "wl-us-west-2" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets.subnets:  subnet.subnet_name => subnet if "us-west-2" == substr(subnet.availability_zone,0,9)}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  custom_vip_cidr   = "10.10.10.0/24"
  ssh_public_key    = var.ssh_public_key
  service           = "workload-prod"
  consul_hostname   = "http.consul"
  consul_vip        = "10.10.10.10"
  owner_tag         = "m.wiget@f5.com"
  providers         = {
    aws             = aws.us-west-2
  }
}

module "wl-us-east-1" {
  source            = "./instance"
  for_each          = {for subnet in local.subnets.subnets:  subnet.subnet_name => subnet if "us-east-1" == substr(subnet.availability_zone,0,9)}
  availability_zone = each.value.availability_zone
  site_name         = each.value.subnet_name
  subnet_name       = each.value.subnet_name
  subnet_id         = each.value.subnet_id
  vpc_id            = each.value.vpc_id
  security_group_id = each.value.security_group_id
  instance_type     = "t3.nano"
  custom_vip_cidr   = "10.10.10.0/24"
  ssh_public_key    = var.ssh_public_key
  service           = "workload-prod"
  consul_hostname   = "http.consul"
  consul_vip        = "10.10.10.10"
  owner_tag         = "m.wiget@f5.com"
  providers         = {
    aws             = aws.us-east-1
  }
}

output "wl-us-west-2" {
  value = module.wl-us-west-2
}
output "wl-us-east-1" {
  value = module.wl-us-east-1
}
