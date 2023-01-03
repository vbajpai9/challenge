output "nic-id" {
  value       = azurerm_network_interface.nics.*.id
  description = "The ID of the Network Interface."
}

output "vm-id" {
  value       = azurerm_windows_virtual_machine.node.*.id
  description = "The ID of the Windows Virtual Machine."
}

output "private_ip" {
  value       = azurerm_windows_virtual_machine.node.private_ip_address
  description = "The Primary Private IP Address assigned to this Virtual Machine."
}
