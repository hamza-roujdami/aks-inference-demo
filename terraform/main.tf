# ------------------------------------------------------------------------------
# Resource Group
# ------------------------------------------------------------------------------

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}

# ------------------------------------------------------------------------------
# Modules
# ------------------------------------------------------------------------------

module "network" {
  source = "./modules/network"

  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  vnet_name            = var.vnet_name
  vnet_address_space   = ["10.0.0.0/16"]
  aks_subnet_name      = "aks-subnet"
  aks_subnet_prefix    = ["10.0.1.0/24"]
  lustre_subnet_name   = "lustre-subnet"
  lustre_subnet_prefix = ["10.0.2.0/24"]
}

module "lustre" {
  source = "./modules/lustre"

  lustre_fs_name      = "${var.aks_cluster_name}-lustre"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  subnet_id           = module.network.lustre_subnet_id

  # The following variables use defaults specified in the module
  # sku_name               = "AMLFS-Durable-Premium-40"
  # storage_capacity_in_tb = 48
  # availability_zones     = ["2"]
}

module "aks" {
  source = "./modules/aks"

  cluster_name        = var.aks_cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  kubernetes_version  = var.kubernetes_version
  vnet_subnet_id      = module.network.aks_subnet_id
  node_count          = var.node_count
  vm_size             = var.vm_size
  acr_name            = var.acr_name
} 