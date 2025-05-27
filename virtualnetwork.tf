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
/* 
for 0,"10.0.1.0/24" in ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] :"subnet${0 + 1}"(key) =>"10.0.1.0/24"(value)
for 1,"10.0.2.0/24" in ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] :"subnet${1 + 1}"(key) =>"10.0.2.0/24"(value)
for 2,"10.0.3.0/24" in ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] :"subnet${2 + 1}"(key) =>"10.0.3.0/24"(value)
*/
  name                 = each.key
  resource_group_name  = azurerm_resource_group.mcitnetworkrg.name
  virtual_network_name = azurerm_virtual_network.mcitvirtualnetwork.name
  address_prefixes     =[each.value]
                         }
