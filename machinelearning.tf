
resource "azurerm_resource_group" "ml_rg" {
  name     = "ml-resource-group"
  location = "East US"
}

resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                = "ml-workspace"
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  application_insights_id = azurerm_application_insights.ml_insights.id
  key_vault_id           = azurerm_key_vault.ml_vault.id
  storage_account_id     = azurerm_storage_account.ml_storage.id
}

resource "azurerm_machine_learning_compute_cluster" "ml_compute" {
  name                = "ml-compute-cluster"
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  workspace_name      = azurerm_machine_learning_workspace.ml_workspace.name
  vm_priority         = "Dedicated"
  vm_size             = "Standard_DS3_v2"
  min_instances       = 1
  max_instances       = 3
}

resource "azurerm_openai_service" "openai" {
  name                = "openai-service"
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  sku_name            = "S0"
}

resource "azurerm_machine_learning_inference_endpoint" "ml_endpoint" {
  name                = "ml-endpoint"
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  workspace_name      = azurerm_machine_learning_workspace.ml_workspace.name
}

output "openai_api_key" {
  value     = azurerm_openai_service.openai.primary_access_key
  sensitive = true
}

output "ml_endpoint_url" {
  value = azurerm_machine_learning_inference_endpoint.ml_endpoint.scoring_uri
}
