# ------------------------------------------------------------------------------
# Root Outputs
# ------------------------------------------------------------------------------
# These outputs provide useful information about the created resources.
# They reference the outputs from the modules.
# ------------------------------------------------------------------------------

output "aks_cluster_name" {
  description = "The name of the deployed AKS cluster."
  value       = module.aks.cluster_name
}

output "acr_login_server" {
  description = "The login server for the deployed Azure Container Registry."
  value       = module.aks.acr_login_server
}

output "kube_config" {
  description = "The raw Kubernetes configuration file for the AKS cluster."
  value       = module.aks.kube_config
  sensitive   = true
} 