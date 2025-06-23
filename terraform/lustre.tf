# Azure Managed Lustre File System
resource "azurerm_managed_lustre_file_system" "lustre" {
  name                   = "${var.aks_cluster_name}-lustre"
  resource_group_name    = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  subnet_id             = azurerm_subnet.lustre.id
  zones                 = ["2"]  # Use a single zone as required
  
  sku_name              = "AMLFS-Durable-Premium-40"  # Premium SKU with 40 MB/s throughput
  storage_capacity_in_tb = 48  # Minimum required storage capacity for AMLFS-Durable-Premium-40 SKU
  
  maintenance_window {
    day_of_week        = "Sunday"
    time_of_day_in_utc = "02:00"
  }

  tags = {
    Environment = "Demo"
    Project     = "AKS-GPU-Demo"
  }
} 