# AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_cluster_name
  kubernetes_version  = var.kubernetes_version
  sku_tier           = "Premium"  # Required for 1.28 and multi-zone deployments
  support_plan       = "AKSLongTermSupport"      # Enable LTS support plan for AKS 1.28.x

  default_node_pool {
    name                = "gpupool"
    node_count          = var.node_count
    vm_size            = var.vm_size
    vnet_subnet_id     = azurerm_subnet.aks.id
    zones              = ["2", "3"]  # NcadsA100v4 is only available in zones 2 and 3
    
    # Enable auto-scaling
    enable_auto_scaling = true
    min_count          = var.node_count
    max_count          = 4  # Adjust based on your needs
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = "10.1.0.0/16"
    dns_service_ip    = "10.1.0.10"
  }

  tags = {
    Environment = "Demo"
    Project     = "AKS-GPU-Demo"
  }
}

# Container Registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                = "Standard"
  admin_enabled      = true
}

# Role assignment for AKS to pull images from ACR
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
} 