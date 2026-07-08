variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-checkov-demo"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "vnet-checkov-demo"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "subnet-checkov-demo"
}

variable "subnet_prefix" {
  description = "Subnet address prefix"
  type        = string
  default     = "10.0.1.0/24"
}

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
  default     = "checkovdemostorage"
}
