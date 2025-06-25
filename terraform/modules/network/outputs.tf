# ------------------------------------------------------------------------------
# Network Module Outputs
# ------------------------------------------------------------------------------

output "vnet_id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  description = "The ID of the AKS subnet."
  value       = azurerm_subnet.aks.id
}

output "lustre_subnet_id" {
  description = "The ID of the Lustre subnet."
  value       = azurerm_subnet.lustre.id
} 