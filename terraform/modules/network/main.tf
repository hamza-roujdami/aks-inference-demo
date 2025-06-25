# ------------------------------------------------------------------------------
# VNet and Subnets Module
# ------------------------------------------------------------------------------

# This module creates a virtual network and two subnets:
# 1. AKS Subnet: For the Kubernetes cluster nodes.
# 2. Lustre Subnet: For the Azure Managed Lustre filesystem.

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
}

# AKS Subnet
resource "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.aks_subnet_prefix
}

# Lustre Subnet
resource "azurerm_subnet" "lustre" {
  name                 = var.lustre_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.lustre_subnet_prefix
} 