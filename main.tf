
locals {
  common_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Johnson.Joseph"
    ExpirationDate = "2025-3-10"
    Environment    = "Learning"
  }
}

module "rgroup-n01698490" {
  source   = "./modules/rgroup-n01698490"
  location = "canadacentral"
  tags     = local.common_tags
}

module "network-n01698490" {
  source               = "./modules/network-n01698490"
  humber_id            = "n01698490"
  resource_group       = module.rgroup-n01698490.rg_name	
  location             = "canadacentral"
  tags                 = local.common_tags
  vnet_address_space   = ["10.0.0.0/16"]
  subnet_address_space = ["10.0.1.0/24"]
  
}

module "common-n01698490" {
  source         = "./modules/common-n01698490"
  humber_id      = "n01698490"
  resource_group = module.rgroup-n01698490.rg_name 
  location       = "canadacentral"
  tags           = local.common_tags
}

module "vmlinux-n01698490" {
  source                       = "./modules/vmlinux-n01698490"
  humber_id                    = "n01698490"
  resource_group_name          = module.rgroup-n01698490.rg_name
  subnet_id                    = module.network-n01698490.subnet_id 
  location                     = "canadacentral"
  boot_diagnostics_storage_uri = module.common-n01698490.boot_diag_uri  
  admin_username               = "azureuser"
  admin_password               = "Johnson@12345"
  public_key                   = "/home/n01698490/john/my_rsa_key.pub"
  tags                         = local.common_tags
}

module "vmwindows-n01698490" {
  source                      = "./modules/vmwindows-n01698490"  
  vm_count                    = 1
  humber_id                   = "n0169849"
  resource_group_name         = "n01698490-RG"
  location                    = "canadacentral"
  subnet_id                   = module.network-n01698490.subnet_id  
  admin_username              = "adminuser"
  admin_password              = "Johnson@12345"         
  vm_size                     = "Standard_DS1_v2"
  windows_os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  windows_os_info = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  boot_diagnostics_storage_uri = "https://yourstorageaccount.blob.core.windows.net/"
  tags     = local.common_tags	
}

module "datadisk-n01698490" {
  source               = "./modules/datadisk-n01698490"
  vm_ids               = {
    "vm1" = module.vmlinux-n01698490.vm_ids["vm1"]
    "vm2" = module.vmlinux-n01698490.vm_ids["vm2"]
    "vm3" = module.vmlinux-n01698490.vm_ids["vm3"]
    "vm4" = module.vmwindows-n01698490.vm_ids["vm1"]
  }
  humber_id            = "n01698490"
  resource_group_name  = "n01698490-RG"
  location             = "canadacentral"
  disk_size_gb         = 10
  disk_storage_account_type = "Standard_LRS"
}

module "loadbalancer-n01698490" {
  source              = "./modules/loadbalancer-n01698490"
  humber_id           = "n01698490"
  resource_group_name = "n01698490-RG"
  location            = "canadacentral"
  tags                = local.common_tags
  backend_nic_ids = {
    "vm1" = module.vmlinux-n01698490.nic_ids["vm1"]
    "vm2" = module.vmlinux-n01698490.nic_ids["vm2"]
    "vm3" = module.vmlinux-n01698490.nic_ids["vm3"]
  }
  backend_ip_config_name = "internal"
}

module "database-n01698490" {
  source              = "./modules/database-n01698490"
  humber_id           = "n01698490"
  resource_group_name = "n01698490-RG"
  location            = "canadacentral"
  admin_login         = "dbadmin"
  admin_password      = "Johnson@12345"
  sku_name            = "B_Gen5_1"
  db_version          = "11"
  storage_mb          = 5120
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  tags                = local.common_tags
}





//"/subscriptions/xxxx/resourceGroups/n01698490-RG/providers/Microsoft.Network/virtualNetworks/yourVNet/subnets/yourSubnet"

