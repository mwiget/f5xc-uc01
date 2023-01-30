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
  features {}
  alias  = "azurerm"
}
provider "volterra" {
  api_p12_file = var.f5xc_api_p12_file
  url          = var.f5xc_api_url
}

