module "linux_web_app" {
  source              = "./module/linux_web_app/linux-web-app"
  name                = "my-linux-web-app"
  location            = "East US"
  resource_group_name = "my-resource-group"
  service_plan_id     = azurerm_app_service_plan.example.id
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
