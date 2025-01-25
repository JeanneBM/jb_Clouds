az login
mkdir vnet_import; cd vnet_import

aztfexport rg "RESOURCE_GROUP_NAME"

Update provider.tf:
==========================
provider "azurerm" {
  features {
  }
  skip_provider_registration = true
}

Update main.tf:
==========================
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

variable "resource_group_name" {
  description = "Name of resource group" */
  type        = string
}
resource "azurerm_virtual_network" "res-1" {
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.main.location
  name                = "taco-wagon-import"
  resource_group_name = data.azurerm_resource_group.main.name
}
resource "azurerm_subnet" "res-2" {
  address_prefixes     = ["10.0.1.0/24"]
  name                 = "app"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.res-1.name
}
resource "azurerm_subnet" "res-3" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "web"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.res-1.name
}

Update terraform.tfvars:
==========================
resource_group_name = "RESOURCE_GROUP_NAME"

terraform plan
