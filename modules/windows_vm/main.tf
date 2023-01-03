### NIC ###
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

### windows VM ###
resource "azurerm_windows_virtual_machine" "node" {
  admin_password = var.vm_admin_password
  admin_username = var.vm_admin_username
  location       = var.location
  name           = var.vm_names

  network_interface_ids = [azurerm_network_interface.nics.id]
  os_disk {
    caching                = var.vm_storage_disk_caching
    storage_account_type   = var.vm_storage_os_disk_managed_disk_type
    disk_encryption_set_id = var.disk_enc_set
    disk_size_gb           = var.vm_storage_os_disk_size
    name                   = var.os_disk_name
  }
  resource_group_name = var.rg_name
  size                = var.vm_size
  availability_set_id = var.availability_set_id != "" ? var.availability_set_id : null

  allow_extension_operations = true
  enable_automatic_updates   = false
  patch_mode                 = "Manual"
  provision_vm_agent         = true

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.vm_version
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account
  }

  identity {
    type         = var.identity_type
    identity_ids = []
  }
  tags = merge(var.default_tags, { "MRP" = var.mrp }, { "Env" = var.env }, { "wab:resource-name" = var.vm_names })
}

## create Azure storage disks ##
resource "azurerm_managed_disk" "vm_disk" {
  count                  = var.vm_disk_count
  name                   = "${var.vm_storage_data_disk_name}-${var.data_disk_names[count.index % length(var.data_disk_names)]}"
  location               = var.location
  resource_group_name    = var.rg_name
  storage_account_type   = var.data_disk_storage_type
  create_option          = var.vm_storage_data_create_option
  disk_size_gb           = var.data_disk_sizes[count.index % length(var.data_disk_sizes)]
  disk_encryption_set_id = var.disk_enc_set
  tags                   = merge(var.default_tags, { "MRP" = var.mrp }, { "Env" = var.env })
}

## attach storage disk to VM ##
resource "azurerm_virtual_machine_data_disk_attachment" "vm" {
  count           = var.vm_disk_count
  managed_disk_id = azurerm_managed_disk.vm_disk[count.index % length(azurerm_managed_disk.vm_disk)].id
  //managed_disk_id    = azurerm_managed_disk.vm_disk.*.id[count.index]
  virtual_machine_id = azurerm_windows_virtual_machine.node.id
  lun                = count.index + 10
  caching            = var.vm_storage_disk_caching
}
