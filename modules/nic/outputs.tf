output "nic-id" {
  value       = azurerm_network_interface.nics.*.id
  description = "The ID of the Network Interface."
}
