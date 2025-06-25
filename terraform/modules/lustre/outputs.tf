# ------------------------------------------------------------------------------
# Lustre Module Outputs
# ------------------------------------------------------------------------------

output "id" {
  description = "The ID of the Azure Managed Lustre file system."
  value       = azurerm_managed_lustre_file_system.lustre.id
} 