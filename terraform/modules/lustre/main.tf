# ------------------------------------------------------------------------------
# Azure Managed Lustre Module
# ------------------------------------------------------------------------------

# This module creates an Azure Managed Lustre file system.
# It requires a dedicated subnet and is configured for high-performance workloads.

resource "azurerm_managed_lustre_file_system" "lustre" {
  name                = var.lustre_fs_name
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id
  zones               = var.availability_zones

  sku_name               = var.sku_name
  storage_capacity_in_tb = var.storage_capacity_in_tb

  maintenance_window {
    day_of_week        = "Sunday"
    time_of_day_in_utc = "02:00"
  }

  tags = {
    Environment = "Demo"
    Project     = "AKS-GPU-Demo"
  }
} 