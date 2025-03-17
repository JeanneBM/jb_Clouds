Google Cloud Console and Cloud Shell Notes
Task 1: Explore the Google Cloud Console
1. Verify Project Selection
In the Google Cloud console title bar, click the Select a project drop-down.

Choose the project ID provided by Qwiklabs (e.g., qwiklabs-gcp-<hexadecimal>).

Ensure the title bar displays the correct project ID.

2. Create a Cloud Storage Bucket
Navigate to Cloud Storage > Buckets.

Click Create Bucket.

Use the project ID as the bucket name (globally unique).

Set Location Type to Region and choose europe-west1.

Set access control to Fine-grained.

Click Create.

3. Create a Virtual Machine (VM) Instance
Navigate to Compute Engine > VM instances.

Click Create instance.

Name the VM first-vm.

Set Region to europe-west1 and Zone to europe-west1-c.

Choose Machine type (e.g., e2-micro for cost efficiency).

Under Networking, allow HTTP traffic.

Click Create.

4. Explore VM Details
Click on the VM name (first-vm) to view details.

Note the CPU platform and other configurations.

Edit the VM to explore options like Availability policies (e.g., Spot VMs).

5. Create an IAM Service Account
Navigate to IAM & admin > Service accounts.

Click Create service account.

Name it test-service-account.

Assign the Editor role.

Create and download a JSON key file for authentication.

Task 2: Explore Cloud Shell
1. Open Cloud Shell
Click the Activate Cloud Shell icon in the console title bar.

Explore Cloud Shell features:

Hide/Restore: Minimize or restore the Cloud Shell window.

Open in new window: Expand Cloud Shell to a full terminal.

Close all tabs: Terminate the Cloud Shell session.

2. Set Environment Variables
Define variables for bucket names and region:



MY_BUCKET_NAME_1=[BUCKET_NAME]
MY_BUCKET_NAME_2=[BUCKET_NAME_2]
MY_REGION=europe-west1
3. Upload Credentials File
Rename the downloaded JSON key file to credentials.json.

Upload it to Cloud Shell using the Upload option in the toolbar.

4. Create a Second Cloud Storage Bucket
Use the gcloud command to create a bucket:



gcloud storage buckets create gs://$MY_BUCKET_NAME_2 --location=europe-west1
5. Create a Second VM
List zones in the region:



gcloud compute zones list | grep $MY_REGION
Set a default zone:



gcloud config set compute/zone $MY_ZONE
Create the VM:



gcloud compute instances create second-vm --machine-type "e2-standard-2" --image-project "debian-cloud" --image-family "debian-11" --subnet "default"
6. Create a Second Service Account
Create a service account:



gcloud iam service-accounts create test-service-account2 --display-name "test-service-account2"
Grant the Viewer role:



gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account2@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/viewer
Task 3: Work with Cloud Storage in Cloud Shell
1. Download and  Files
 a file from a public bucket to Cloud Shell:



gcloud storage cp gs://cloud-training/ak8s/cat.jpg cat.jpg
Upload the file to your buckets:



gcloud storage cp cat.jpg gs://$MY_BUCKET_NAME_1
gcloud storage cp gs://$MY_BUCKET_NAME_1/cat.jpg gs://$MY_BUCKET_NAME_2/cat.jpg
2. Set Access Control List (ACL)
Check the ACL for cat.jpg:



gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg > acl.txt
cat acl.txt
Set the file to private:



gsutil acl set private gs://$MY_BUCKET_NAME_1/cat.jpg
3. Authenticate as a Service Account
Activate the service account:



gcloud auth activate-service-account --key-file credentials.json
Verify the active account:



gcloud config list
4. Make Bucket Public
Allow public access to the bucket:



gsutil iam ch allUsers:objectViewer gs://$MY_BUCKET_NAME_1
Task 4: Explore the Cloud Shell Editor
1. Open Cloud Shell Editor
Click the Open Editor icon in Cloud Shell.

Clone a Git repository:



git clone https://github.com/googlecodelabs/orchestrate-with-kubernetes.git
2. Create and Edit Files
Create a test directory:



mkdir test
Edit the cleanup.sh file and add:



echo Finished cleanup!
3. Deploy a Web Server
Install nginx on the VM:



sudo apt-get update
sudo apt-get install nginx
 an HTML file to the VM:



gcloud compute scp index.html first-vm:index.nginx-debian.html --zone=europe-west1-c
Move the file to the web server root:



sudo cp index.nginx-debian.html /var/www/html
4. Verify Web Server
Access the VM's external IP in a browser to view the webpage.

Save this content in a .md file for future reference.

Replace the string REPLACE_WITH_CAT_URL with the URL of the cat image from an earlier task. The URL will look like this:
https://storage.googleapis.com/qwiklabs-Google Cloud-1aeffbc5d0acb416/cat.jpg where will be that image in which bucket?
The image cat.jpg will be in the first bucket you created in Task 1, which is named after your Google Cloud project ID (e.g., qwiklabs-gcp-<hexadecimal>).

Steps to Find the URL:
Locate the Bucket:

Go to the Google Cloud Console.

Navigate to Cloud Storage > Buckets.

Look for the bucket named after your project ID (e.g., qwiklabs-gcp-<hexadecimal>).

Find the Image:

Click on the bucket name to open it.

Inside the bucket, you should see the file cat.jpg.

Get the URL:

Click on the cat.jpg file to open its details.

 the Public URL (if the bucket is public) or the gsutil URI (e.g., gs://<BUCKET_NAME>/cat.jpg).

Example URL:
If your bucket name is qwiklabs-gcp-1aeffbc5d0acb416, the URL for the image will look like this:


https://storage.googleapis.com/qwiklabs-gcp-1aeffbc5d0acb416/cat.jpg
Notes:
If the bucket is not public, you will need to make it public (as described in Task 3) to access the image via a URL.

If the bucket is private, you can still access the image programmatically using the gsutil URI or by authenticating with the appropriate credentials.

Let me know if you need further clarification!

after this gcloud compute scp index.html first-vm:index.nginx-debian.html --zone=us-east4-c where is the file copied in vm
When you run the command:



gcloud compute scp index.html first-vm:index.nginx-debian.html --zone=us-east4-c
The file index.html is copied from your local machine (or Cloud Shell) to the home directory of the user you are logged in as on the first-vm virtual machine.

Location of the File in the VM:
The file will be located at:


/home/<username>/index.nginx-debian.html
Replace <username> with the username you are using to SSH into the VM (e.g., the default username for most VMs is your Google account username or the username provided by Qwiklabs).

Steps to Verify:
SSH into the VM:

In the Google Cloud Console, go to Compute Engine > VM instances.

Click the SSH button next to first-vm.

Check the Home Directory:

Once logged into the VM, run the following command to list files in the home directory:



ls ~/
You should see the file index.nginx-debian.html listed.

Move the File to the Web Server Directory:

To make the file accessible via the web server, move it to the default document root of the nginx web server:



sudo cp ~/index.nginx-debian.html /var/www/html/
This will  the file to /var/www/html/, where nginx serves files from by default.

Example:
If the file is successfully copied, you can verify its contents by running:



cat ~/index.nginx-debian.html
If you moved it to the web server directory, you can access it via the VM's external IP in a browser:


http://<VM_EXTERNAL_IP>/index.nginx-debian.html

