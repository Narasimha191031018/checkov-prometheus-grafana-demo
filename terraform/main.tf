terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-backend"       # backend RG (manual)
    storage_account_name = "tfstatecheckovstorage"    # manually created storage account
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "monitoring" {
  name = var.monitoring_rg
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

resource "azurerm_container_group" "prometheus" {
  name                = "prometheus-demo"
  location            = data.azurerm_resource_group.monitoring.location
  resource_group_name = data.azurerm_resource_group.monitoring.name
  os_type             = "Linux"

  container {
    name   = "prometheus"
    image  = "prom/prometheus"
    cpu    = var.prometheus_cpu
    memory = var.prometheus_memory

    ports {
      port     = 9090
      protocol = "TCP"
    }
  }

  ip_address_type = "Public"
  dns_name_label  = "prometheus-demo-${random_integer.suffix.result}"
  exposed_ports {
    port     = 9090
    protocol = "TCP"
  }
}

resource "azurerm_container_group" "grafana" {
  name                = "grafana-demo"
  location            = data.azurerm_resource_group.monitoring.location
  resource_group_name = data.azurerm_resource_group.monitoring.name
  os_type             = "Linux"

  container {
    name   = "grafana"
    image  = "grafana/grafana"
    cpu    = var.grafana_cpu
    memory = var.grafana_memory

    ports {
      port     = 3000
      protocol = "TCP"
    }
  }

  ip_address_type = "Public"
  dns_name_label  = "grafana-demo-${random_integer.suffix.result}"
  exposed_ports {
    port     = 3000
    protocol = "TCP"
  }
}
