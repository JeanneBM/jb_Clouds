# Networking Concepts in Cloud (AWS Focus)

## 1. Virtual Private Cloud (VPC)
- A **logically isolated network** within a cloud provider (e.g., AWS, Azure).
- Allows control over networking configurations, including IP addressing, subnets, route tables, and security.
- **Default VPC:** Created automatically, comes with internet access.
- **Custom VPC:** Requires manual configuration (subnets, routing, security).

## 2. Subnets
- A VPC is divided into **subnets** for better resource organization and security.
- **Types of Subnets**:
  - **Public Subnet:** Has a route to the **Internet Gateway (IGW)**, allowing internet access.
  - **Private Subnet:** No direct internet access; can use a NAT Gateway for outbound traffic.
  - **Isolated Subnet:** No internet access at all (useful for secure workloads).
- Each subnet is associated with a **specific Availability Zone (AZ).**

## 3. Security Groups & Network ACLs
- **Security Groups (SGs):**
  - Act as **virtual firewalls** for EC2 instances.
  - **Stateful**: If traffic is allowed in, the response is automatically allowed out.
  - Rules are based on **allow-only** policies (no explicit deny).
- **Network ACLs (NACLs):**
  - Operate at the **subnet level**.
  - **Stateless**: Each request and response needs explicit allow/deny rules.
  - Can have **allow and deny** rules, unlike SGs.

## 4. Route Tables
- Direct traffic between subnets and external networks.
- Each subnet is associated with **one route table**.
- Common routes:
  - **Local route** (default for intra-VPC communication).
  - **Internet Gateway (IGW) route** for public access.
  - **NAT Gateway route** for private subnets needing internet access.
  - **VPC Peering or VPN route** for cross-VPC communication.

## 5. Network Address Translation (NAT)
- Used for private subnets that need outbound internet access but should remain unreachable from the internet.
- **NAT Gateway**:
  - Managed AWS service.
  - High availability in a single AZ (use multiple NAT Gateways for multi-AZ resilience).
- **NAT Instance**:
  - Self-managed EC2 instance.
  - Requires manual configuration and scaling.

## 6. Virtual Private Network (VPN)
- Connects an on-premises network to a cloud **VPC** securely.
- **Types of VPNs**:
  - **Site-to-Site VPN:** Connects an entire corporate network to the cloud.
  - **Client VPN:** Allows remote users to connect securely.
- AWS uses **Customer Gateway (CGW)** and **Virtual Private Gateway (VGW)** for VPN connections.
