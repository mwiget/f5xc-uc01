provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
provider "aws" {
  region = "us-east-2"
  alias  = "us-east-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
provider "aws" {
  region = "us-west-2"
  alias  = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
provider "aws" {
  region = "eu-north-1"
  alias  = "eu-north-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
provider "aws" {
  region = "eu-west-1"
  alias  = "eu-west-1"
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
provider "google" {
  region      = "us-east1"
  alias       = "us-east1"
  project     = var.gcp_project_id
}
provider "google" {
  region      = "europe-west6"
  alias       = "europe-west6"
  project     = var.gcp_project_id
}
provider "volterra" {
  api_p12_file = var.f5xc_api_p12_file
  url          = var.f5xc_api_url
  timeout      = "30s"
}
provider "vsphere" {
  user                  = var.vsphere_user
  password              = var.vsphere_password
  vsphere_server        = var.vsphere_server
  allow_unverified_ssl  = true
}
provider "restapi" {
  uri = var.f5xc_api_url
  create_returns_object = true
  headers = {                   
    Authorization = format("APIToken %s", var.f5xc_api_token)   
    Content-Type  = "application/json"
  }
}
