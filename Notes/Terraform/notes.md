# Table of Contents
- [What is Terraform?](#what-is-terraform)
- [Key Concepts](#key-concepts)
  - [Infrastructure as Code (IaC)](#infrastructure-as-code-iac)
  - [Providers](#providers)
  - [Resources](#resources)
  - [State](#state)
  - [Variables](#variables)
  - [Modules](#modules)
- [Installation and Setup](#installation-and-setup)
- [Basic Workflow](#basic-workflow)
  - [Write](#write)
  - [Plan](#plan)
  - [Apply](#apply)
  - [Destroy](#destroy)
- [Directory Structure](#directory-structure)
- [Writing Terraform Configurations](#writing-terraform-configurations)
  - [Basic Syntax](#basic-syntax)
  - [Example: AWS EC2 Instance](#example-aws-ec2-instance)
- [State Management](#state-management)
  - [Local State](#local-state)
  - [Remote State](#remote-state)
  - [State Locking](#state-locking)
- [Modules](#modules-1)
  - [Creating a Module](#creating-a-module)
  - [Using a Module](#using-a-module)
- [Variables and Outputs](#variables-and-outputs)
  - [Defining Variables](#defining-variables)
  - [Using Variables](#using-variables)
  - [Outputs](#outputs)
- [Best Practices](#best-practices)
- [Advanced Topics](#advanced-topics)
  - [Workspaces](#workspaces)
  - [Dynamic Blocks](#dynamic-blocks)
  - [Provisioners](#provisioners)
- [Common Commands](#common-commands)
- [Troubleshooting](#troubleshooting)
- [Additional Resources](#additional-resources)

---

## What is Terraform?
Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It allows you to define and manage infrastructure using declarative configuration files. Terraform supports multiple cloud providers (AWS, Azure, GCP, etc.) and on-premises infrastructure.

- **Declarative**: You define the desired end state, and Terraform figures out how to achieve it.
- **Provider-Agnostic**: Works with multiple cloud providers and services via plugins called "providers."
- **Version-Control Friendly**: Configurations are written in HCL (HashiCorp Configuration Language) or JSON, making them easy to version using Git.

---

## Key Concepts

### Infrastructure as Code (IaC)
IaC means managing infrastructure through code rather than manual processes. Terraform lets you define resources (e.g., VMs, networks) in configuration files, enabling automation, consistency, and repeatability.

### Providers
Providers are plugins that Terraform uses to interact with APIs of cloud providers or services (e.g., AWS, Azure, Kubernetes). Each provider offers a set of resources you can manage.

### Resources
Resources are the individual components of your infrastructure (e.g., an AWS EC2 instance, an Azure VM). They are defined in Terraform configuration files.

### State
Terraform maintains a state file (`terraform.tfstate`) that tracks the current state of your infrastructure. This file helps Terraform determine what changes are needed to reach the desired state.

### Variables
Variables allow you to parameterize your Terraform configurations, making them reusable and flexible.

### Modules
Modules are reusable sets of Terraform configurations. They allow you to organize and encapsulate infrastructure components.

---

## Installation and Setup
1. **Download Terraform**: Visit the [official Terraform website](https://www.terraform.io/downloads.html) and download the binary for your OS.
2. **Install**: Extract the binary and add it to your system's PATH.
   - On macOS/Linux: `mv terraform /usr/local/bin/`
   - On Windows: Add the path to your environment variables.
3. **Verify**: Run `terraform -version` to confirm installation.

---

## Basic Workflow
Terraform operates using a straightforward workflow:

### Write
Write your infrastructure code in `.tf` files using HCL or JSON.

### Plan
Run `terraform plan` to see a preview of the changes Terraform will make.

### Apply
Run `terraform apply` to execute the changes and provision resources.

### Destroy
Run `terraform destroy` to delete all managed resources.

---

## Directory Structure
A typical Terraform project might look like this:
