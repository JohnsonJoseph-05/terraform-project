output "windows_vm_hostname" {
  value       = azurerm_windows_virtual_machine.windows_vm[*].computer_name
}

output "windows_vm_domain_name" {
  value       = azurerm_public_ip.windows_pip[*].domain_name_label
}

output "windows_vm_private_ip" {
  value       = azurerm_network_interface.windows_nic[*].ip_configuration[0].private_ip_address
}

output "windows_vm_public_ip" {
  value       = azurerm_public_ip.windows_pip[*].ip_address
}

output "vm_ids" {
  value       = { for idx, vm in azurerm_windows_virtual_machine.windows_vm : "vm${idx + 1}" => vm.id }
}
