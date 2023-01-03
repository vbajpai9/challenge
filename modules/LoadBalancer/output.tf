output "loadbalancer-id"{
    value = azurerm_lb.ilb.id
    description = "The ID of the Network Interface."
}
output "frontend-ip" {
    value = azurerm_lb.ilb.frontend_ip_configuration
    description = "lists all the description about frontend including rules"
  
}
output "backend-id" {
    value = azurerm_lb_backend_address_pool.ilb_backend.id
    description = "The id of backend adrress pool"
  
}

output "backend-ips" {
    value = azurerm_lb_backend_address_pool.ilb_backend.backend_ip_configurations
    description = "backend pool ip's "
  
}