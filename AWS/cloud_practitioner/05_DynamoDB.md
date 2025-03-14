
# Create a DynamoDB Table Using AWS CloudFormation

### Step 1: Review and Download the CloudFormation Template
1. Navigate to the provided CloudFormation template for this lab: `acg-dynamodb-template.yaml`.
2. Click **Raw**.
3. Right-click and select **Save As**.
4. Ensure the file format is **YAML** and click **Save**.
   - **Note**: You may need to add the `.yaml` extension to the filename.

---

### Step 2: Launch the CloudFormation Stack
1. In the AWS Management Console, search for and navigate to **CloudFormation**.
2. Click **Create stack > With new resources (standard)**.
3. Select **Choose an existing template**.
4. Select **Upload a template file**.
5. Click **Choose file** and select the YAML file you downloaded.
6. Click **Open**.
7. Click **Next**.
8. For **Stack name**, enter `MyStack`.
9. Click **Next**.
10. On the **Configure stack options** page, leave everything as-is and click **Next**.
11. On the **Review and create** page, click **Submit**.
12. Click the refresh icon in the upper-right section of the **Events** list to monitor the status of the stack creation.
   - **Note**: It may take a few minutes for the stack to be created. You can view the progress in the **Status** column of the **Events** list.

---

### Step 3: Verify the DynamoDB Table Was Created
1. Once the stack is created, search for and navigate to **DynamoDB** in the AWS Management Console.
2. From the left menu, click **Tables**.
3. Click the listed **Inventory** table. While there aren't currently any items within the table, it is ready for items to be added.
