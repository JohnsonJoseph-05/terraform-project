locals {
  linux_vms = {
    "vm1" = { dns_label = "${var.humber_id}-vm1" }
    "vm2" = { dns_label = "${var.humber_id}-vm2" }
    "vm3" = { dns_label = "${var.humber_id}-vm3" }
  }
}

resource "azurerm_public_ip" "public_ip" {
  for_each            = local.linux_vms
  name                = each.value.dns_label
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = each.value.dns_label
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  for_each            = local.linux_vms
  name                = "${each.value.dns_label}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
  }
}

resource "azurerm_availability_set" "avs" {
  name                = "${var.humber_id}-AVS"
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = local.linux_vms
  name                = each.value.dns_label
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1ms"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]
  
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_uri
  }

  computer_name = each.value.dns_label
  tags          = var.tags
}

resource "azurerm_virtual_machine_extension" "nw_extension" {
  for_each            = local.linux_vms
  name                = "${each.value.dns_label}-nw"
  virtual_machine_id  = azurerm_linux_virtual_machine.vm[each.key].id
  publisher           = "Microsoft.Azure.NetworkWatcher"
  type                = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}

resource "azurerm_virtual_machine_extension" "am_extension" {
  for_each            = local.linux_vms
  name                = "${each.value.dns_label}-am"
  virtual_machine_id  = azurerm_linux_virtual_machine.vm[each.key].id
  publisher           = "Microsoft.Azure.Monitor"
  type                = "AzureMonitorLinuxAgent"
  type_handler_version = "1.10"
}

resource "null_resource" "display_hostname" {
  for_each = local.linux_vms

  provisioner "local-exec" {
    command = "echo ${each.value.dns_label}"
  }
}

