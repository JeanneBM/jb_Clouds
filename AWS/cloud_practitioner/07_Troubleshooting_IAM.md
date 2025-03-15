# Grant EC2 Instance Access to an S3 Bucket

---

## Solution

### Step 1: Upload an Object to the S3 Bucket
1. Log in to the **AWS Management Console** using the credentials provided.
2. Ensure you're in the **us-east-1** region.
3. Navigate to **S3**.
4. Find and select the S3 bucket.
5. Copy and store the full name of the S3 bucket.
6. Click **Upload**.
7. Select **Add Files**.
8. Choose a small text file named `test.txt`.
9. Finalize the upload by clicking **Upload**.
10. Copy and store the name of the uploaded file (`test.txt`).

---

### Step 2: Connect to the EC2 Instance and Attempt to Get the Object
1. Navigate to **EC2**.
2. Find and select **Instances (running)**.
3. Click on the **Instance ID**.
4. Click **Connect**.
5. Click **Connect** again to open the EC2 Instance Connect terminal.
6. Run the following command to attempt to retrieve the object:

   ```aws s3api get-object --bucket <INSERT BUCKET NAME> --key test.txt my-test.txt```
   
  - Replace <INSERT BUCKET NAME> with the name of your S3 bucket.
7. Observe the error message indicating insufficient permissions.

---

## Step 3: Edit the Instance’s IAM Policy to Allow Access to the S3 Bucket
1. Switch back to the **EC2** tab.
2. Find and select the **IAM Role** associated with the EC2 instance.
3. Under **Permissions Policies**, select **Add permissions** and choose **Attach Policies**.
4. In the search bar, search for `AmazonS3ReadOnlyAccess`.
5. Check the box next to **AmazonS3ReadOnlyAccess**.
6. Click **Add permissions**.

---

## Step 4: Connect to the EC2 Instance to Verify the New Permissions
1. Switch back to the **EC2 Instance Connect** tab.
2. Rerun the command to retrieve the object:
   
    ```aws s3api get-object --bucket <INSERT BUCKET NAME> --key test.txt my-test.txt```
   
- Replace <INSERT BUCKET NAME> with the name of your S3 bucket.
