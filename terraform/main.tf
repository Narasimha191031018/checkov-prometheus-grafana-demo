provider "azurerm" {
  features {}
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

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.demo.name
  container_access_type = "private"
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-checkov-demo"
#     storage_account_name = "checkovdemostorage"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#   }
# }

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

  ip_address_type = "Public"

  exposed_ports {
    port     = 9090
    protocol = "TCP"
  }
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

  ip_address_type = "Public"

  exposed_ports {
    port     = 3000
    protocol = "TCP"
  }
}
