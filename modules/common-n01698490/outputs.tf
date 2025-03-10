
output "law_name" {
  value = azurerm_log_analytics_workspace.law.name
}

output "rsv_name" {
  value = azurerm_recovery_services_vault.rsv.name
}

output "std_storage_account" {
  value = azurerm_storage_account.std_storage.name
}

output "boot_diag_uri" {
  value       = "https://${azurerm_storage_account.std_storage.name}.blob.core.windows.net/"
}

