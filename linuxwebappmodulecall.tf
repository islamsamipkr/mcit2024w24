module "linux_web_app" {
  source              = "./modules/linux_web_app"
  name                = "my-mcit-linux-app"
  resource_group_name = azurerm_resource_group.mcit420zz5um.name
  location            = azurerm_resource_group.mcit420zz5um.location

  service_plan_name = "mymcitlinuxplan"
  service_plan_tier = "Basic"
  service_plan_size = "B1"

  site_config = {
    always_on     = true
    http2_enabled = true
  }

  app_settings = {
    "ENV" = "dev"
  }
}
