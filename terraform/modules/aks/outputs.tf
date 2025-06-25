# ------------------------------------------------------------------------------
# AKS Module Outputs
# ------------------------------------------------------------------------------

output "cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "acr_login_server" {
  description = "The FQDN of the Azure Container Registry."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_id" {
  description = "The ID of the Azure Container Registry."
  value       = azurerm_container_registry.acr.id
}

output "kube_config" {
  description = "The raw Kubernetes configuration file for the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
} 