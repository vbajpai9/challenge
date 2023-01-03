output "tf-nsg-name" {
  value       = azurerm_network_security_group.nsg.*.name
  description = "Name of the NSG"
}

output "tf-nsg-id" {
  value       = azurerm_network_security_group.nsg.*.id
  description = "The ID of the Network Security Group."
}
