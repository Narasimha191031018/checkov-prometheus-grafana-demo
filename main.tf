provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-checkov-demo"
    storage_account_name = "checkovdemostorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "demo" {
  name     = "rg-checkov-demo"
  location = "East US"
}

resource "azurerm_storage_account" "demo" {
  name                     = "checkovdemostorage"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

