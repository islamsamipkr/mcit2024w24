

variable "regions" {
  type    = list(string)
  default = ["East US", "West Europe", "Southeast Asia"]
}

resource "azurerm_resource_group" "rg" {
  for_each = toset(var.regions)
  
  name     = "rg-${replace(each.value, " ", "-")}"
  location = each.value
}

resource "azurerm_virtual_network" "vnet" {
  for_each = azurerm_resource_group.rg
  
  name                = "vnet-${replace(each.value.location, " ", "-")}"
  location            = each.value.location
  resource_group_name = each.value.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  for_each = azurerm_virtual_network.vnet
  
  name                 = "subnet-${replace(each.value.location, " ", "-")}"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  for_each = { for idx, region in flatten([for region in var.regions : [for i in range(3) : {region = region, index = i}]]) :
    "${region.region}-${idx}" => region
  }
  
  name                = "nic-${replace(each.value.region, " ", "-")}-${each.value.index}"
  location            = each.value.region
  resource_group_name = azurerm_resource_group.rg[each.value.region].name
  
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet[each.value.region].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = azurerm_network_interface.nic
  
  name                = "vm-${replace(each.value.location, " ", "-")}-${each.value.index}"
  resource_group_name = azurerm_resource_group.rg[each.value.location].name
  location            = each.value.location
  size                = "Standard_DS1_v2"
  
  admin_username      = "azureuser"
  admin_password      = "P@ssword1234!"
  disable_password_authentication = false
  
  network_interface_ids = [each.value.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
