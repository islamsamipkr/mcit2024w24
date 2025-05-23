locals {
  node_pools = {
    internal = {
      vm_size    = "Standard_DS2_v2"
      node_count = 1
      tags = {
        Environment = "Production"
      }
    }
    analytics = {
      vm_size    = "Standard_D4_v3"
      node_count = 2
      tags = {
        Environment = "Analytics"
      }
    }
    staging = {
      vm_size    = "Standard_B2s"
      node_count = 1
      tags = {
        Environment = "Staging"
      }
    }
  }
}
