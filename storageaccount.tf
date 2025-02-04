resource "azurerm_storage_account" "mcitstorageaccount" {
  name                     = "bhstorageaccount"
  resource_group_name      = azurerm_resource_group.mcitbhrg01.name
  location                 = azurerm_resource_group.mcitbhrg01.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
