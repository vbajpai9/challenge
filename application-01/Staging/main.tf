terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.67.0"
    }
  }
}

locals {
  location            = data.azurerm_resource_group.rg.location      // The location/region where the resource should exist.
  tenant_id           = data.azurerm_client_config.current.tenant_id // The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.
  object_id           = data.azurerm_client_config.current.object_id // The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.
}

// vnet with subnets and peering
module "vnet-01" {
  source              = "../../../modules/vnet"
  vnet_name           = "vnet-${var.app-name}-${var.env}-${local.location}-001" // The name of the virtual network.
  subnet_name         = ["snet-${var.app-name}-${var.env}-${local.location}-001"]  // The name of the subnets.
  location            = local.location
  resource_group_name = var.rg_name
  address_space       = "10.10.10.0/24"       // The address space that is used the virtual network.
  subnet_count        = 1                     // The number of subnets to be created in vnet.
  address_prefixes    = ["10.10.10.0/26"]     // The address prefix to use for the subnet.
  service_endpoints   = ["Microsoft.Storage"] // service endpoints for subnets.
  peering_count       = 1                     // The number of peering connection(s) to be made.
  peering_src_name    = ["test-src"]          // The name of the source virtual network peering.
  peering_dest_name   = ["test-dest"]         // The name of the destination virtual network peering.
  remote_vnet_name    = ["openvpnvnet"]       // The name of the virtual network which want to be peered.
  remote_vnet_id      = ["/subscriptions/b74114ef-7ad0-4181-98b7-40259509d53e/resourceGroups/AZRG-OC-CIP-AUTMN-OPenvPN/providers/Microsoft.Network/virtualNetworks/openvpnvnet"]     // The full Azure resource ID of the remote virtual network.
  peer_dest_rg        = ["AZRG-OC-CIP-AUTMN-OPENVPN"]  // The name of the resource group in which to create the virtual network peering.
  allow_virtual_network_access = true   // Controls if the VMs in the remote virtual network can access VMs in the local virtual network.
  allow_forwarded_traffic      = false  // Controls if forwarded traffic from VMs in the remote virtual network is allowed.
  allow_gateway_transit        = false  // Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
  use_remote_gateways          = false  // Controls if remote gateways can be used on the local virtual network.
  default_tags                 = var.default_tags
  mrp                          = var.mrp
  env                          = var.env
}

// nsg for inbound only
module "nsg-01" {
  source                     = "../../../modules/nsg"
  name                       = "nsg-${var.app-name}-001" // Specifies the name of the network security group.
  location                   = local.location
  resource_group_name        = var.rg_name
  rule_count                 = 1                              // The number of nsg rules
  nsg_rule_name              = ["allowing_Winrm"]             // The name of the security rule.
  rule_priority              = [100]                          // Specifies the priority of the rule.
  direction                  = ["Inbound"]                    // The direction specifies if rule will be evaluated on incoming or outgoing traffic.
  access                     = ["Allow"]                      // Specifies whether network traffic is allowed or denied.
  protocol                   = ["Tcp"]                        // Network protocol the rule applies to
  source_port_range          = ["*"]                          // Source Port or Range
  destination_port_ranges    = [5985]                         // Destination Port or Range
  source_address_prefix      = ["10.11.11.0/24"]              // Source IP range from which inbound should be allowed
  destination_address_prefix = ["*"]                          // CIDR or destination IP range or * to match any IP
  subnet_id                  = module.vnet-01.tf-subent-id[0] // The subnet to which nsg should be assigned to
  default_tags               = var.default_tags
  mrp                        = var.mrp
  env                        = var.env
}



// storage account with container and file-share
module "storageacc-01" {
  source                = "../../../modules/storage-acc"
  name                  = "st${var.env}${var.app-name}01" // Specifies the name of the storage account.
  rg_name               = var.rg_name
  location              = local.location
  tier                  = "Standard"        // Defines the Tier to use for this storage account.
  replication_type      = "LRS"             // Defines the type of replication to use for this storage account.
  container_count       = 1                 // The number of containers to create in storage account.
  container_name        = ["containername"] // The names of the Container which should be created within the Storage Account.
  container_access_type = ["private"]       // The Access Level configured for this Container.
  fileshare_count       = 1                 // The number of fileshares to be created in storage account.
  fileshare_name        = ["nas-01"]        // The name of the file share.
  quota                 = [500]             // The maximum size of the share, in gigabytes.
  default_tags          = var.default_tags
  mrp                   = var.mrp
  env                   = var.env
}

