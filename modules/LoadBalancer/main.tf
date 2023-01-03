

# module for external load balancer
/*  resource "azurerm_public_ip" "example" {
  name                = "PublicIPForLB"
  location            = "West US"
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
} */

resource "azurerm_lb" "ilb" {
  name                = var.ilb_name
  location            = "West US"
  resource_group_name = "rg-logstash-uat-001"
  sku = var.sku
  tags = merge(var.default_tags, { "MRP" = var.mrp }, { "Env" = var.env })


  frontend_ip_configuration {
    name                 = var.ilb_frontend_name
    subnet_id =  var.ilb_subnet_id
    private_ip_address_allocation = var.ilb_ip_allocation
    private_ip_address_version = var.ilb_ip_version
    availability_zone = "No-Zone"
  }
}
  resource "azurerm_lb_backend_address_pool" "ilb_backend" {
  loadbalancer_id = azurerm_lb.ilb.id
  name            = var.ilb_backend_name
}
resource "azurerm_lb_backend_address_pool_address" "backend_address" {
  #for_each = toset(var.ilb_backend_pool_name)
  count = length(var.ip_address)
  name                    = "${var.ilb_backend_pool_name}-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ilb_backend.id
  virtual_network_id      = var.vnet_id
  ip_address              =  var.ip_address[count.index]
}
resource "azurerm_lb_probe" "example" {
  for_each = toset(var.health_probe_name)
  resource_group_name = var.resource_name
  loadbalancer_id     = azurerm_lb.ilb.id
  name                = each.value
  port                = lookup(var.health_probes,each.key)
  protocol = var.protocol
  interval_in_seconds = var.interval_in_seconds
  number_of_probes = var.number_of_probes
}
resource "azurerm_lb_rule" "example" {
  #for_each = toset(var.health_probe_name)
  resource_group_name            = var.resource_name
  loadbalancer_id                = azurerm_lb.ilb.id
  name                           = var.lb_rule_name
  protocol                       = var.protocol
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  probe_id =  azurerm_lb_probe.example[var.probe].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.ilb_backend.id
  frontend_ip_configuration_name = var.ilb_frontend_name
  enable_floating_ip = var.enable_floating_ip
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  load_distribution = var.load_distribution
  disable_outbound_snat = var.disable_outbound_snat
  enable_tcp_reset = var.enable_tcp_reset
}






