variable "vnet_name" {
  default     = ""
  type        = string
  description = "The name of the virtual network."
}

variable "location" {
  default     = ""
  type        = string
  description = "The location/region where the virtual network is created."
}

variable "resource_group_name" {
  default     = ""
  type        = string
  description = "The name of the resource group in which to create the virtual network."
}

variable "address_space" {
  default     = ""
  type        = string
  description = "The address space that is used the virtual network."
}

variable "default_tags" {
  default     = {}
  type        = map(string)
  description = "default tags for the resource"
}

variable "mrp" {
  default     = ""
  type        = string
  description = "User who provisions the resources."
}

variable "address_prefixes" {
  default     = []
  type        = list(string)
  description = "The address prefix to use for the subnet."
}

variable "subnet_name" {
  default     = []
  type        = list(string)
  description = "The name of the subnet."
}

variable "subnet_count" {
  type        = number
  description = "number of subnets to create."
}

variable "env" {
  default     = ""
  type        = string
  description = "Environment to which resource belongs to."
}

variable "service_endpoints" {
  default     = []
  type        = list(string)
  description = "The list of Service endpoints to associate with the subnet. "
}

variable "peering_count" {
  type        = number
  default = 0
  description = "Number of peerings user want to have."
}

variable "peering_src_name" {
  default = [""]
  type = list(string)
  description = "The name of the virtual network peering."
}

variable "peering_dest_name" {
  default = [""]
  type = list(string)
  description = "The name of the virtual network peering."
}

variable "remote_vnet_name" {
  default = [""]
  type = list(string)
  description = "The name of vnet for the remote virtual network."
}

variable "remote_vnet_id" {
  default = [""]
  type = list(string)
  description = "The full Azure resource ID of the remote virtual network."
}

variable "peer_dest_rg" {
  default = [""]
  type = list(string)
  description = "The name of the resource group in which to create the virtual network peering."
}

variable "allow_virtual_network_access" {
  default = true
  type = bool
  description = "Controls if the VMs in the remote virtual network can access VMs in the local virtual network."
}

variable "allow_forwarded_traffic" {
  default = false
  type = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed."
}

variable "allow_gateway_transit" {
  default = false
  type = bool
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network."
}

variable "use_remote_gateways" {
  default = false
  type = bool
  description = "Controls if remote gateways can be used on the local virtual network."
}
