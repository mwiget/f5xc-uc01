terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.35.0"
    }
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.18"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.17.0"
    }
  }
}

