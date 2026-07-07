variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-checkov-demo"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "checkovdemostorage"
}

variable "container_name" {
  description = "Name of the storage container for tfstate"
  type        = string
  default     = "tfstate"
}

