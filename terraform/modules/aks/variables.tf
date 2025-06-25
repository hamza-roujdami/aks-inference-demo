# ------------------------------------------------------------------------------
# AKS Module Variables
# ------------------------------------------------------------------------------

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster."
  type        = string
}

variable "vnet_subnet_id" {
  description = "The subnet ID for the AKS node pool."
  type        = string
}

variable "node_count" {
  description = "The initial number of nodes for the AKS cluster."
  type        = number
  default     = 2
}

variable "max_node_count" {
  description = "The maximum number of nodes for auto-scaling."
  type        = number
  default     = 4
}

variable "vm_size" {
  description = "The size of the virtual machines to use for the nodes."
  type        = string
}

variable "availability_zones" {
  description = "The availability zones for the AKS node pool."
  type        = list(string)
  default     = ["2", "3"]
}

variable "service_cidr" {
  description = "The CIDR notation for the Kubernetes service address range."
  type        = string
  default     = "10.1.0.0/16"
}

variable "dns_service_ip" {
  description = "The IP address for the Kubernetes DNS service."
  type        = string
  default     = "10.1.0.10"
}

variable "acr_name" {
  description = "The globally unique name for the Azure Container Registry."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default = {
    Environment = "Demo"
    Project     = "AKS-GPU-Demo"
  }
} 