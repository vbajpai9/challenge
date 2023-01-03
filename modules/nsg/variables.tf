variable "default_tags" {
  default     = {}
  type        = map(string)
  description = "Default tags for the resources."
}

variable "name" {
  default     = ""
  type        = string
  description = "Specifies the name of the network security group."
}

variable "location" {
  default     = ""
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
  default     = ""
  type        = string
  description = "The name of the resource group in which to create the network security group."
}

variable "mrp" {
  default     = ""
  type        = string
  description = "User who provisions the resources."
}

variable "env" {
  default     = ""
  type        = string
  description = "Environment to which the resources belong to."
}

variable "rule_count" {
  type        = number
  description = "number of inbound rules"
}

variable "nsg_rule_name" {
  default     = []
  type        = list(string)
  description = "The name of the security rule."
}

variable "rule_priority" {
  default     = []
  type        = list(number)
  description = "Specifies the priority of the rule."
}

variable "direction" {
  default     = ["Inbound"]
  type        = list(string)
  description = "The direction specifies if rule will be evaluated on incoming or outgoing traffic."
}

variable "access" {
  default     = []
  type        = list(string)
  description = "Specifies whether network traffic is allowed or denied."
}

variable "protocol" {
  default     = []
  type        = list(string)
  description = "Network protocol this rule applies to."
}

variable "source_port_range" {
  default     = []
  type        = list(string)
  description = "Source Port or Range."
}

variable "destination_port_ranges" {
  default     = []
  type        = list(number)
  description = "Destination Port or Range."
}

variable "source_address_prefix" {
  default     = []
  type        = list(string)
  description = "CIDR or source IP range or * to match any IP."
}

variable "destination_address_prefix" {
  default     = []
  type        = list(string)
  description = "CIDR or destination IP range or * to match any IP."
}

variable "subnet_id" {
  default     = ""
  type        = string
  description = "The ID of the Subnet."
}
