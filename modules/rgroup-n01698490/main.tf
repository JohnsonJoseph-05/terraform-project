resource "azurerm_resource_group" "rg_name" {
  name     = "${var.humber_id}RG"  
  location = var.location
  tags     = var.tags
}

