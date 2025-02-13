data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "mlrg" {
  name     = "ml_rg-resources"
  location = "West Europe"
}

resource "azurerm_application_insights" "applicationinsight" {
  name                = "workspace-example-ai"
  location            = azurerm_resource_group.mlrg.location
  resource_group_name = azurerm_resource_group.mlrg.name
  application_type    = "web"
}

resource "azurerm_key_vault" "azurekeyvault" {
  name                = "workspaceexamplekeyvault"
  location            = azurerm_resource_group.mlrg.location
  resource_group_name = azurerm_resource_group.mlrg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
}

resource "azurerm_storage_account" "azurestorageaccount" {
  name                     = "workspacestorageaccount"
  location                 = azurerm_resource_group.mlrg.location
  resource_group_name      = azurerm_resource_group.mlrg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_machine_learning_workspace" "example" {
  name                    = "example-workspace"
  location                = azurerm_resource_group.mlrg.location
  resource_group_name     = azurerm_resource_group.mlrg.name
  application_insights_id = azurerm_application_insights.applicationinsight.id
  key_vault_id            = azurerm_key_vault.azurekeyvault.id
  storage_account_id      = azurerm_storage_account.azurestorageaccount.id

  identity {
    type = "SystemAssigned"
  }
}
