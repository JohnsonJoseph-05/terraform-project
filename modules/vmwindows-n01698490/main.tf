
resource "azurerm_public_ip" "windows_pip" {
  count               = var.vm_count
  name                = "${var.humber_id}-pip-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  domain_name_label   = "${var.humber_id}-vm${count.index + 1}"
  tags                = var.tags
}


resource "azurerm_network_interface" "windows_nic" {
  count               = var.vm_count
  name                = "${var.humber_id}-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.humber_id}-ipconfig-${count.index + 1}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip[count.index].id
  }
  tags = var.tags
}


resource "azurerm_availability_set" "windows_vm_avs" {
  name                         = "${var.humber_id}-avs"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_fault_domain_count  = 2	
  platform_update_domain_count = 5
  tags                         = var.tags
}


resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = var.vm_count
  name                = "${var.humber_id}-vm${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  computer_name       = "${var.humber_id}-vm${count.index + 1}"
  availability_set_id = azurerm_availability_set.windows_vm_avs.id

  network_interface_ids = [
    azurerm_network_interface.windows_nic[count.index].id
  ]

  os_disk {
    name                 = "${var.humber_id}-osdisk-${count.index + 1}"
    caching              = var.windows_os_disk.caching
    storage_account_type = var.windows_os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.windows_os_info.publisher
    offer     = var.windows_os_info.offer
    sku       = var.windows_os_info.sku
    version   = var.windows_os_info.version
  }

  winrm_listener {
    protocol = "Http"
  }
  tags = var.tags
  
  #lifecycle {
  #prevent_destroy = true
  #}
}


resource "azurerm_virtual_machine_extension" "antimalware_extension" {
  count               = var.vm_count
  name                = "${var.humber_id}-antimalware-${count.index + 1}"
  virtual_machine_id  = azurerm_windows_virtual_machine.windows_vm[count.index].id
  publisher           = "Microsoft.Azure.Security"
  type                = "IaaSAntimalware"
  type_handler_version = "1.3"  	
  settings = <<SETTINGS
{
  "AntimalwareEnabled": true,
  "RealtimeProtectionEnabled": true,
  "ScheduledScanSettings": {
      "isEnabled": true,
      "day": 7,
      "time": 120
  }
}
SETTINGS
}

