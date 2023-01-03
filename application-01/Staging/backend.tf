terraform {
  backend "azurerm" {
    resource_group_name  = "nitish-terraform-grp" // RG group name
    storage_account_name = "sttfstatefiles"       // storage account name where user want to store statefiles
    container_name       = "azureresources"       // container name where user want to store statefiles
    key                  = "test.tfstate"         // statefile name
  }
}
