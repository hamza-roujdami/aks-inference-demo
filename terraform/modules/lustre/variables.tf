# ------------------------------------------------------------------------------
# Lustre Module Variables
# ------------------------------------------------------------------------------

variable "lustre_fs_name" {
  description = "The name of the Azure Managed Lustre file system."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Lustre file system."
  type        = string
}

variable "location" {
  description = "The Azure region where the Lustre file system will be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Lustre file system will be deployed."
  type        = string
}

variable "availability_zones" {
  description = "A list of availability zones for the Lustre file system. Note: Most SKUs only support a single zone."
  type        = list(string)
  default     = ["2"]
}

variable "sku_name" {
  description = "The SKU name for the Lustre file system."
  type        = string
  default     = "AMLFS-Durable-Premium-40"
}

variable "storage_capacity_in_tb" {
  description = "The storage capacity in TiB for the Lustre file system."
  type        = number
  default     = 48
} 