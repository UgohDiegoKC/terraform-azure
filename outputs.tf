output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}

output "subnet_name" {
  value = azurerm_subnet.public.name
}

# output "subnet_name" {
#   value = azurerm_subnet.private.name
# }

output "public_ip_address" {
  value = azurerm_public_ip.main.ip_address
}

output "network_interface_name" {
  value = azurerm_network_interface.main.name
}

