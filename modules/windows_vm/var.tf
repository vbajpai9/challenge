variable "rg_name" {
  default     = ""
  type        = string
  description = "The name of the Resource Group"
}

variable "location" {
  default     = ""
  type        = string
  description = "The location where the resource should exist."
}

variable "nic_names" {
  default     = ""
  type        = string
  description = "The name of the Network Interface."
}

variable "vm_names" {
  default     = ""
  type        = string
  description = "The name of the Linux Virtual Machine."
}

variable "vm_storage_disk_caching" {
  default     = ""
  type        = string
  description = "The Type of Caching which should be used for the Disk."
}

variable "vm_size" {
  default     = ""
  type        = string
  description = "The SKU which should be used for the Virtual Machine."
}

variable "disk_enc_set" {
  default     = ""
  type        = string
  description = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk."
}

variable "nic_ip_configuration_name" {
  default     = ""
  type        = string
  description = "The name used for IP Configuration"
}


variable "nic_private_ip_address_allocation" {
  default     = "dynamic"
  type        = string
  description = "The allocation method used for the Private IP Address."
}

variable "data_disk_storage_type" {
  default     = ""
  type        = string
  description = "The Type of Storage Account which should back this data Disk."
}

variable "vm_admin_username" {
  default     = ""
  type        = string
  description = "The username of the local administrator used for the Virtual Machine."
}

variable "vm_admin_password" {
  default     = ""
  type        = string
  description = "The Password which should be used for the local-administrator on the Virtual Machine."
  sensitive   = true
}

variable "vm_storage_os_disk_size" {
  type        = number
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
}

variable "vm_storage_os_disk_managed_disk_type" {
  default     = ""
  type        = string
  description = "The Type of Storage Account which should back this the Internal OS Disk."
}

variable "data_disk_names" {
  default     = []
  type        = list(string)
  description = "The mount name which should be used for the data Disk."
}

variable "vm_disk_count" {
  type        = number
  description = "The number of data disks to be attached to the VM."
}

variable "data_disk_sizes" {
  type        = list(number)
  description = "The Size of the data Disk in GB."
}

variable "os_disk_name" {
  default     = ""
  type        = string
  description = "The name which should be used for the Internal OS Disk."
}

variable "vm_storage_data_disk_name" {
  default     = ""
  type        = string
  description = "The name which should be used for the data Disk."
}

variable "vm_storage_data_create_option" {
  default     = ""
  type        = string
  description = "The method to use when creating the managed disk."
}

variable "nic_subnet_id" {
  default     = ""
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located in"
}

variable "default_tags" {
  default     = {}
  type        = map(string)
  description = "Default tags for the resource."
}

variable "mrp" {
  default     = ""
  type        = string
  description = "User who provisions the resource."
}

variable "env" {
  default     = ""
  type        = string
  description = "Environment to which the resource belongs to."
}

variable "availability_set_id" {
  default     = ""
  type        = string
  description = "Specifies the ID of the Availability Set in which the Virtual Machine should exist."
}

variable "publisher" {
  default     = ""
  type        = string
  description = "Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from."
}

variable "offer" {
  default     = ""
  type        = string
  description = "Specifies the offer of the image used to create the virtual machines."
}

variable "sku" {
  default     = ""
  type        = string
  description = "Specifies the SKU of the image used to create the virtual machines."
}

variable "vm_version" {
  default     = ""
  type        = string
  description = "Specifies the version of the image used to create the virtual machines."
}

variable "identity_type" {
  default     = ""
  type        = string
  description = "The type of Managed Identity which should be assigned to the Linux Virtual Machine."
}

variable "storage_account" {
  default     = ""
  type        = string
  description = "Storage account uri where boot diagnostics will store"

}
