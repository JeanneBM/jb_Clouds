VNet: 10.64.0.0/16
ingress: "10.64.4.0/24"
nodes: "10.64.0.0/22"


mkdir aks_cluster; cd aks_cluster; touch terraform.tf providers.tf variables.tf main.tf terraform.tfvars outputs.tf

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

providers.tf:
=================
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

variables.tf:
=================
variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

variable "prefix" {
  description = "The prefix which should be used for all resources"
  type        = string
  default     = "tacowagon"
}

variable "common_tags" {
  description = "Map of tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "vnet_address_space" {
  description = "List of address spaces to use for the VNET."
  type        = list(string)
}

variable "subnet_configuration" {
  description = "Map of subnets to create in the VNET. Key is subnet name, value is address spaces."
  type        = map(string)
}

main.tf:
=================
data "azurerm_resource_group" "main" {
    name = var.resource_group_name
}
module "aks_vnet" {
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = data.azurerm_resource_group.main.name
  vnet_location       = data.azurerm_resource_group.main.location
  use_for_each        = true

  vnet_name       = data.azurerm_resource_group.main.name
  address_space   = var.vnet_address_space
  subnet_names    = keys(var.subnet_configuration)
  subnet_prefixes = values(var.subnet_configuration)

  tags = var.common_tags

}

terraform.tfvars:
=================
resource_group_name = "RESOURCE_GROUP_NAME" */
subnet_configuration = {
  ingress = "10.64.4.0/24"
  nodes   = "10.64.0.0/22"
}
vnet_address_space = ["10.64.0.0/16"]


terraform init; terraform apply -auto-apply

AKS:
=================================================================================================================================================
Sku tier: Standard
Kubernetes version: latest
Upgrades: Automatic and Node Image OS
Log analytics: Disabled
System nodes: 2
System node size: Standard_D2s_v3
Network plugin: Azure CNI
Network policy: Azure
Load balancer: Standard
Node pools: 1
Node pool count: 1
Node pool VM size: Standard_D2s_v3
RBAC: enabled, no Entra ID/Azure AD integration

+main.tf:
=================
module "app" {
  source  = "Azure/aks/azurerm"
  version = "8.0.0"

  # Cluster base config
  resource_group_name             = data.azurerm_resource_group.main.name
  prefix                          = var.prefix
  cluster_name_random_suffix      = true
  sku_tier                        = "Standard"
  node_os_channel_upgrade         = "NodeImage"
  automatic_channel_upgrade       = "node-image"
  log_analytics_workspace_enabled = false

  # Cluster system pool
  enable_auto_scaling = false
  agents_count        = 2
  agents_size         = "Standard_D2s_v3"
  agents_pool_name    = "systempool"

  # Cluster networking
  vnet_subnet_id = module.aks_vnet.vnet_subnets_name_id["nodes"]
  network_plugin = "azure"
  network_policy = "azure"

  # Cluster node pools
  node_resource_group = "MC_${var.resource_group_name}_${var.prefix}"
  node_pools = {
    apppool1 = {
      name           = lower(substr(var.prefix, 0, 8)) # Max of 8 characters and must be lowercase
      vm_size        = "Standard_D2s_v3"
      node_count     = 1
      vnet_subnet_id = module.aks_vnet.vnet_subnets_name_id["nodes"]
    }
  }

  # Cluster Authentication
  local_account_disabled            = false
  role_based_access_control_enabled = true
  rbac_aad                          = false

}

outputs.tf:
=================
output "host" {
  value     = module.app.cluster_fqdn
  sensitive = true
}

output "client_certificate" {
  value     = module.app.client_certificate
  sensitive = true
}

output "client_key" {
  value     = module.app.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = module.app.cluster_ca_certificate
  sensitive = true
}

terraform init; terraform apply -auto-approve

Flux CD[Helm]:
=================================================================================================================================================
+terraform.tf:
=================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~>2.0"
    }
  }
}

+providers.tf:
=================
provider "helm" {
  kubernetes {
    host                   = module.app.cluster_fqdn
    client_certificate     = base64decode(module.app.client_certificate)
    client_key             = base64decode(module.app.client_key)
    cluster_ca_certificate = base64decode(module.app.cluster_ca_certificate)
  }
}

+main.tf:
=================
resource "helm_release" "flux" {
  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  name             = "flux2"
  namespace        = "flux-system"
  create_namespace = true

  depends_on = [module.app]
}

terraform init; terraform apply -auto-approve

cd aks_config; cd ..; mkdir flux_app; cd flux_app; touch terraform.tf providers.tf variables.tf main.tf terraform.tfvars

terraform.tf:
=================
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.0"
    }
  }
}

providers.tf:
=================
provider "kubernetes" {
  host                   = "https://${data.terraform_remote_state.aks.outputs.host}"
  client_certificate     = base64decode(data.terraform_remote_state.aks.outputs.client_certificate)
  client_key             = base64decode(data.terraform_remote_state.aks.outputs.client_key)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.aks.outputs.cluster_ca_certificate)
}

variables.tf:
=================
variable "flux_git_repo_url" {
  description = "URL of GitHub Repo for Flux Configuration"
  type        = string
}

variable "flux_git_repo_branch" {
  description = "Branch name for Flux Configuration"
  type        = string
  default     = "main"
}

main.tf:
=================
data "terraform_remote_state" "aks" {
  backend = "local"

  config = {
    path = "../aks_cluster/terraform.tfstate"
  }
}

resource "kubernetes_manifest" "flux_source" {
  manifest = {
    apiVersion = "source.toolkit.fluxcd.io/v1"
    kind       = "GitRepository"
    metadata = {
      name      = "sampleapp"
      namespace = "flux-system"
    }

    spec = {
      interval = "1m"
      ref = {
        branch = var.flux_git_repo_branch
      }
      url = var.flux_git_repo_url
    }
  }
}

resource "kubernetes_manifest" "flux_infra" {
  manifest = {
    apiVersion = "kustomize.toolkit.fluxcd.io/v1"
    kind       = "Kustomization"
    metadata = {
      name      = "infra"
      namespace = "flux-system"
    }

    spec = {
      path = "./infrastructure"
      interval = "30m"
      sourceRef = {
        kind = "GitRepository"
        name = "sampleapp"
      }
      prune = true
    }
  }
}

resource "kubernetes_manifest" "flux_app" {
  manifest = {
    apiVersion = "kustomize.toolkit.fluxcd.io/v1"
    kind       = "Kustomization"
    metadata = {
      name      = "dotnetapp"
      namespace = "flux-system"
    }

    spec = {
      path     = "./dotnet-lb"
      interval = "1m"
      sourceRef = {
        kind = "GitRepository"
        name = "sampleapp"
      }
      prune = true
    }
  }
}

terraform.tfvars:
=================
flux_git_repo_url = "https://github.com/ned1313/taco-fleet"


terraform init; terraform apply -auto-approve
