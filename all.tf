data "azurerm_resource_group" "rg" {
  name = "Test-ResourceGroup"
}

data "azurerm_client_config" "current" {}
