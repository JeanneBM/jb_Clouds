# Table of Contents

- [What is Ansible?](#what-is-ansible)
- [Key Concepts](#key-concepts)
  - [Configuration Management](#configuration-management)
  - [Inventory](#inventory)
  - [Playbooks](#playbooks)
  - [Roles](#roles)
  - [Modules](#modules)
  - [Tasks](#tasks)
  - [Variables](#variables)
- [Installation and Setup](#installation-and-setup)
- [Basic Workflow](#basic-workflow)
  - [Write](#write)
  - [Run](#run)
  - [Verify](#verify)
- [Directory Structure](#directory-structure)
- [Writing Ansible Playbooks](#writing-ansible-playbooks)
  - [Basic Syntax](#basic-syntax)
  - [Example: Installing Nginx](#example-installing-nginx)
- [Inventory Management](#inventory-management)
  - [Static Inventory](#static-inventory)
  - [Dynamic Inventory](#dynamic-inventory)
- [Roles](#roles-1)
  - [Creating a Role](#creating-a-role)
  - [Using a Role](#using-a-role)
- [Variables and Templates](#variables-and-templates)
  - [Defining Variables](#defining-variables)
  - [Using Variables](#using-variables)
  - [Jinja2 Templates](#jinja2-templates)
- [Best Practices](#best-practices)
- [Advanced Topics](#advanced-topics)
  - [Ansible Vault](#ansible-vault)
  - [Loops and Conditionals](#loops-and-conditionals)
  - [Ansible Galaxy](#ansible-galaxy)
- [Common Commands](#common-commands)
- [Troubleshooting](#troubleshooting)
- [Additional Resources](#additional-resources)

---

## What is Ansible?
Ansible is an open-source automation tool developed by Red Hat. It is used for configuration management, application deployment, task automation, and orchestration. Ansible is agentless, using SSH to communicate with managed nodes, and configurations are written in YAML.

- **Agentless**: No need for software agents on managed nodes; uses SSH.
- **Idempotent**: Ensures the same result regardless of how many times a task is run.
- **Declarative**: Define the desired state, and Ansible makes it happen.
- **Push-Based**: Ansible "pushes" configurations to nodes (unlike pull-based tools like Puppet).

## Key Concepts

### Configuration Management
Ansible manages the configuration of servers by defining their desired state (e.g., installing packages, editing files) and ensuring that state is achieved.

### Inventory
The inventory is a list of hosts (servers) that Ansible manages. It can be a static file or dynamically generated.

### Playbooks
Playbooks are YAML files that define a series of tasks to be executed on hosts. They are the core of Ansible automation.

### Roles
Roles are reusable units of organization for playbooks, tasks, and variables. They help modularize Ansible configurations.

### Modules
Modules are the building blocks of Ansible tasks. Each module performs a specific function (e.g., `apt` for package management, `file` for managing files).

### Tasks
Tasks are individual units of work in a playbook, executed sequentially. Each task calls a module.

### Variables
Variables allow parameterization of playbooks, making them reusable and flexible.

## Installation and Setup

Install Ansible:

### On Ubuntu:
```
sudo apt update
sudo apt install ansible
```

### On macOS (using Homebrew):
```
brew install ansible
```

### On CentOS/RHEL:
```
sudo yum install ansible
```

### Verify Installation:
```
ansible --version
```

### Set Up SSH:
Ensure SSH keys are configured for passwordless access to managed nodes.
```
ssh-keygen
ssh-copy-id user@remote_host
```

## Basic Workflow

Ansible operates using a straightforward workflow:

### Write
Write your automation logic in playbooks (`.yml` files) using YAML.

### Run
Execute the playbook using the `ansible-playbook` command.

### Verify
Check the managed nodes to confirm the desired state has been achieved.

## Directory Structure

A typical Ansible project might look like this:

```
my-ansible-project/
├── ansible.cfg          # Ansible configuration file
├── inventory/           # Inventory files (static or dynamic)
│   └── hosts.yml
├── playbooks/           # Playbooks directory
│   └── setup.yml
├── roles/               # Reusable roles
│   └── webserver/
│       ├── tasks/
│       ├── handlers/
│       ├── templates/
│       ├── files/
│       └── vars/
└── group_vars/          # Group variables
    └── all.yml
```

## Writing Ansible Playbooks

### Basic Syntax
Ansible playbooks are written in YAML. A playbook consists of plays, and each play contains tasks.

### Example: Installing Nginx
Below is an example of a playbook to install and start Nginx on a set of servers:

```
---
- name: Set up a web server
  hosts: webservers
  become: yes  # Run tasks as sudo
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: yes
```

Run the playbook:

```
ansible-playbook playbooks/setup.yml -i inventory/hosts.yml
```

## Inventory Management

### Static Inventory
A static inventory file lists hosts and groups. Example `hosts.yml`:

```
all:
  children:
    webservers:
      hosts:
        web1.example.com:
        web2.example.com:
    dbservers:
      hosts:
        db1.example.com:
```

### Dynamic Inventory
Dynamic inventory scripts or plugins (e.g., for AWS, Azure) generate the inventory dynamically. Example for AWS:

```
ansible-inventory -i aws_ec2.yml --graph
```


