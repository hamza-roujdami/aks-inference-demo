# ------------------------------------------------------------------------------
# Network Module Variables
# ------------------------------------------------------------------------------

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the Virtual Network."
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "The name of the AKS subnet."
  type        = string
}

variable "aks_subnet_prefix" {
  description = "The address prefix for the AKS subnet."
  type        = list(string)
}

variable "lustre_subnet_name" {
  description = "The name of the Lustre subnet."
  type        = string
}

variable "lustre_subnet_prefix" {
  description = "The address prefix for the Lustre subnet."
  type        = list(string)
} 