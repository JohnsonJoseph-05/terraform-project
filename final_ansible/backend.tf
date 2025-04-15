terraform {
  backend "azurerm" {
    resource_group_name  = "n01698490-tfstate-rg"
    storage_account_name = "n01698490tfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
