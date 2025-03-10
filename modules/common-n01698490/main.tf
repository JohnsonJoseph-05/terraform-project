
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.humber_id}-LAW"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = "${var.humber_id}-RSV"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_storage_account" "std_storage" {
  name                     =lower("${var.humber_id}stdstorage")	
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

