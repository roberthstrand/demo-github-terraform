module "kubernetes" {
  source  = "crayon/aks/azurerm"
  version = "1.1.0"

  name           = "tfgh-demo"
  resource_group = azurerm_resource_group.test.name
  subnet_id      = azurerm_subnet.aks.id
  admin_groups   = data.azuread_groups.admins.object_ids

  default_node_pool = {
    name                = "default"
    vm_size             = "Standard_B1s"
    node_count          = 1
    enable_auto_scaling = false
    min_count           = null
    max_count           = null
    additional_settings = {}
  }

  depends_on = [azurerm_resource_group.test]
}
