output "prometheus_url" {
  description = "Public URL for Prometheus"
  value       = "http://${azurerm_container_group.prometheus.ip_address[0].fqdn}:9090"
}

output "grafana_url" {
  description = "Public URL for Grafana"
  value       = "http://${azurerm_container_group.grafana.ip_address[0].fqdn}:3000"
}
