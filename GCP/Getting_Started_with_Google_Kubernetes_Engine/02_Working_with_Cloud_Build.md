# Task 1: Confirm Needed APIs Are Enabled

1. Note your Google Cloud project name (e.g., `qwiklabs-gcp-...`).
2. Navigate to **APIs & Services > Library**.
3. Search for and enable the following APIs:
   - **Cloud Build API**
   - **Artifact Registry API**

# Task 2: Build Containers with Dockerfile and Cloud Build

1. Activate Cloud Shell and create a `quickstart.sh` file:
```
nano quickstart.sh
```
2. Add the following content:
```
#!/bin/sh
echo "Hello, world! The time is $(date)."
```
3. Save and exit (CTRL+X, Y, ENTER).
4. Create a Dockerfile:
```
nano Dockerfile
```
5. Add the following content:

```
FROM alpine
COPY quickstart.sh /
CMD ["/quickstart.sh"]
```



# Task 1: Confirm Needed APIs Are Enabled

1. Note your Google Cloud project name (e.g., `qwiklabs-gcp-...`).
2. Navigate to **APIs & Services > Library**.
3. Search for and enable the following APIs:
   - **Cloud Build API**
   - **Artifact Registry API**

---

# Task 2: Build Containers with Dockerfile and Cloud Build

1. Activate Cloud Shell and create a `quickstart.sh` file:
   ```bash
   nano quickstart.sh
Add the following content:

bash
Copy
#!/bin/sh
echo "Hello, world! The time is $(date)."
Save and exit (CTRL+X, Y, ENTER).

Create a Dockerfile:

bash
Copy
nano Dockerfile
Add the following content:

dockerfile
Copy
FROM alpine
COPY quickstart.sh /
CMD ["/quickstart.sh"]
Save and exit.

Make quickstart.sh executable:

bash
Copy
chmod +x quickstart.sh
Create a Docker repository:

bash
Copy
gcloud artifacts repositories create quickstart-docker-repo \
    --repository-format=docker \
    --location="REGION" \
    --description="Docker repository"
Build and push the Docker image:

bash
Copy
gcloud builds submit --tag "REGION"-
