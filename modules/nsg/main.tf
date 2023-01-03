/*
Purpose: This module creates a network security group
         that contains a list of inbound network security rules
         and associates with a subnet.
Author : Nitish
organization: Deloitte CMS
*/

# creates an NSG
resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.default_tags, { "MRP" = var.mrp }, { "Env" = var.env })
}

# Create inbound rules for nsg
resource "azurerm_network_security_rule" "nsg-inbound-rule" {
  count                       = var.rule_count
  name                        = element(var.nsg_rule_name, count.index)
  priority                    = element(var.rule_priority, count.index)
  direction                   = element(var.direction, count.index)
  access                      = element(var.access, count.index)
  protocol                    = element(var.protocol, count.index)
  source_port_range           = element(var.source_port_range, count.index)
  destination_port_range      = element(var.destination_port_ranges, count.index)
  source_address_prefix       = element(var.source_address_prefix, count.index)
  destination_address_prefix  = element(var.destination_address_prefix, count.index)
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

#associate nsg with subnet
resource "azurerm_subnet_network_security_group_association" "nsg-subnet" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
