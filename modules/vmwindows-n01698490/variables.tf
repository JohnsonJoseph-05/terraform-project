variable "vm_count" {
  default = 1
}

variable "humber_id" {
  default = "n01698490"
}

variable "resource_group_name" {
  type        = string
}

variable "location" {
  default = "canadacentral"
}

variable "subnet_id" {
  default = "/subscriptions/xxxx/resourceGroups/n01698490-RG/providers/Microsoft.Network/virtualNetworks/yourVNet/subnets/yourSubnet"
}

variable "admin_username" {
  default = "n01698490"
}

variable "admin_password" {
  default = "Johnson@12345"
}

variable "vm_size" {
  default = "Standard_DS1_v2"
}

variable "windows_os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

variable "windows_os_info" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

variable "boot_diagnostics_storage_uri" {
  default = "https://yourstorageaccount.blob.core.windows.net/"
}

variable "tags" {
  type = map(string)
  default = {}
}

