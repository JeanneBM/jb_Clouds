# Create and Configure a Linux VM on Microsoft Azure

This guide provides step-by-step instructions to create and configure a Linux virtual machine (VM) on Microsoft Azure.

## Prerequisites
- An [Azure account](https://portal.azure.com).
- SSH key (recommended for secure access).

---

## Steps

### 1. Log in to the Azure Portal
Go to the [Azure Portal](https://portal.azure.com) and sign in with your Microsoft account.

### 2. Create a Virtual Machine
1. In the left-hand menu, select **Virtual machines** and click **+ Create > Azure Virtual Machine**.
2. Configure **Basic settings**:
   - **Subscription**: Choose your Azure subscription.
   - **Resource group**: Create a new resource group or use an existing one.
   - **Virtual machine name**: Choose a unique name for your VM.
   - **Region**: Select a region close to your location or target users.
   - **Image**: Choose a Linux distribution (e.g., **Ubuntu Server**, **CentOS**, or **Debian**).
   - **Size**: Select a VM size (e.g., `Standard_B1s` for basic workloads).
   - **Authentication type**: Choose **SSH public key** or **Password**.
   - **Username and SSH key**: Set a username and upload your SSH key (if using SSH), or set a password.

3. Click **Next: Disks**.

### 3. Configure Disks
1. **OS Disk type**: Choose the disk type (e.g., **Standard SSD**, **Premium SSD**).
2. (Optional) Add a data disk if additional storage is needed.
3. Click **Next: Networking**.

### 4. Configure Networking
1. **Virtual network**: Select an existing virtual network or create a new one.
2. **Subnet**: Choose a subnet or create one if none exists.
3. **Public IP**: Ensure a public IP address is assigned for remote access.
4. **NIC network security group (NSG)**: Configure firewall rules:
   - Add an inbound rule for **SSH (port 22)** to allow remote access.

5. Click **Next: Management**.

### 5. Configure Management Settings
1. Enable or disable monitoring options as needed (e.g., **Boot diagnostics**, **Guest OS diagnostics**).
2. Configure **Auto-shutdown** if you want to automatically turn off the VM at a specific time.
3. Click **Next: Advanced**.

### 6. Advanced Settings (Optional)
1. (Optional) Configure additional settings such as **custom data** or **cloud init** scripts.
2. Click **Next: Tags**.

### 7. Add Tags (Optional)
1. Add tags (key-value pairs) to organize and categorize your VM.
2. Click **Review + Create**.

### 8. Review and Create
1. Review your settings to ensure they are correct.
2. Click **Create** to start the deployment.
3. Once the deployment completes, your VM will be running.

---

## Access Your Linux VM

1. In the **Azure Portal**, go to **Virtual machines** and select your VM.
2. Copy the **public IP address** of the VM.
3. Connect via SSH from your local terminal:
   ```bash
   ssh username@public-ip-address


# Configure Monitoring and Backup for Linux VMs in Azure

This guide provides steps to set up monitoring and backup for Linux VMs in Azure using **Azure Monitor**, **Log Analytics**, and **Azure Backup**.

---

## 1. Configure Monitoring with Azure Monitor

Azure Monitor provides insights into the performance, health, and availability of Linux VMs.

### Step 1: Enable Azure Monitor
1. Go to the **Azure Portal**.
2. Navigate to **Virtual Machines** and select your Linux VM.
3. Under the **Monitoring** section, choose **Insights**.
4. Click **Enable** to start collecting data.

### Step 2: Configure Metrics and Alerts
1. After enabling Azure Monitor, configure metrics like CPU usage, memory, disk I/O, and network activity.
2. In the **Monitoring** section, go to **Alerts** to create alerts based on these metrics.
3. Define thresholds for alerts (e.g., CPU usage over 80%) to be notified of performance issues.

### Step 3: Configure Log Analytics (Optional for Advanced Monitoring)
1. Connect the VM to **Azure Log Analytics** for more detailed insights.
2. Create a **Log Analytics workspace** in Azure if you don’t already have one.
3. From the **Virtual Machines** section, go to **Logs** and select your workspace.
4. Install the **Azure Monitor Agent** on the VM to start collecting logs and performance counters.

---

## 2. Set Up Backup with Azure Backup

Azure Backup enables automatic backup and point-in-time recovery for Linux VMs.

### Step 1: Create a Recovery Services Vault
1. In the **Azure Portal**, search for and select **Recovery Services vaults**.
2. Click **+ Create** and provide the required details (name, subscription, resource group, region).
3. Once created, open the vault and select **Backup**.

### Step 2: Configure Backup Policy
1. In the **Backup Goal** section, select **Azure** and then choose **Virtual machine**.
2. Select your VM and click **Enable Backup**.
3. Configure the **Backup Policy**:
   - Set the backup frequency (daily, weekly, or monthly).
   - Define the retention period as per your needs.

### Step 3: Initiate Backup
1. After configuring the policy, initiate a backup to test it.
2. In the Recovery Services Vault, go to **Backup Items** > **Azure Virtual Machine**, and verify your VM is listed.

### Step 4: Restore Data if Needed
1. In the Recovery Services Vault, go to **Backup Items** > **Azure Virtual Machine**.
2. Select your VM and click **Restore VM** to either restore it to an existing VM or create a new VM from the backup.

---

## Additional Tips and Best Practices

- **Testing**: Regularly test backup recovery to ensure data integrity.
- **Automation**: Use **Azure Policy** to enforce backup and monitoring configurations across multiple VMs.
- **Cost Management**: Monitor costs for backup storage and Log Analytics to avoid unexpected expenses.

---

# Scaling Linux VMs Vertically in Azure

This guide explains how to scale Linux VMs vertically in Azure, meaning you’ll increase the resources (CPU, memory, or storage) of an individual virtual machine rather than adding more instances.

## Steps to Scale a Linux VM Vertically

### 1. Check VM Size Compatibility
- Review the available VM sizes to ensure the target size meets your requirements for CPU, memory, and storage.
- Azure VM sizes are grouped into series based on workload types (e.g., General Purpose, Compute-optimized, Memory-optimized, etc.).

### 2. Stop the Virtual Machine
- **Important:** You may need to **stop** (deallocate) the VM to resize it, especially if changing to a size that’s not compatible with the current hardware cluster.
- In the **Azure portal**:
  - Go to **Virtual Machines**.
  - Select your VM.
  - Click **Stop** to deallocate it.

### 3. Resize the Virtual Machine
- In the **Azure portal**:
  1. Navigate to your VM.
  2. Under **Settings**, select **Size**.
  3. Choose a new size from the list of available configurations.
  4. Click **Resize** to apply the changes.
- **Note:** Some VM sizes may not be available in all regions. Check region-specific restrictions if you can’t find your desired size.

### 4. Restart the Virtual Machine
- Once resized, go back to the **Overview** tab and click **Start** to bring the VM back online.

### 5. Verify the New Configuration
- After the VM is running, verify the updated configuration in the **Overview** tab. You should see the new specs for CPU, memory, and storage.

## Important Considerations

- **Downtime**: Vertical scaling requires stopping and restarting the VM, which may result in brief downtime.
- **Costs**: Pricing will adjust according to the new VM size, so be sure the configuration aligns with your budget.

## Additional Options

- **Automate with Azure CLI**: You can also scale VMs via the Azure CLI using the `az vm resize` command, which is useful for scripting or batch resizing.
- **Resource Quotas**: Azure imposes regional quota limits on resources (e.g., CPU cores). If scaling up significantly, you may need to request a quota increase.

---

# Configuring Identities and Roles for Linux VMs in Azure

This guide provides steps for configuring identities and roles for Linux VMs in Azure, which is essential for managing access, enhancing security, and enabling automation.

---

## 1. Managed Identities for Linux VMs

Azure offers **Managed Identities** that allow resources to securely access Azure services without managing credentials. There are two types:

- **System-assigned Managed Identity**: Tied to the lifecycle of the VM and deleted when the VM is deleted.
- **User-assigned Managed Identity**: Independent of the VM lifecycle, enabling reuse across multiple VMs.

### Steps to Configure Managed Identity

1. **Enable System-assigned Managed Identity**
   - Go to your VM in the **Azure portal**.
   - Under **Settings**, select **Identity**.
   - Toggle **Status** to **On** for the **System-assigned managed identity**.
   - Save the changes.

2. **Enable User-assigned Managed Identity**
   - Create a User-assigned Managed Identity in **Azure Active Directory** > **Managed Identities**.
   - Assign this identity to the VM under **Identity** settings.

### Use Cases

- Access Azure Key Vault to manage secrets, keys, and certificates.
- Interact with other Azure resources like Blob storage and SQL databases.

---

## 2. Assigning Azure Role-Based Access Control (RBAC)

Azure **RBAC** allows you to manage who has access to Azure resources, what they can do, and which resources they can access.

### Steps to Configure Azure RBAC for a VM

1. In the **Azure portal**, navigate to the VM.
2. Select **Access Control (IAM)** in the left menu.
3. Choose **Add role assignment** and select a role (e.g., Virtual Machine Contributor).
4. Assign the role to a specific **user**, **group**, or **managed identity**.

### Common Roles

- **Virtual Machine Contributor**: Full access to manage the VM except for permission to grant access to others.
- **Reader**: Can view the VM configuration but cannot make changes.
- **Virtual Machine Administrator Login**: Allows log-in as an administrator.
- **Virtual Machine User Login**: Allows standard user-level access to the VM.

---

## 3. Configuring SSH Key-based Authentication

For secure access to Linux VMs, use **SSH key-based authentication** instead of passwords.

### Steps to Configure SSH Access

- Generate an SSH key pair locally (if not done already):
  ```bash
  ssh-keygen -t rsa -b 2048

# Accessing Azure Storage from a Linux VM

This guide explains how to access Azure Storage from a Linux Virtual Machine (VM). You can use several methods, such as Azure CLI, AzCopy, Blobfuse, and SMB, to interact with different types of Azure Storage services, such as Blob Storage and File Storage.

## Prerequisites
- A running Azure Linux VM.
- Azure Storage Account and appropriate access credentials (account name, key, or SAS token).

## Accessing Azure Blob Storage

### 1. Using Azure CLI

#### Install Azure CLI on Linux VM
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

