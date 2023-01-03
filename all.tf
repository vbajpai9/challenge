data "azurerm_resource_group" "rg" {
  name = "nitish-terraform-grp"
}

data "azurerm_client_config" "current" {}
