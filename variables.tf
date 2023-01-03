variable "rg_name" {
  default     = "nitish-terraform-grp"
  type        = string
  description = "The name of the resource group in which to create the resource"
}

variable "app-name" {
  default     = "tst"
  type        = string
  description = "name of the application: only 3 characters are to be used."
}

variable "server_role" {
  default     = ["app", "web", "db", "jmp", "api", "img", "imp", "off", "val", "inf", "edc", "bot", "orc"]
  type        = list(string)
  description = "Role(s) of the servers"
}

variable "linux_OS" {
  default     = "l"
  type        = string
  description = "The OS of the server, used in resource name(s)."
}

variable "windows_OS" {
  default     = "w"
  type        = string
  description = "The OS of the server, used in resource name(s)."
}

variable "env_char" {
  default     = "q" // Example: q = QA, d = Dev, p = Prod
  type        = string
  description = "The name of the Env used in resource name(s)."
}

variable "mrp" {
  default     = "user_name"
  type        = string
  description = "The User who provisions vnet, added as tag."
}

variable "env" {
  default     = "env"
  type        = string
  description = "The Environment to which resource belongs to."
}

variable "default_tags" {
  default = {
    "COUNTRY"         = "US"
    "FUNCTION"        = "Consulting"
    "OPERATINGGROUP"  = "OpenCloud"
    "MEMBERFIRM"      = "US"
    "BILLINGCODE"     = "<Billing-code>"
    "BUSINESSOWNERS"  = "<Business-Owners>"
    "CLIENT"          = "<client-name>"
    "account_id"      = "<subscription-id>"
    "BILLING CONTACT" = "<contat person>"
    "CONTACTS"        = "<contat person>"
    "Business Unit"   = "<BusinessUnit>"
    "Application"     = "<Application-Name>"  // Name of the Application.
  }
  type        = map(string)
  description = "The default tags for the resource."
}

variable "sql_version" {
  default = "12.0"
}

variable "elasticpool_name" {
  description = "Name on the initial elastic_pool on the server. "
  default     = ""
}

variable "database_collation" {
  default     = "SQL_LATIN1_GENERAL_CP1_CI_AS"
  description = "Which collation the initial database should have."
}

variable "database_edition" {
  default     = "GeneralPurpose"
  description = "Which database scaling edition the database should have."
}

variable "requested_service_objective_name" {
  default = "GP_Gen5_4"
}

variable "max_size_gb" {
  default     = "32"
  description = "The max size of elastic."
}
