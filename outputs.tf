
output "resource_group_name" {
  value = module.rgroup-n01698490.rg_name
}

output "vnet_name" {
  value       = module.network-n01698490.vnet_name
}

output "subnet_name" {
  value       = module.network-n01698490.subnet_name
}

output "subnet_id" {
  value       = module.network-n01698490.subnet_id
}

output "nsg_name" {
  value       = module.network-n01698490.nsg_name
}

output "vnet_address_space" {
  value       = module.network-n01698490.vnet_address_space
}

output "subnet_address_space" {
  value       = module.network-n01698490.subnet_address_space
}
  
output "log_analytics_workspace" {
  value       = module.common-n01698490.law_name
}

output "recovery_services_vault" {
  value       = module.common-n01698490.rsv_name
}

output "standard_storage_account" {
  value       = module.common-n01698490.std_storage_account
}

output "boot_diag_uri" {
  value       = module.common-n01698490.boot_diag_uri
}


output "vm_hostnames" {
  value       = module.vmlinux-n01698490.vm_hostnames
}

output "vm_computer_names" {
  value       = module.vmlinux-n01698490.vm_computer_names
}

output "vm_private_ips" {
  description = "Map of VM private IP addresses"
  value       = module.vmlinux-n01698490.vm_private_ips
}

output "vm_public_ips" {
  value       = module.vmlinux-n01698490.vm_public_ips
}

output "vm_dns_labels" {
  value       = module.vmlinux-n01698490.vm_dns_labels
}

output "public_ip_ids" {
  value       = module.vmlinux-n01698490.public_ip_ids
}

// windows

output "windows_vm_hostname" {
  value       = module.vmwindows-n01698490.windows_vm_hostname
}

output "windows_vm_domain_name" {
  value       = module.vmwindows-n01698490.windows_vm_domain_name
}

output "windows_vm_private_ip" {
  value       = module.vmwindows-n01698490.windows_vm_private_ip
}

output "windows_vm_public_ip" {
  value       = module.vmwindows-n01698490.windows_vm_public_ip
}

//
output "linux_vm_ids" {
  value       = module.vmlinux-n01698490.vm_ids
}

output "windows_vm_ids" {
  value       = module.vmwindows-n01698490.vm_ids
}

output "load_balancer_name" {
  value       = module.loadbalancer-n01698490.lb_name
}

output "database_server_name" {
  value       = module.database-n01698490.db_name
}

