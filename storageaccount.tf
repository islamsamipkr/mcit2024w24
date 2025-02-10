resource "azurerm_storage_account" "mcitstorageaccount" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.mcit420zz5um.name
  location                 = azurerm_resource_group.mcit420zz5um.location
  account_tier             = var.account_tier
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
variable "storage_account_names" {
  type    = list(string)
  default = [
    "mcitstorageaccountname1"
  ]
}

resource "azurerm_storage_account" "mcitstorageaccountexample" {
  count                    = length(var.storage_account_names)
  name                     = var.storage_account_names[count.index]
  resource_group_name      = azurerm_resource_group.mcit420zz5um.name
  location                 = azurerm_resource_group.mcit420zz5um.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
