resource "azurerm_managed_disk" "data_disk" {
  for_each             = var.vm_ids
  name                 = "${var.humber_id}-datadisk-${each.key}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = var.disk_storage_account_type
  disk_size_gb         = var.disk_size_gb
  create_option        = "Empty"
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  for_each           = var.vm_ids
  virtual_machine_id = each.value
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  lun                = 1
  caching            = "None"
}

