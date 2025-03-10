resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.humber_id}-lb-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${var.humber_id}-lb"
  tags                = var.tags
}

resource "azurerm_lb" "lb" {
  name                = "${var.humber_id}-lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "${var.humber_id}-backend-pool"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_association" {
  for_each                = var.backend_nic_ids
  network_interface_id    = each.value
  ip_configuration_name   = var.backend_ip_config_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

