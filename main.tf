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
    source      = "Terraform"
  }
}
resource "azurerm_virtual_network" "test" {
  name                = "tfgh-cluster-vnet"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks" {
  name                 = "aks"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = ["10.0.0.0/24"]
}

data "azuread_groups" "admins" {
  display_names = ["aks-admin"]
}
