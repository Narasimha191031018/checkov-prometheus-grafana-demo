terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"   # latest stable provider
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "demo" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
}

resource "azurerm_subnet" "demo" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.demo.name
  virtual_network_name = azurerm_virtual_network.demo.name
  address_prefixes     = [var.subnet_prefix]
}

resource "azurerm_storage_account" "demo" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false   # correct property for v3.x
  public_network_access_enabled   = false

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 7
    }
  }
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

  subnet_ids = [azurerm_subnet.demo.id]
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

  subnet_ids = [azurerm_subnet.demo.id]
}
