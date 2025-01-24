az group list --query [].name; az network vnet list --query [].name
touch provider.tf variables.tf terraform.tf main.tf outputs.tf terraform.tfvars

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
  description = "Name of the subnet to use in the Virtual Network. Defaults to app."
  type        = string
  default     = "app"
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
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_subnet" "app" {
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = var.vnet_name
  name                 = var.subnet_name
}

outputs.tf:
==================
output "app_subnet_id" {
  value = data.azurerm_subnet.app.id
}

terraform.tfvars:
==================
resource_group_name = "RESOURCE_GROUP_NAME"
vnet_name           = "VNET_NAME"
Deploy the configuration and verify the correct output is displayed in the terminal.

terraform init; terraform apply -auto-approve

Add to the main.tf:
==================
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_public_ip" "pip" {

  allocation_method   = "Static"
  location            = data.azurerm_resource_group.main.location
  name                = "pip-${var.vm_name}"
  resource_group_name = data.azurerm_resource_group.main.name
  sku                 = "Standard"
}

module "linux" {
  source  = "Azure/virtual-machine/azurerm"
  version = "1.1.0"

  location                   = data.azurerm_resource_group.main.location
  image_os                   = "linux"
  resource_group_name        = data.azurerm_resource_group.main.name
  allow_extension_operations = false
  boot_diagnostics           = true
  new_network_interface = {
    ip_forwarding_enabled = false
    ip_configurations = [
      {
        public_ip_address_id = azurerm_public_ip.pip.id
        primary              = true
      }
    ]
  }
  admin_username = var.admin_username
  admin_ssh_keys = [
    {
      public_key = tls_private_key.ssh.public_key_openssh
    }
  ]
  name = var.vm_name
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  os_simple = "UbuntuServer"
  size      = "Standard_F2"
  subnet_id = data.azurerm_subnet.app.id

  custom_data = base64encode(templatefile("${path.module}/custom_data.tpl", {
    admin_username = var.admin_username
    port           = var.application_port
  }))

}
Add the following input variables to your variables.tf file:
variable "vm_name" {
  description = "Name of virtual machine to create."
  type        = string
}

variable "admin_username" {
  description = "Admin username for virtual machine. Defaults to azureuser."
  type        = string
  default     = "azureuser"
}

variable "application_port" {
  description = "Port to use for the flask application. Defaults to 80."
  type        = number
  default     = 80
}

Add to the outputs.tf:
==================
output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

Add to the terraform.tfvars:
==================
vm_name             = "taco-wagon-app"
Initialize the configuration to add the virtual-machine module and TLS provider.
terraform init
Validate and deploy the configuration.
terraform validate
terraform apply -auto-approve
Add a Network Security Group to the VM
In this objective, you will add a Network Security Group (NSG) and NSG rule to allow traffic to the application port defined for the virtual machine. Then associated the NSG with the virtual machine's network interface.

Add to the main.tf:
==================
resource "azurerm_network_security_group" "app_vm" {
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  name                = "nsg-${var.vm_name}"
}

resource "azurerm_network_security_rule" "http" {
  network_security_group_name = azurerm_network_security_group.app_vm.name
  resource_group_name         = azurerm_network_security_group.app_vm.resource_group_name
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

resource "azurerm_network_interface_security_group_association" "app_vm" {
  network_interface_id      = module.linux.network_interface_id
  network_security_group_id = azurerm_network_security_group.app_vm.id
}

terraform validate
terraform apply -auto-approve
