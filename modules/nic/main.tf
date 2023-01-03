resource "azurerm_network_interface" "nics" {
  name                = var.nic_names
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.nic_ip_configuration_name
    subnet_id                     = var.nic_subnet_id
    private_ip_address_allocation = var.nic_private_ip_address_allocation
  }

  tags = merge(var.default_tags, { "MRP" = var.mrp }, { "Env" = var.env })
}
