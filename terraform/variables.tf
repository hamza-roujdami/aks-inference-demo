# ------------------------------------------------------------------------------
# Root Variables
# ------------------------------------------------------------------------------
# These are the primary variables you might want to customize for your deployment.
# More detailed configurations and defaults are set within the respective modules.
# ------------------------------------------------------------------------------

variable "resource_group" {
  description = "Name of the resource group for all resources."
  type        = string
  default     = "aks-llm-demo-rg"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "francecentral"
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster. This is used to name other resources as well."
  type        = string
  default     = "aks-llm-demo"
}

variable "acr_name" {
  description = "Globally unique name for the Azure Container Registry."
  type        = string
  # Note: This must be globally unique. A default is provided, but you may need to change it.
  default = "acraksllmdemo"
}

# ------------------------------------------------------------------------------
# Module-level variable overrides (optional)
# ------------------------------------------------------------------------------
# The variables below are passed to the modules. 
# They have defaults set in the root configuration for convenience, 
# but could be customized here if needed.
# ------------------------------------------------------------------------------

variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
  default     = "aks-vnet"
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster."
  type        = string
  default     = "1.28.3"
}

variable "node_count" {
  description = "Initial number of GPU nodes in the AKS cluster."
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "The VM size for the GPU nodes (e.g., A100-based SKU)."
  type        = string
  default     = "Standard_NC24ads_A100_v4"
} 