
provider "azurerm" {
  features {}
  subscription_id = "e058149c-c530-4b72-83fe-932d9c9169ed"
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19"
    }
  }
  required_version = "~> 1.9"
}

