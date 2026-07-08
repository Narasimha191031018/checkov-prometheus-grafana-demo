output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.demo.name
}

output "storage_container_name" {
  description = "Name of the storage container"
  value       = azurerm_storage_container.tfstate.name
}

output "prometheus_url" {
  description = "Prometheus endpoint URL"
  value       = "http://${azurerm_container_group.prometheus.container[0].name}.${var.location}.azurecontainer.io:9090"
}

output "grafana_url" {
  description = "Grafana endpoint URL"
  value       = "http://${azurerm_container_group.grafana.container[0].name}.${var.location}.azurecontainer.io:3000"
}
