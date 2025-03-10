resource "azurerm_postgresql_server" "db" {
  name                = "${var.humber_id}-db"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password

  sku_name   = var.sku_name
  version    = var.db_version  
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  ssl_enforcement_enabled      = true

  tags = var.tags
}

