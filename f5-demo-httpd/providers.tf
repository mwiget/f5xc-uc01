provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
provider "aws" {
  region = "us-west-2"
  alias  = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
provider "azurerm" {
  subscription_id = var.azure_subscription_id != "" ? "" : var.azure_subscription_id
  client_id       = var.azure_client_id != "" ? "" : var.azure_client_id
  client_secret   = var.azure_client_secret != "" ? "" : var.azure_client_secret
  tenant_id       = var.azure_tenant_id != "" ? "" : var.azure_tenant_id
  features {}
}
provider "volterra" {
  api_p12_file = var.f5xc_api_p12_file
  url          = var.f5xc_api_url
}
provider "kubernetes" {
  config_path = "../sites/kubeconfig"
}
