terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.18"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.43.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.17.0"
    }

    ct = {
      source  = "poseidon/ct"
      version = ">= 0.11.0"
    }

    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}
