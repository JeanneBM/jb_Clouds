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
5. 
