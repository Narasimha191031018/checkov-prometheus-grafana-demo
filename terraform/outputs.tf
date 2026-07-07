output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.demo.name
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.demo.name
}

output "prometheus_url" {
  description = "Public IP/URL for Prometheus"
  value       = azurerm_container_group.prometheus.ip_address[0].ip
}

output "grafana_url" {
  description = "Public IP/URL for Grafana"
  value       = azurerm_container_group.grafana.ip_address[0].ip
}

