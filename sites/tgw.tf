module "tgw1" {
  source                         = "./modules/f5xc/site/aws/tgw"
  f5xc_tenant                    = var.f5xc_tenant
  f5xc_api_url                   = var.f5xc_api_url
  f5xc_aws_cred                  = var.f5xc_aws_cred
  f5xc_namespace                 = var.f5xc_namespace
  f5xc_api_token                 = var.f5xc_api_token
  f5xc_aws_region                = "us-west-2"
  f5xc_aws_tgw_name              = format("%s-tgw1", var.project_prefix)
  f5xc_aws_tgw_owner             = var.owner_tag
  f5xc_aws_default_ce_sw_version = true
  f5xc_aws_default_ce_os_version = true
  f5xc_aws_tgw_no_worker_nodes   = true
  f5xc_aws_tgw_primary_ipv4      = "192.168.168.0/21"
  f5xc_aws_tgw_az_nodes          = {
    node0 : {
      f5xc_aws_tgw_workload_subnet = "192.168.168.0/26",
      f5xc_aws_tgw_inside_subnet   = "192.168.168.64/26",
      f5xc_aws_tgw_outside_subnet  = "192.168.168.128/26",
      f5xc_aws_tgw_az_name         = "us-west-2a"
    },
    node1 : {
      f5xc_aws_tgw_workload_subnet = "192.168.169.0/26",
      f5xc_aws_tgw_inside_subnet   = "192.168.169.64/26",
      f5xc_aws_tgw_outside_subnet  = "192.168.169.128/26",
      f5xc_aws_tgw_az_name         = "us-west-2b"
    },
    node2 : {
      f5xc_aws_tgw_workload_subnet = "192.168.170.0/26",
      f5xc_aws_tgw_inside_subnet   = "192.168.170.64/26",
      f5xc_aws_tgw_outside_subnet  = "192.168.170.128/26",
      f5xc_aws_tgw_az_name         = "us-west-2c"
    }
  }
  f5xc_aws_tgw_direct_connect_disabled = false
  f5xc_aws_tgw_direct_connect_standard_vifs = true
  f5xc_aws_tgw_direct_connect_custom_asn = 64555

  f5xc_aws_vpc_attachment_ids = [
    module.spoke11.vpc.id,
    module.spoke12.vpc.id
  ]

  f5xc_aws_tgw_labels = {
    "site-mesh" = var.project_prefix,
  }

  ssh_public_key = var.ssh_public_key
  custom_tags    = local.custom_tags
  providers      = {
    aws      = aws.us-west-2
  }
}

module "tgw2" {
  source                         = "./modules/f5xc/site/aws/tgw"
  f5xc_tenant                    = var.f5xc_tenant
  f5xc_api_url                   = var.f5xc_api_url
  f5xc_aws_cred                  = var.f5xc_aws_cred
  f5xc_namespace                 = var.f5xc_namespace
  f5xc_api_token                 = var.f5xc_api_token
  f5xc_aws_region                = "us-east-1"
  f5xc_aws_tgw_name              = format("%s-tgw2", var.project_prefix)
  f5xc_aws_tgw_owner             = var.owner_tag
  f5xc_aws_default_ce_sw_version = true
  f5xc_aws_default_ce_os_version = true
  f5xc_aws_tgw_no_worker_nodes   = true
  f5xc_aws_tgw_primary_ipv4      = "192.168.176.0/21"
  f5xc_aws_tgw_az_nodes          = {
    node0 : {
      f5xc_aws_tgw_workload_subnet = "192.168.176.0/26",
      f5xc_aws_tgw_inside_subnet   = "192.168.176.64/26",
      f5xc_aws_tgw_outside_subnet  = "192.168.176.128/26",
      f5xc_aws_tgw_az_name         = "us-east-1a"
    },
    node1 : {
      f5xc_aws_tgw_workload_subnet = "192.168.177.0/26",
      f5xc_aws_tgw_inside_subnet   = "192.168.177.64/26",
      f5xc_aws_tgw_outside_subnet  = "192.168.177.128/26",
      f5xc_aws_tgw_az_name         = "us-east-1b"
    },
    node2 : {
      f5xc_aws_tgw_workload_subnet = "192.168.178.0/26",
      f5xc_aws_tgw_inside_subnet   = "192.168.178.64/26",
      f5xc_aws_tgw_outside_subnet  = "192.168.178.128/26",
      f5xc_aws_tgw_az_name         = "us-east-1c"
    }
  }

  f5xc_aws_vpc_attachment_ids = [
    module.spoke21.vpc.id,
    module.spoke22.vpc.id
  ]

  f5xc_aws_tgw_labels = {
    "site-mesh" = var.project_prefix
  }

  ssh_public_key = var.ssh_public_key
  custom_tags    = local.custom_tags
  providers      = {
    aws      = aws.us-east-1
  }
}

locals {
  custom_tags = {
    Owner        = var.owner_tag
    f5xc-tenant  = var.f5xc_tenant
    f5xc-feature = "f5xc-uc01"
  }
}
