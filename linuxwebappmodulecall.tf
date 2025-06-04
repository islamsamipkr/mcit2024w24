module "linux_web_app" {
  source              = "./module/linux_web_app"
  name                = "mcit-linux-web-app"
  resource_group_name = azurerm_resource_group.mcit420zz5um.name
  location            = azurerm_resource_group.mcit420zz5um.location
  service_plan_id     = azurerm_app_service_plan.mcitmoduleserviceplan.id
  tags = {
    environment = "production"
  }
  site_config = {
    always_on = true
  }
  app_settings = {
    "APP_SETTING_KEY" = "value"
  }
}
