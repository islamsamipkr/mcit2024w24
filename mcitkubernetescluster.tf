resource "azurerm_resource_group" "mcitkubernetesclass" {
  name     = "mcitkubeclasssami"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "mcitkubecluster" {
  name                = "mcitaks1"
  location            = azurerm_resource_group.mcitkubernetesclass.location
  resource_group_name = azurerm_resource_group.mcitkubernetesclass.name
  dns_prefix          = "mcitaksdnsprefix"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}
