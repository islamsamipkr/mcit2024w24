locals {
  subnetfolderlocation = "mcitsubnetyaml"

  subnet_yaml_files = [
    for file in fileset("${path.module}/${local.subnetfolderlocation}", "subnets.yaml") :
    yamldecode(file("${path.module}/${local.subnetfolderlocation}/${file}"))
  ]

  subnet_map = local.subnet_yaml_files[0].subnets

  subnet_list = [
    for key, value in local.subnet_map : {
      name   = key
      cidr   = value
    }
  ]
}

resource "azurerm_resource_group" "azuremcitsubnetrg" {
  name     = "mcitazuresubnet-rg"
  location = "canadacentral"
}

resource "azurerm_virtual_network" "azurevnsubnet" {
  name                = "example-vnet"
  location            = azurerm_resource_group.azuremcitsubnetrg.location
  resource_group_name = azurerm_resource_group.azuremcitsubnetrg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "azurermsubnetcreation" {
  for_each = { for s in local.subnet_list : s.name => s }

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.azuremcitsubnetrg.name
  virtual_network_name = azurerm_virtual_network.azurevnsubnet.name
  address_prefixes     = [each.value.cidr]
}
