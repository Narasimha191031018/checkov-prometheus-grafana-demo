output "prometheus_url" {
  description = "Public URL for Prometheus"
  value       = "http://${azurerm_container_group.prometheus.fqdn}:9090"
}

output "grafana_url" {
  description = "Public URL for Grafana"
  value       = "http://${azurerm_container_group.grafana.fqdn}:3000"
}
