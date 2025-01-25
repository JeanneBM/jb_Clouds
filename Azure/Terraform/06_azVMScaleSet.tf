provider.tf:
==================

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

variables.tf:
==================
variable "resource_group_name" {
  description = "Name of resource group provided by the lab."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network provided by the lab."
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet to use in the Virtual Network. Defaults to web."
  type        = string
  default     = "web"
}

terraform.tf:
==================
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

main.tf:
==================
data "azurerm_resource_group" "vmss" {
  name = var.resource_group_name
}

data "azurerm_subnet" "web" {
  resource_group_name  = data.azurerm_resource_group.vmss.name
  virtual_network_name = var.vnet_name
  name                 = var.subnet_name
}

outputs.tf:
==================
output "web_subnet_id" {
  value = data.azurerm_subnet.web.id
}

terraform.tfvars:
==================
resource_group_name = "RESOURCE_GROUP_NAME"
vnet_name           = "VNET_NAME"

terraform init; terraform apply -auto-approve

+ load balancer to main.tf:
==================
module "tacoweb" {
  source  = "Azure/loadbalancer/azurerm"
  version = "4.4.0"

  resource_group_name = data.azurerm_resource_group.vmss.name
  location            = data.azurerm_resource_group.vmss.location

  type              = "public"
  pip_sku           = "Standard"
  allocation_method = "Static"
  lb_sku            = "Standard"
  prefix            = var.prefix


  lb_port = {
    http = ["80", "Tcp", "${var.application_port}"]
  }

  lb_probe = {
    http = ["Http", "${var.application_port}", "/"]
  }

}

+ variables.tf:
==================
variable "prefix" {
  description = "Naming prefix for resources. Should be 3-8 characters."
  type        = string
  default     = "tacoweb"

  validation {
    condition     = length(var.prefix) >= 3 && length(var.prefix) <= 8
    error_message = "Naming prefix should be between 3-8 characters. Submitted value was ${length(var.prefix)}."
  }
}

variable "application_port" {
  description = "Port to use for the flask application. Defaults to 8080."
  type        = number
  default     = 8080
}

+ outputs.tf:
==================

output "public_ip" {
  value = module.tacoweb.azurerm_public_ip_address
}

terraform init; terraform validate; terraform apply -auto-approve

+ main.tf:
==================

resource "azurerm_network_security_group" "vmss" {
  resource_group_name = data.azurerm_resource_group.vmss.name
  location            = data.azurerm_resource_group.vmss.location
  name                = "nsg-${var.prefix}-vmss"
}

resource "azurerm_network_security_rule" "vmss" {
  network_security_group_name = azurerm_network_security_group.vmss.name
  resource_group_name         = azurerm_network_security_group.vmss.resource_group_name
  name                        = "http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_range      = var.application_port
  destination_address_prefix  = "*"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = "${var.prefix}-vmss"
  resource_group_name = data.azurerm_resource_group.vmss.name
  location            = data.azurerm_resource_group.vmss.location
  sku                 = var.vm_size
  instances           = var.vmss_count
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.ssh.public_key_openssh
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                      = "${var.prefix}-nic"
    network_security_group_id = azurerm_network_security_group.vmss.id
    primary                   = true
    ip_configuration {
      name                                   = "primary"
      load_balancer_backend_address_pool_ids = [module.tacoweb.azurerm_lb_backend_address_pool_id]
      primary                                = true
      subnet_id                              = data.azurerm_subnet.web.id
    }
  }

  health_probe_id = module.tacoweb.azurerm_lb_probe_ids[0]

  custom_data = base64encode(templatefile("${path.module}/custom_data.tpl", {
    admin_username = var.admin_username
    port           = var.application_port
  }))

  depends_on = [module.tacoweb]
}

+ variables.tf:
==================
variable "vm_size" {
  description = "Size of virtual machine to create. Defaults to Standard_F2."
  type        = string
  default     = "Standard_F2"
}

variable "vmss_count" {
  description = "Starting number of VMSS instances to create. Defaults to 2."
  type        = number
  default     = 2

  validation {
    condition     = var.vmss_count >= 1
    error_message = "Count must be 1 or greater. Submitted value was ${var.vmss_count}."
  }
}

variable "admin_username" {
  description = "Admin username for virtual machine. Defaults to azureuser."
  type        = string
  default     = "azureuser"
}


Add a custom_data.tpl 

terraform validate; terraform apply -auto-approve
