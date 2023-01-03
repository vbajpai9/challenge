// vnet
output "app-vnet-name" {
  value       = module.vnet-01.tf-vnet-name
  description = "The name of the virtual Network."
}

output "app-subent-name" {
  value       = module.vnet-01.tf-subent-name
  description = "The name of the subnet."
}

output "app-subent-id" {
  value       = module.vnet-01.tf-subent-id
  description = "The ID of the subnet."
}

// nsg
output "app-nsg-01-name" {
  value       = module.nsg-01.tf-nsg-name
  description = "Name of the NSG"
}

output "app-nsg-01-id" {
  value       = module.nsg-01.tf-nsg-id
  description = "The ID of the Network Security Group."
}

// key_vault
output "key_vault_id" {
  value       = module.kv-01.key_vault_id
  description = "The ID of the Key Vault."
}

output "key_vault_url" {
  value       = module.kv-01.key_vault_url
  description = "The URI of the Key Vault."
}

output "secrets" {
  value     = module.kv-01.secrets
  sensitive = true
}

output "key_vault_key_id" {
  value       = module.kv-01.key_vault_key_id
  description = "The Key Vault Key ID."
}

// disk encryption set
output "disk_enc_id" {
  value       = module.disk-enc-set-01.disk_enc_id
  description = "The ID of the Disk Encryption Set."
}

//storage account details
output "storage_account-id" {
  value       = module.storageacc-01.storage_acc_id
  description = "The ID of the Storage Account."
}

output "container-id" {
  value       = module.storageacc-01.container_id
  description = "The ID of the Storage Container."
}

output "file_share_id" {
  value       = module.storageacc-01.file_share_id
  description = "The ID of the File Share."
}

// avail_set
output "AS1_id" {
  value       = module.AS1.availability_set_id
  description = "The ID of the Availability Set."
}

//vm
output "web_vm-nic" {
  value = module.web_cluster.*.nic-id
}

output "web_vm-id" {
  value = module.web_cluster.*.vm-id
}

output "web_vm-private_ip" {
  value = module.web_cluster.*.private_ip
}

output "app_vm-nic" {
  value = module.app_server.*.nic-id
}

output "app_vm-id" {
  value = module.app_server.*.vm-id
}

output "app_vm-private_ip" {
  value = module.app_server.*.private_ip
}
