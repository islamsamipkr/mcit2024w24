provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mcitbhrg01" {
  name     = "mcitbhrg"
  location = "canadacentral"
}

resource "azurerm_virtual_network" "mcitbhrg01" {
  name                = "mcitbhnetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mcitbhrg01.location
  resource_group_name = azurerm_resource_group.mcitbhrg01.name
}

resource "azurerm_subnet" "mcitbhsubnet" {
  name                 = "mcitbhinternal"
  resource_group_name  = azurerm_resource_group.mcitbhrg01.name
  virtual_network_name = azurerm_virtual_network.mcitbhrg01.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "mcitbhnic" {
  name                = "mcitbhnic"
  location            = azurerm_resource_group.mcitbhrg01.location
  resource_group_name = azurerm_resource_group.mcitbhrg01.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mcitbhrg01.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "mcitbhmachine"
  resource_group_name = azurerm_resource_group.mcitbhrg01.name
  location            = azurerm_resource_group.mcitbhrg01.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.mcitbhnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
