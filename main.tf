# provider "azurerm" {
#   version = "~> 3.70.0"
#   subscription_id = var.subscription_id
#   client_id = var.client_id
#   client_secret = var.client_secret
#   tenant_id = var.tenant_id
# }

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "main-vnet"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_cidr
}

# resource "azurerm_subnet" "main" {
#   count = length(var.subnet_names)
#   name = var.subnet_names[count.index]
#   resource_group_name = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes = var.public_cidr
# }

resource "azurerm_subnet" "public" {
  name                 = "pub-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.public_cidr
}

# resource "azurerm_subnet" "private" {
#   name = "priv-subnet"
#   resource_group_name = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefix = var.private_cidr
# }

resource "azurerm_public_ip" "main" {
  name                = "main-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "my-network-interface"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "my-ip-configuration"
    subnet_id                     = azurerm_subnet.public.id
    public_ip_address_id          = azurerm_public_ip.main.id
    private_ip_address_allocation = "Dynamic"
  }
}

