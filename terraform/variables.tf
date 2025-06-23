variable "resource_group" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "francecentral"
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28.3"
}

variable "node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Size of AKS nodes"
  type        = string
  default     = "Standard_NC24ads_A100_v4"  # NcadsA100v4 series
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_name" {
  description = "Name of the AKS subnet"
  type        = string
  default     = "aks-subnet"
}

variable "aks_subnet_prefix" {
  description = "Address prefix for AKS subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "lustre_subnet_name" {
  description = "Name of the Lustre subnet"
  type        = string
  default     = "lustre-subnet"
}

variable "lustre_subnet_prefix" {
  description = "Address prefix for Lustre subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "acr_name" {
  description = "Name of the Azure Container Registry (must be globally unique)"
  type        = string
} 