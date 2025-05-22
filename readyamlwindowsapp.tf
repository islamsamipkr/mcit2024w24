#create windows app using yaml
locals{
  folderlocation="mcityaml"
  windows_app=[for file in fileset("${path.module}/${local.folderlocation}", "[^_]*.yaml") : yamldecode(file("${path.module}/${local.folderlocation}/${file}"))]
  windows_app_list = flatten([
    for app in local.windows_app : [
      for windowsapps in try(app.windowsapplist, []) :{
        name=windowsapps.name
        os_type=windowsapps.os_type
        sku_name=windowsapps.sku_name     
      }
    ]
])
}

resource "azurerm_resource_group" "mcitdevrm" {
  name     = "mcitwindowsapp"
  location = "canadacentral"
}
resource "azurerm_service_plan" "mcitwindowsserviceplan" {
  for_each            ={for sp in local.windows_app_list: "${sp.name}"=>sp }
  name                = each.value.name
  resource_group_name = azurerm_resource_group.mcitdevrm.name
  location            = azurerm_resource_group.mcitdevrm.location
  os_type             = each.value.os_type
  sku_name            = each.value.sku_name
}

resource "azurerm_windows_web_app" "mcitwindowswebapp" {
  for_each            = azurerm_service_plan.mcitwindowsserviceplan
  name                = each.value.name
  resource_group_name = azurerm_resource_group.mcitdevrm.name
  location            = azurerm_resource_group.mcitdevrm.location
  service_plan_id     = each.value.id

  site_config {}
}
