terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.34.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.41.0"
    }
    google = {
      source = "hashicorp/google"
      version = ">= 4.63.1"
    }
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.21"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.17.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.3.1"
    }
    restapi = {
      source = "Mastercard/restapi"
      version = "1.18.0"
    }
  }
}

