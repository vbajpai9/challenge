output "tf-vnet-name" {
  value       = azurerm_virtual_network.tf-vnet.name
  description = "The name of the virtual Network."
}
output "tf-vnet-id" {
  value = azurerm_virtual_network.tf-vnet.id
  
}

output "tf-subent-name" {
  value       = azurerm_subnet.tf-subnet.*.name
  description = "The name of the subnet."
}

output "tf-subent-id" {
  value       = azurerm_subnet.tf-subnet.*.id
  description = "The ID of the subnet."
}
