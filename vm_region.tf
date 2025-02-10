provider "azurerm" {
  features {}
}

variable "regions" {
  type    = list(string)
  default = ["East US", "West Europe", "Southeast Asia"]
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-global"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-global"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-global"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  for_each = { for idx, region in flatten([for region in var.regions : [for i in range(3) : { id = "${region}-${i}", region = region }]]) :
    idx => region
  }
  
  name                = "nic-${each.value.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = azurerm_network_interface.nic
  
  name                = "vm-${each.value.id}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
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
