output "vm_hostnames" {
  value       = { for key, vm in azurerm_linux_virtual_machine.vm : key => vm.name }
}

output "vm_computer_names" {
  value       = { for key, vm in azurerm_linux_virtual_machine.vm : key => vm.computer_name }
}

output "vm_private_ips" {
  value       = { for key, nic in azurerm_network_interface.nic : key => nic.ip_configuration[0].private_ip_address }
}

output "vm_public_ips" {
  value       = { for key, pip in azurerm_public_ip.public_ip : key => pip.ip_address }
}

output "vm_dns_labels" {
  value       = { for key, pip in azurerm_public_ip.public_ip : key => pip.domain_name_label }
}

output "public_ip_ids" {
  value       = { for key, pip in azurerm_public_ip.public_ip : key => pip.id }
}

output "vm_ids" {
  value       = { for key, vm in azurerm_linux_virtual_machine.vm : key => vm.id }
}

output "nic_ids" {
  value       = { for key, nic in azurerm_network_interface.nic : key => nic.id }
}

