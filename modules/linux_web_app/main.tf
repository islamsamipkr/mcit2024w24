resource "azurerm_service_plan" "this" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.service_plan_sku_name
}

resource "azurerm_linux_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id
  tags                = var.tags

  site_config {
    always_on     = var.site_config.always_on
    http2_enabled = var.site_config.http2_enabled
  }

  app_settings = var.app_settings

  identity {
    type = var.identity_type
  }
}
