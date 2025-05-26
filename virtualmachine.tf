locals {
  vm_names = ["webvm-1", "webvm-2", "webvm-3"]

  vm_map = {
    for index, name in local.vm_names :
    index => name
  }
}
resource "azurerm_resource_group" "mcitvmrm" {
  name     = "mcitvmrg"
  location = "East US"
}


resource "azurerm_virtual_network" "mcitvmvirtualnetwork" {
  name                = "mcit-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mcitvmrm.location
  resource_group_name = azurerm_resource_group.mcitvmrm.name
}


resource "azurerm_subnet" "mcitvmsubnet" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.mcitvmrm.name
  virtual_network_name = azurerm_virtual_network.mcitvmvirtualnetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "mcitni" {
  for_each            = local.vm_map
  name                = "${each.value}-nic"
  location            = azurerm_resource_group.mcitvmrm.location
  resource_group_name = azurerm_resource_group.mcitvmrm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mcitvmsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_windows_virtual_machine" "mcitazurevm" {
  for_each            = local.vm_map
  name                = each.value
  location            = azurerm_resource_group.mcitvmrm.location
  resource_group_name = azurerm_resource_group.mcitvmrm.name
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "Password1234!"

  network_interface_ids = [
    azurerm_network_interface.mcitni[each.key].id
  ]

  os_disk {
    name                 = "${each.value}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
