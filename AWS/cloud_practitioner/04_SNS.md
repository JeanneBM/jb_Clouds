# Create and Subscribe to an AWS SNS Topic

### Step 1: Create an SNS Topic
1. In the search bar at the top of the AWS portal, type **SNS** and select **Simple Notification Service**.
2. Under **Create topic**, enter `EC2State` as the topic name.
3. Click **Next step**.
4. Under **Create topic > Details**, ensure the **Standard** type is selected.
5. Leave the other settings at default, scroll down, and click **Create topic**.

---

### Step 2: Subscribe to the SNS Topic
1. Under the **Subscriptions** tab, select **Create subscription**.
2. Leave the **Topic ARN** at default (the correct topic is automatically selected).
3. Under **Protocol**, select **Email** from the dropdown menu.
4. Under **Endpoint**, enter a valid email address.
5. Click **Create subscription**.
6. Under **Details**, note the **Pending confirmation** status.
7. Open a new browser tab and navigate to the inbox of the email address you entered.
8. Search for the **AWS Notifications** email and click the **Confirm subscription** link.
9. Return to the **Simple Notification Service** browser tab.
10. In the breadcrumb trail at the top, click on **EC2State**.
11. Under the **Subscriptions** tab, verify the **Status** is now **Confirmed**.

---

### Step 3: Test the SNS Topic
1. In the search bar at the top of the AWS portal, type **EC2** and select it.
2. Click on **Instances (running)**.
3. Select the checkbox next to the running instance.
4. Under the **Details** tab, copy the **Instance ID** by clicking the double overlapping box icon.
5. In the top-right corner, click the **Instance state** dropdown menu and select **Stop instance**.
6. In the **Stop instance?** pop-up menu, select **Stop**.
7. Exit out of the green **Successfully stopped** banner by clicking the **X** icon.

---

### Step 4: Create a CloudWatch Alarm
1. In the search bar at the top of the AWS portal, type **CloudWatch** and select it.
2. Under **Get started with CloudWatch**, click **Create alarms**.
3. Click the orange **Create alarm** button.
4. Click **Select metric**.
5. In the search bar under **Metrics**, paste the **Instance ID** you copied earlier and press **Enter**.
6. Click on **EC2 > Per-Instance Metrics**.
7. In the search bar next to **Per-Instance Metrics**, type `StatusCheck` and press **Enter**.
8. Under **Instance name**, select the checkbox next to **StatusCheckFailed_Instance**.
9. Click **Select metric**.
10. Under **Metric > Period**, select **1 minute** from the dropdown menu.
11. Under **Conditions**, select **Greater > than...** and enter `1` as the threshold value.
12. Click **Additional configuration** to expand the menu.
13. Under **Missing data treatment**, select **Treat missing data as bad (breaching threshold)**.
14. Click **Next**.
15. Under **Notification**, ensure **Alarm state trigger** is set to **In alarm**.
16. Under **Send a notification to...**, select **EC2State**.
17. Click **Add notification**.
18. Repeat the above steps for **Alarm state trigger** set to **OK** and **Insufficient data**, sending notifications to **EC2State** each time.
19. Under **Alarm name**, type `EC2State`.
20. Click **Next**.
21. Scroll down and click **Create alarm**.
22. Under **Alarms**, click on **EC2State**.
23. It may take a few minutes for the state to show **In alarm**. Click the refresh icon in the top-right corner until the status changes.

---

### Step 5: Verify Notification
- Navigate back to your inbox and confirm you received the AWS notification regarding the alarm state.
