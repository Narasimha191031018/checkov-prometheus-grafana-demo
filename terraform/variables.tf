variable "monitoring_rg" {
  description = "Resource group for monitoring stack"
  type        = string
  default     = "rg-checkov-demo"
}

variable "monitoring_location" {
  description = "Location for monitoring RG"
  type        = string
  default     = "East US"
}

variable "prometheus_cpu" {
  description = "CPU for Prometheus container"
  type        = string
  default     = "1"
}

variable "prometheus_memory" {
  description = "Memory for Prometheus container"
  type        = string
  default     = "1.5"
}

variable "grafana_cpu" {
  description = "CPU for Grafana container"
  type        = string
  default     = "1"
}

variable "grafana_memory" {
  description = "Memory for Grafana container"
  type        = string
  default     = "1.5"
}
