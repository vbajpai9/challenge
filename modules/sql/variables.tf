variable "server_name" {
  default = ""
  type    = string
}
variable "sql_version" {
  default = ""
  type    = string
}
variable "admin_username" {
  default = ""
  type    = string
}
variable "admin_password" {
  default = ""
  type    = string
}
variable "database_name" {
  default = ""
  type    = string
}
variable "rg_name" {
  default = ""
  type    = string
}
variable "location" {
  default = ""
  type    = string
}
variable "requested_service_objective_name" {
  default = ""
  type    = string
}
variable "database_collation" {
  default = ""
  type    = string
}
variable "database_edition" {
  default = ""
  type    = string
}
variable "elasticpool_name" {
  default = ""
  type    = string
}
variable "max_size_gb" {
  default = 0
  type    = number
}
variable "sku_name" {
  default = ""
  type    = string
}
variable "sku_tier" {
  default = ""
  type    = string
}
variable "sku_family" {
  default = ""
  type    = string
}
variable "sku_capacity" {
  default = 0
  type    = number
}
variable "db_min_capacity" {
  default = 0
  type    = number
}
variable "db_max_capacity" {
  default = 0
  type    = number
}

variable "mrp" {
  default = ""
}

variable "env" {
  default = ""
}

variable "default_tags" {
  default = ""
}

variable "enable_threat_detection_policy" {
  description = ""
  default     = false
}

variable "retention_days" {
  default = ""
  type  = string
}

variable "email_addresses" {
  default = []
  type = list(string)
}


variable "primary_access_key" {}

variable "primary_blob_endpoint" {}
