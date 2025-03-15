# Transition S3 Objects to Cheaper Storage Classes Using Lifecycle Rules

### Step 1: Upload an Object to the S3 Bucket
1. Log in to the **AWS Management Console** using the credentials provided.
2. Ensure you're in the **us-east-1** region.
3. Navigate to **S3**.
4. Find and select the S3 bucket.
5. Click **Upload**.
6. Select **Add Files**.
7. Choose a small text file named `test.txt`.
8. Finalize the upload by clicking **Upload**.

---

### Step 2: Create an S3 Lifecycle Rule
1. Click on the S3 bucket name to navigate back to the bucket.
2. Go to the **Management** tab.
3. Click **Create Lifecycle Rule**.
4. Adjust the following fields:
   - **Lifecycle rule name**: `my-lifecycle-rule`
   - Select **Apply to all objects in the bucket**.
   - Check the box: **I acknowledge that this rule will apply to all objects in the bucket**.
   - Check the box: **Move current versions of objects between storage classes**.
   - Check the box: **Expire current versions of objects**.
5. Under **Choose storage class transitions**:
   - Select **Standard-IA**.
   - Enter `30` for **Days after object creation**.
6. Under **Expire current versions of objects**:
   - Enter `365` for **Days after object creation**.
7. Click **Create rule**.

---

### Step 3: Verify Your Lifecycle Policy
1. Click the S3 bucket name at the top of the screen to navigate back to the bucket.
2. Under **Objects**, select `test.txt`.
3. In the **Object management overview**, verify that the `my-lifecycle-rule` is shown under **Expiration rule**.
