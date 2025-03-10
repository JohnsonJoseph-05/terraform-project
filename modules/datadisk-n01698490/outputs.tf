output "data_disk_ids" {
  value       = { for k, disk in azurerm_managed_disk.data_disk : k => disk.id }
}

output "data_disk_attachment_ids" {
  value       = { for k, att in azurerm_virtual_machine_data_disk_attachment.data_disk_attachment : k => att.id }
}

