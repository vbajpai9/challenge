/*
Purpose: This module creates a virtual network including subnets and peer with other Vnet(s)
Author : Nitish
organization: Deloitte CMS
*/

# Create virtual network
resource "azurerm_virtual_network" "tf-vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.address_space]
  tags                = merge(var.default_tags, { "MRP" = var.mrp }, { "Env" = var.env })
}

# Create subnet in the vnet created above
resource "azurerm_subnet" "tf-subnet" {
  count                = var.subnet_count
  name                 = element(var.subnet_name, count.index)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.tf-vnet.name
  address_prefixes     = [element(var.address_prefixes, count.index)]
  service_endpoints    = var.service_endpoints
}
/*
# Peer above created vnet other vnets
resource "azurerm_virtual_network_peering" "peering_src" {
  count                     = var.peering_count
  name                      = element(var.peering_src_name, count.index)
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.tf-vnet.name
  remote_virtual_network_id = element(var.remote_vnet_id, count.index)
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}  

resource "azurerm_virtual_network_peering" "peering_dest" {
  count                     = var.peering_count
  name                      = element(var.peering_dest_name, count.index)
  resource_group_name       = element(var.peer_dest_rg, count.index)
  virtual_network_name      = element(var.remote_vnet_name, count.index)
  remote_virtual_network_id = azurerm_virtual_network.tf-vnet.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}
   */