# Launch an EC2 Instance in a Virtual Private Cloud (VPC)

### Step 1: Create a VPC
1. Navigate to **VPC > Your VPCs**.
2. Click **Create VPC** and set the following values:
   - **Select**: VPC Only
   - **Name tag**: `my-vpc`
   - **IPv4 CIDR block**: `10.0.0.0/16`
   - Leave **IPv6 CIDR block** and **Tenancy** as default.
3. Click **Create VPC**.

---

### Step 2: Create a Public Subnet
1. Click **Subnets** in the left-hand menu.
2. Click **Create subnet** and set the following values:
   - **VPC ID**: `my-vpc`
   - **Subnet name**: `my-public-subnet`
   - **Availability Zone**: `us-east-1a`
   - **IPv4 CIDR block**: `10.0.0.0/24`
3. Click **Create subnet**.

---

### Step 3: Create Routes and Configure Internet Gateway
1. With `my-public-subnet` selected, click **Actions > Edit subnet settings**.
2. Check the box to **Enable auto-assign public IPv4 address**.
3. Click **Save**.
4. Click **Internet Gateways** in the left-hand menu.
5. Click **Create internet gateway**.
   - Set **Name tag** as `my-internet-gateway`.
   - Click **Create internet gateway**.
6. On the next screen, click **Actions > Attach to VPC**.
   - In the **Available VPCs** dropdown, select `my-vpc`.
   - Click **Attach internet gateway**.
7. Click **Route Tables** in the left-hand menu.
8. Click **Create route table** and set the following values:
   - **Name**: `publicRT`
   - **VPC**: `my-vpc`
   - Click **Create route table**.
9. On the next screen, click **Edit routes**.
   - Click **Add route** and set the following values:
     - **Destination**: `0.0.0.0/0`
     - **Target**: Internet Gateway, `my-internet-gateway`
   - Click **Save changes**.
10. Click the **Subnet associations** tab.
    - Click **Edit subnet associations**.
    - Select the box for `my-public-subnet`.
    - Click **Save associations**.

---

### Step 4: Launch EC2 Instance in Subnet
1. Navigate to **EC2 > Instances**.
2. Click **Launch instances**.
3. Set **EC2 Instance name** as `my-public-instance`.
4. On the **AMI page**, select the **Amazon Linux AMI**.
5. Ensure **t2.micro** is selected.
6. Click **Create new key pair**.
   - Give it a **Key pair name** of `my-key-pair`.
   - Click **Create Key Pair**.
7. Click **Launch Instance**.
8. Click **View Instances** and wait for the instance to enter the **Running** state.

---

### Step 5: Access EC2 Instance
1. Once the instance is in the **Running** state, select the box next to it.
2. Click **Connect** at the top.
3. In the **EC2 Instance Connect** section, click **Connect**.
4. This will open a new browser tab with a command line interface to the instance.
