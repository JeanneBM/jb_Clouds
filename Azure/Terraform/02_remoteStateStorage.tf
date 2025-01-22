mkdir create_storage; cd create_storage; touch terraform.tf main.tf variables.tf outputs.tf terraform.tfvars

terraform.tf:
=================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

main.tf:
=================
provider "azurerm" {
  features {}
  skip_provider_registration = true
  storage_use_azuread        = true
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "random_integer" "main" {
  min = 10000
  max = 99999
}

resource "azurerm_storage_account" "main" {
  name                = "${lower(var.prefix)}taco${random_integer.main.result}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  account_tier                      = "Standard"
  account_kind                      = "StorageV2"
  account_replication_type          = "GRS"
  enable_https_traffic_only         = true
  min_tls_version                   = "TLS1_2"
  shared_access_key_enabled         = false
  default_to_oauth_authentication   = true
  infrastructure_encryption_enabled = false


  blob_properties {
    versioning_enabled            = true
    change_feed_enabled           = true
    change_feed_retention_in_days = 90
    last_access_time_enabled      = true

    delete_retention_policy {
      days = 30
    }

    container_delete_retention_policy {
      days = 30
    }

  }

  sas_policy {
    expiration_period = "00.02:00:00"
    expiration_action = "Log"
  }

  timeouts {
    create = "5m"
    read   = "5m"
  }

}

resource "azurerm_storage_container" "main" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

variables.tf:
=================
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group" /*
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources" /*
}
  
outputs.tf:
=================
output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

terraform.tfvars:
=================
prefix              = "dev"
resource_group_name = "RESOURCE_GROUP_NAME" /*


az group list --query [].Name; terraform init; terraform apply -auto-approve; terraform output



cd .. ; mkdir vnet_config; cd vnet_config; touch terraform.tf main.tf terraform.tfvars


terraform.tf
=================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

main.tf:
=================
provider "azurerm" {
  features {}
  skip_provider_registration = true
  storage_use_azuread        = true
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group provided by the lab."
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "main" {
  name                = "taco-wagon-app"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  address_space = ["10.42.0.0/24"]
}

terraform.tfvars:
=================
resource_group_name = "RESOURCE_GROUP_NAME"

terraform init; terraform apply -auto-approve

Update vnet_config\terraform.tf:
=================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    
  }
}

touch backend-config.tfbackend; vim backend-config.tfbackend 
backend-config.tfbackend:
=================
resource_group_name  = "RESOURCE_GROUP_NAME"
storage_account_name = "STORAGE_ACCOUNT_NAME"
container_name       = "tfstate"
key                  = "terraform.tfstate"
use_azuread_auth     = true

terraform init -backend-config="backend-config.tfbackend"
cat terraform.tfstate
terraform state list