// availability_set
module "AS1" {
  source   = "../../../modules/avail_set"
  name     = "${var.app-name}AS1" // Specifies the name of the availability set.
  location = local.location
  rg_name  = var.rg_name

  platform_update_domain_count = 3 // Specifies the number of update domains that are used.
  platform_fault_domain_count  = 3 // Specifies the number of fault domains that are used.

  default_tags  = var.default_tags
  mrp           = var.mrp
  env           = var.env
}

//windows_vm
module "app_server" {
  count                                = 1
  source                               = "../../../modules/windows_vm"
  vm_names                             = "azr-${var.app-name}${var.server_role[0]}${var.env_char}${var.linux_OS}0${count.index + 1}"
  os_disk_name                         = "azr-${var.app-name}${var.server_role[0]}${var.env_char}${var.linux_OS}0${count.index + 1}-OS"
  nic_names                            = "nic-azr-${var.app-name}${var.server_role[0]}${var.env_char}${var.linux_OS}0${count.index + 1}-${var.env}-0${count.index + 1}"
  location                             = local.location
  rg_name                              = var.rg_name
  vm_size                              = "Standard_D4s_v4"
  nic_ip_configuration_name            = "Internal"
  nic_subnet_id                        = module.vnet-01.tf-subent-id[0]
  disk_enc_set                         = module.disk-enc-set-01.disk_enc_id
  vm_admin_username                    = module.kv-01.secrets.vmUserName.value
  vm_admin_password                    = module.kv-01.secrets.vmPassWord.value
  availability_set_id                  = ""          // This VM will provision without availability set.
  nic_private_ip_address_allocation    = "Dynamic"
  vm_storage_disk_caching              = "ReadWrite"
  vm_storage_os_disk_managed_disk_type = "Standard_LRS"
  vm_storage_os_disk_size              = 127
  vm_disk_count                        = 1
  data_disk_names                      = ["D"]
  data_disk_sizes                      = [50]
  data_disk_storage_type               = "StandardSSD_LRS"
  vm_storage_data_disk_name            = "azr-${var.app-name}${var.server_role[0]}${var.env_char}${var.linux_OS}0${count.index + 1}-DATA-${count.index + 1}"
  vm_storage_data_create_option        = "Empty"
  publisher                            = "MicrosoftWindowsServer"
  offer                                = "WindowsServer"
  sku                                  = "2012-r2-datacenter-gensecond"
  vm_version                           = "latest"
  identity_type                        = "SystemAssigned"
  default_tags                         = var.default_tags
  mrp                                  = var.mrp
  env                                  = var.env
}

// sql
module "Sql-01" {
  source                           = "../../../modules/sql"
  server_name                      = "azr${var.server_role[2]}-${var.app-name}${var.env}"
  database_name                    = "azr${var.server_role[2]}-${var.app-name}${var.env}"
  elasticpool_name                 = "sql${var.server_role[2]}pool-${var.app-name}${var.env}${var.server_role[2]}001"
  admin_username                   = module.kv-01.secrets.sqlUserName.value
  admin_password                   = module.kv-01.secrets.sqlPassWord.value
  sql_version                      = var.sql_version
  rg_name                          = var.rg_name
  location                         = local.location
  requested_service_objective_name = var.requested_service_objective_name
  database_collation               = var.database_collation
  database_edition                 = var.database_edition
  max_size_gb                      = var.max_size_gb
  sku_name                         = "GP_Gen5"
  sku_tier                         = "GeneralPurpose"
  sku_family                       = "Gen5"
  sku_capacity                     = 4
  db_min_capacity                  = 1
  db_max_capacity                  = 4
  default_tags                     = var.default_tags
  mrp                              = var.mrp
  env                              = var.env
}
