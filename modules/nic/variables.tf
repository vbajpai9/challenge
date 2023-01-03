variable "nic_names" {
  default     = ""
  type        = string
  description = "The name of the Network Interface."
}

variable "location" {
  default     = ""
  type        = string
  description = "The location where the resource should exist."
}

variable "rg_name" {
  default     = ""
  type        = string
  description = "The name of the Resource Group"
}

variable "nic_ip_configuration_name" {
  default     = ""
  type        = string
  description = "The name used for IP Configuration"
}

variable "nic_subnet_id" {
  default     = ""
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located in"
}

variable "nic_private_ip_address_allocation" {
  default     = "dynamic"
  type        = string
  description = "The allocation method used for the Private IP Address."
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
