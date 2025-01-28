az login; az group list --query [].name; 

touch terraform.tf providers.tf variables.tf main.tf terraform.tfvars

terraform.tf:
==================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.70.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.0"
    }
  }
}

providers.tf:
==================
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "azapi" {
  skip_provider_registration = true
}

variables.tf:
==================
variable "resource_group_name" {
  description = "Name of resource group to use."
  type        = string
}

main.tf:
==================
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "random_integer" "main" {
  min = 10000
  max = 99999
}

resource "azurerm_storage_account" "main" {
  name                      = "tacowagon${random_integer.main.result}"
  resource_group_name       = data.azurerm_resource_group.main.name
  location                  = data.azurerm_resource_group.main.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  blob_properties {
    last_access_time_enabled = true
  }
}

resource "azapi_update_resource" "local_user" {
  type        = "Microsoft.Storage/storageAccounts@2021-09-01"
  resource_id = azurerm_storage_account.main.id

  body = jsonencode({
    properties = {
      isLocalUserEnabled = false
    }
  })
}

resource "azapi_resource" "cold_storage_policy" {
  type      = "Microsoft.Storage/storageAccounts/managementPolicies@2023-01-01"
  name      = "default"
  parent_id = azurerm_storage_account.main.id

  body = jsonencode({
    properties = {
      policy = {
        rules = [
          {
            name    = "default"
            enabled = true
            type    = "Lifecycle"
            definition = {
              filters = {
                blobTypes = ["blockBlob"]
              }
              actions = {
                baseBlob = {
                  tierToCold = {
                    daysAfterLastAccessTimeGreaterThan = 90
                  }
                  tierToCool = {
                    daysAfterLastAccessTimeGreaterThan = 365
                  }
                }
              }
            }
          }
      ] }
    }
  })
}

terraform.tfvars:
==================
resource_group_name = "RESOURCE_GROUP_NAME"

terraform init; terraform apply -auto-approve

+terraform.tf:
==================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.98.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.0"
    }
  }
}

+main.tf:
==================
resource "azurerm_storage_account" "main" {
  name                      = "tacowagon${random_integer.main.result}"
  resource_group_name       = data.azurerm_resource_group.main.name
  location                  = data.azurerm_resource_group.main.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  blob_properties {
    last_access_time_enabled = true
  }
  local_user_enabled = false
}

resource "azurerm_storage_management_policy" "brrrr" {
  storage_account_id = azurerm_storage_account.main.id
  rule {
    name    = "default"
    enabled = true
    filters {
      blob_types = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_last_access_time_greater_than = 90
        tier_to_cold_after_days_since_last_access_time_greater_than = 365
      }
    }
  }
}

-main.tf:
==================
azapi_update_resource

terraform init -upgrade; terraform apply -auto-approve
