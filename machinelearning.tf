
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

resource "azapi_resource" "openai_service" {
  type      = "Microsoft.CognitiveServices/accounts@2022-12-01"
  name      = "openai-service"
  location  = azurerm_resource_group.ml_rg.location
  parent_id = azurerm_resource_group.ml_rg.id

  body = jsonencode({
    kind = "OpenAI"
    sku = {
      name = "S0"
    }
    properties = {}
  })
}

resource "azurerm_machine_learning_inference_endpoint" "ml_endpoint" {
  name                = "ml-endpoint"
  location            = azurerm_resource_group.ml_rg.location
  resource_group_name = azurerm_resource_group.ml_rg.name
  workspace_name      = azurerm_machine_learning_workspace.ml_workspace.name
}

output "openai_api_key" {
  value     = azapi_resource.openai_service.body["properties"]["apiKey"]
  sensitive = true
}

output "ml_endpoint_url" {
  value = azurerm_machine_learning_inference_endpoint.ml_endpoint.scoring_uri
}
