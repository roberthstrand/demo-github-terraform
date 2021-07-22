terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.68.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "demo-github-terraform"
    storage_account_name = "rsdemogithubterraform"
    container_name       = "tfstate"
    key                  = "production.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "test-deploy-rg"
  location = "Norway East"

  tags = {
    environment = "Production"
    source = "Terraform"
  }
}
