# ------------------------------------------------------------------------------
# AKS Cluster, ACR, and Role Assignment Module
# ------------------------------------------------------------------------------

# This module provisions:
# 1. An Azure Kubernetes Service (AKS) cluster with a GPU-enabled node pool.
# 2. An Azure Container Registry (ACR) for storing Docker images.
# 3. A role assignment to allow AKS to pull images from ACR.

# ------------------------------------------------------------------------------
# AKS Cluster
# ------------------------------------------------------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  sku_tier            = "Premium"
  support_plan        = "AKSLongTermSupport"

  default_node_pool {
    name                = "gpupool"
    node_count          = var.node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = var.vnet_subnet_id
    zones               = var.availability_zones
    enable_auto_scaling = true
    min_count           = var.node_count
    max_count           = var.max_node_count
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

  tags = var.tags
}

# ------------------------------------------------------------------------------
# Container Registry (ACR)
# ------------------------------------------------------------------------------
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
}

# ------------------------------------------------------------------------------
# Role Assignment for AKS to pull from ACR
# ------------------------------------------------------------------------------
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
} 