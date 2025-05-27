resource "azurerm_resource_group" "mcitnetworkrg" {
  name     = "mcitnetworkrg"
  location = "East US"
}

locals {
  cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

resource "azurerm_virtual_network" "mcitvirtualnetwork" {
  name                = "mcit-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mcitnetworkrg.location
  resource_group_name = azurerm_resource_group.mcitnetworkrg.name
}

resource "azurerm_subnet" "subnets" {
  for_each             = { for index, cidr in local.cidrs : "subnet${index + 1}" => cidr }
  name                 = each.key
  resource_group_name  = azurerm_resource_group.mcitnetworkrg.name
  virtual_network_name = azurerm_virtual_network.mcitvirtualnetwork.name
  address_prefixes     =[each.value]
                         }
