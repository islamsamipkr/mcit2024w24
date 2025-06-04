resource "azurerm_linux_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  tags                = var.tags

  site_config {
    always_on                                     = var.site_config.always_on
    ftps_state                                    = var.site_config.ftps_state
    http2_enabled                                 = var.site_config.http2_enabled
    websockets_enabled                            = var.site_config.websockets_enabled
    use_32_bit_worker                             = var.site_config.use_32_bit_worker
    container_registry_use_managed_identity       = var.site_config.container_registry_use_managed_identity
    container_registry_managed_identity_client_id = var.site_config.container_registry_managed_identity_client_id
    worker_count                                  = var.site_config.worker_count
  }

  app_settings = var.app_settings

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }
}
