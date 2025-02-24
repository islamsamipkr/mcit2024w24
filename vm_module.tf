module "mcit_vm" {
  source = "github.com/islamsamipkr/mcit-terraform-azurerm-vm"

  resource_group_name          = "myResourceGroup"
  location                     = "East US"
  vm_os_simple                 = "UbuntuServer"
  admin_username               = "adminuser"
  admin_password               = "P@ssw0rd1234!"
  vnet_subnet_id               = "/subscriptions/<subscription_id>/resourceGroups/<resource_group>/providers/Microsoft.Network/virtualNetworks/<vnet_name>/subnets/<subnet_name>"
  nb_instances                 = 1
  remote_port                  = 22
  vm_size                      = "Standard_DS1_v2"
  storage_account_type         = "Standard_LRS"
  boot_diagnostics             = true
  delete_os_disk_on_termination = true
}
