output "prometheus_url" {
  description = "Prometheus public URL"
  value       = "http://${azurerm_container_group.prometheus.ip_address}:9090"
}

output "grafana_url" {
  description = "Grafana public URL"
  value       = "http://${azurerm_container_group.grafana.ip_address}:3000"
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.demo.name
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.demo.name
}
