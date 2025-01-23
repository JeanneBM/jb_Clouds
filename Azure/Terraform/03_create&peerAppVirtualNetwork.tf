touch terraform.tf provider.tf main.tf variables.tf terraform.tfvars

terraform.tf:
========================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider.tf:
========================

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

main.tf:
========================

locals {
  vnet_name = "${var.naming_prefix}-taconet"
}
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}
module "app_vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"


  resource_group_name = data.azurerm_resource_group.main.name
  vnet_location       = data.azurerm_resource_group.main.location
  use_for_each        = true

  vnet_name       = local.vnet_name
  address_space   = var.vnet_address_space
  subnet_names    = keys(var.subnet_configuration)
  subnet_prefixes = values(var.subnet_configuration)

  tags = var.common_tags
}

variables.tf:
========================

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group" */
}

variable "naming_prefix" {
  description = "Prefix to use for naming of resources" */
  type        = string
}

variable "common_tags" {
  description = "Map of tags to apply to all resources" */
  type        = map(string)
}

variable "vnet_address_space" {
  description = "List of address spaces to use for the VNET" */
  type        = list(string)
}

variable "subnet_configuration" {
  description = "Map of subnets to create in the VNET. Key is subnet name, value is address spaces." */
  type        = map(string)
} 

terraform.tfvars:
========================

resource_group_name = "RESOURCE_GROUP_NAME"
naming_prefix       = "tacowagon"
common_tags = {
  environment = "development"
}
vnet_address_space = ["10.55.0.0/16"]
subnet_configuration = {
  web = "10.55.0.0/24"
  app = "10.55.1.0/24"
}

terraform init; terraform apply; az network vnet list --query [].name

Update variables.tf:
========================
variable "hub_vnet" {
  description = "Hub vnet to peer with application vnet. Object with resource_group_name and name." */
  type = object({
    name                = string
    resource_group_name = string
  })
}

Update main.tf:
========================
data "azurerm_virtual_network" "hub" {
  resource_group_name = var.hub_vnet.resource_group_name
  name                = var.hub_vnet.name
}

resource "azurerm_virtual_network_peering" "spoke_2_hub" {
  name                      = "${module.app_vnet.vnet_name}-to-${var.hub_vnet.name}"
  resource_group_name       = data.azurerm_resource_group.main.name
  virtual_network_name      = module.app_vnet.vnet_name
  remote_virtual_network_id = data.azurerm_virtual_network.hub.id
}

resource "azurerm_virtual_network_peering" "hub_2_spoke" {
  name                      = "${var.hub_vnet.name}-to-${module.app_vnet.vnet_name}"
  resource_group_name       = var.hub_vnet.resource_group_name
  virtual_network_name      = var.hub_vnet.name
  remote_virtual_network_id = module.app_vnet.vnet_id
}

Update the terraform.tfvars:
========================
hub_vnet = {
  name                = "HUB_VNET_NAME"
  resource_group_name = "RESOURCE_GROUP_NAME"
}

terraform apply 
az network vnet peering list --resource-group RESOURCE_GROUP_NAME --vnet-name HUB_VNET_NAME
az network vnet peering list --resource-group RESOURCE_GROUP_NAME --vnet-name APP_VNET_NAME
