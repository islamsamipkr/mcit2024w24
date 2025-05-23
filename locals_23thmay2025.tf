locals {
  node_pools = {
    prod = {
      vm_size    = "Standard_DS2_v2"
      node_count = 1
      tags = {
        Environment = "prod"
      }
    }
    dev = {
      vm_size    = "Standard_D4_v3"
      node_count = 2
      tags = {
        Environment = "dev"
      }
    }
    qa = {
      vm_size    = "Standard_B2s"
      node_count = 1
      tags = {
        Environment = "qa"
      }
    }
  }
}
