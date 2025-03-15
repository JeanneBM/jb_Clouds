# Create a CloudWatch Dashboard for EC2 CPU Utilization
---

### Step 1: Inspect EC2 Instances and Tags
1. Navigate to **EC2** in the AWS console.
2. Select an instance and navigate to the **Tags** menu.
3. Review the existing **Environment** tag (e.g., `Prod` or `Dev`).

---

### Step 2: Create a CloudWatch Dashboard
1. Navigate to **CloudWatch**.
2. From the side panel, select **Dashboards**.
3. Click the **Create dashboard** button.
4. Enter `my-ec2-dashboard` as the **Dashboard name**.
5. Click **Create dashboard**.

---

### Step 3: Add EC2 CPU Utilization Widget for Production Environment
1. Exit out of the **Add widget** pop-up if it appears.
2. Expand the side panel menu and under **Metrics**, select **Explorer**.
3. Fill in the following fields:
   - **Metric**: `EC2 Instance: CPUUtilization`
   - **From**: `Environment = Prod`
   - **Aggregate by**: `Average`
   - **Columns**: `1`
   - **Rows**: `1`
4. Click the context menu (3 vertical dots) at the top of the **All resources - CPUUtilization** widget.
5. Select **View in metrics**.
6. Click the **Pencil Icon** next to the title **All resources - CPUUtilization**.
7. Enter `Prod EC2 - CPUUtilization` in the **Rename Graph** field.
8. Click **Apply**.
9. From the **Actions** dropdown, select **Add to dashboard**.
10. Select `my-ec2-dashboard` under **Select a dashboard**.
11. Click **Add to dashboard**.
12. At the top right of the screen, click **Save**.

---

### Step 4: Add EC2 CPU Utilization Widget for Development Environment
1. Navigate back to **Explorer** under the **Metrics** side menu.
2. Fill in the following fields:
   - **Metric**: `EC2 Instance: CPUUtilization`
   - **From**: `Environment = Dev`
   - **Aggregate by**: `Average`
   - **Columns**: `1`
   - **Rows**: `1`
3. Click the context menu (3 vertical dots) at the top of the **All resources - CPUUtilization** widget.
4. Select **View in metrics**.
5. Click the **Pencil Icon** next to the title **All resources - CPUUtilization**.
6. Enter `Dev EC2 - CPUUtilization` in the **Rename Graph** field.
7. Click **Apply**.
8. From the **Actions** dropdown, select **Add to dashboard**.
9. Select `my-ec2-dashboard` under **Select a dashboard**.
10. Click **Add to dashboard**.
11. At the top right of the screen, click **Save**.

