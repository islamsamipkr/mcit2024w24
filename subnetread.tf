locals {
  subnet_config_raw = yamldecode(file("${path.module}/subnets.yaml"))
  subnet_config     = local.subnet_config_raw["subnets"]
}

resource "azurerm_resource_group" "mcitsubnetrm" {
  name     = "mcitsubnet-resources"
  location = "East US"
}

resource "azurerm_virtual_network" "mcitvnetmay" {
  name                = "mcitmay-vnet"
  location            = azurerm_resource_group.mcitsubnetrm.location
  resource_group_name = azurerm_resource_group.mcitsubnetrm.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "mcitazuresubnet" {
  for_each             = local.subnet_config
  name                 = each.key
  resource_group_name  = azurerm_resource_group.mcitsubnetrm.name
  virtual_network_name = azurerm_virtual_network.mcitvnetmay.name
  address_prefixes     = [each.value]
}
