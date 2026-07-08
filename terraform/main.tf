terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo" {
  name     = "rg-checkov-demo"
  location = "East US"
}

resource "azurerm_virtual_network" "demo" {
  name                = "vnet-checkov-demo"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
}

resource "azurerm_subnet" "demo" {
  name                 = "subnet-checkov-demo"
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_storage_account" "demo" {
  name                     = "checkovdemostorage"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.demo.name
  container_access_type = "private"
}

resource "azurerm_container_group" "prometheus" {
  name                = "prometheus-demo"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  os_type             = "Linux"

  container {
    name   = "prometheus"
    image  = "prom/prometheus"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 9090
      protocol = "TCP"
    }
  }

  ip_address_type = "Private"
  subnet_ids      = [azurerm_subnet.demo.id]
}

resource "azurerm_container_group" "grafana" {
  name                = "grafana-demo"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  os_type             = "Linux"

  container {
    name   = "grafana"
    image  = "grafana/grafana"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  ip_address_type = "Private"
  subnet_ids      = [azurerm_subnet.demo.id]
}
