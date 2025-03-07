```
Linux lab-vm 5.10.0-33-cloud-amd64 #1 SMP Debian 5.10.226-1 (2024-10-03) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
student-04-e240913b2dbe@lab-vm:~$ gcloud config set functions/region us-east4
Updated property [functions/region].
student-04-e240913b2dbe@lab-vm:~$ nano index.js
student-04-e240913b2dbe@lab-vm:~$ vim index.js 
student-04-e240913b2dbe@lab-vm:~$ gsutil mb -p  qwiklabs-gcp-04-13c525021d9c gs://qwiklabs-gcp-04-13c525021d9c
Creating gs://qwiklabs-gcp-04-13c525021d9c/...
student-04-e240913b2dbe@lab-vm:~$ bq mk -d  loadavro
Dataset 'qwiklabs-gcp-04-13c525021d9c:loadavro' successfully created.
student-04-e240913b2dbe@lab-vm:~$ gcloud services disable cloudfunctions.googleapis.com
Operation "operations/acat.p17-584936590013-1b350653-92bc-4cae-9371-14ab29ebbb29" finished successfully.
student-04-e240913b2dbe@lab-vm:~$ gcloud services enable cloudfunctions.googleapis.com
Operation "operations/acf.p2-584936590013-164a380f-a70f-41c0-b0d4-b71ad53c9127" finished successfully.
student-04-e240913b2dbe@lab-vm:~$ gcloud projects add-iam-policy-binding qwiklabs-gcp-04-13c525021d9c \
--member="serviceAccount:qwiklabs-gcp-04-13c525021d9c@appspot.gserviceaccount.com" \
--role="roles/artifactregistry.reader"
Updated IAM policy for project [qwiklabs-gcp-04-13c525021d9c].
bindings:
- members:
  - serviceAccount:qwiklabs-gcp-04-13c525021d9c@appspot.gserviceaccount.com
  role: roles/artifactregistry.reader
- members:
  - serviceAccount:qwiklabs-gcp-04-13c525021d9c@qwiklabs-gcp-04-13c525021d9c.iam.gserviceaccount.com
  role: roles/bigquery.admin
- members:
  - serviceAccount:584936590013@cloudbuild.gserviceaccount.com
  role: roles/cloudbuild.builds.builder
- members:
  - serviceAccount:service-584936590013@gcp-sa-cloudbuild.iam.gserviceaccount.com
  role: roles/cloudbuild.serviceAgent
- members:
  - serviceAccount:service-584936590013@gcf-admin-robot.iam.gserviceaccount.com
  role: roles/cloudfunctions.serviceAgent
- members:
  - serviceAccount:service-584936590013@compute-system.iam.gserviceaccount.com
  role: roles/compute.serviceAgent
- members:
  - serviceAccount:service-584936590013@container-engine-robot.iam.gserviceaccount.com
  role: roles/container.serviceAgent
- members:
  - serviceAccount:584936590013-compute@developer.gserviceaccount.com
  - serviceAccount:584936590013@cloudservices.gserviceaccount.com
  - serviceAccount:qwiklabs-gcp-04-13c525021d9c@appspot.gserviceaccount.com
  role: roles/editor
- members:
  - serviceAccount:admiral@qwiklabs-services-prod.iam.gserviceaccount.com
  - serviceAccount:qwiklabs-gcp-04-13c525021d9c@qwiklabs-gcp-04-13c525021d9c.iam.gserviceaccount.com
  - user:student-04-e240913b2dbe@qwiklabs.net
  role: roles/owner
- members:
  - serviceAccount:584936590013-compute@developer.gserviceaccount.com
  role: roles/resourcemanager.projectIamAdmin
- members:
  - serviceAccount:qwiklabs-gcp-04-13c525021d9c@qwiklabs-gcp-04-13c525021d9c.iam.gserviceaccount.com
  role: roles/storage.admin
- members:
  - user:student-04-e240913b2dbe@qwiklabs.net
  role: roles/viewer
etag: BwYvv4XGz4k=
version: 1
student-04-e240913b2dbe@lab-vm:~$ npm install @google-cloud/storage @google-cloud/bigquery
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: '@google-cloud/bigquery@7.9.2',
npm WARN EBADENGINE   required: { node: '>=14.0.0' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: '@google-cloud/storage@7.15.2',
npm WARN EBADENGINE   required: { node: '>=14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: '@google-cloud/common@5.0.2',
npm WARN EBADENGINE   required: { node: '>=14.0.0' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: '@google-cloud/paginator@5.0.2',
npm WARN EBADENGINE   required: { node: '>=14.0.0' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: '@google-cloud/precise-date@4.0.0',
npm WARN EBADENGINE   required: { node: '>=14.0.0' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: '@google-cloud/promisify@4.1.0',
npm WARN EBADENGINE   required: { node: '>=18' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: '@google-cloud/projectify@4.0.0',
npm WARN EBADENGINE   required: { node: '>=14.0.0' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'google-auth-library@9.15.1',
npm WARN EBADENGINE   required: { node: '>=14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'retry-request@7.0.2',
npm WARN EBADENGINE   required: { node: '>=14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'teeny-request@9.0.0',
npm WARN EBADENGINE   required: { node: '>=14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'gaxios@6.7.1',
npm WARN EBADENGINE   required: { node: '>=14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'https-proxy-agent@7.0.6',
npm WARN EBADENGINE   required: { node: '>= 14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'gcp-metadata@6.1.1',
npm WARN EBADENGINE   required: { node: '>=14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'gtoken@7.1.0',
npm WARN EBADENGINE   required: { node: '>=14.0.0' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'google-logging-utils@0.0.2',
npm WARN EBADENGINE   required: { node: '>=14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }
npm WARN EBADENGINE Unsupported engine {
npm WARN EBADENGINE   package: 'agent-base@7.1.3',
npm WARN EBADENGINE   required: { node: '>= 14' },
npm WARN EBADENGINE   current: { node: 'v12.22.12', npm: '7.5.2' }
npm WARN EBADENGINE }

added 88 packages, and audited 89 packages in 58s

15 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
student-04-e240913b2dbe@lab-vm:~$ gcloud functions deploy loadBigQueryFromAvro \
    --project qwiklabs-gcp-04-13c525021d9c \
    --runtime nodejs20 \
    --trigger-resource gs://qwiklabs-gcp-04-13c525021d9c \
    --trigger-event google.storage.object.finalize \
    --no-gen2
Created .gcloudignore file. See `gcloud topic gcloudignore` for details.
Deploying function (may take a while - up to 2 minutes)...⠧                                                    
For Cloud Build Logs, visit: https://console.cloud.google.com/cloud-build/builds;region=us-east4/6483e9c1-d6ed-44f4-8851-1fae3503fb48?project=584936590013
student-04-e240913b2dbe@lab-vm:~$ wget https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/campaigns.avro
--2025-03-07 12:15:32--  https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/campaigns.avro
Resolving storage.googleapis.com (storage.googleapis.com)... 192.178.155.207, 142.251.163.207, 142.251.167.207, ...
Connecting to storage.googleapis.com (storage.googleapis.com)|192.178.155.207|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1067 (1.0K) [application/octet-stream]
Saving to: ‘campaigns.avro’

campaigns.avro              100%[===========================================>]   1.04K  --.-KB/s    in 0s      

2025-03-07 12:15:32 (14.7 MB/s) - ‘campaigns.avro’ saved [1067/1067]

student-04-e240913b2dbe@lab-vm:~$ gcloud storage cp campaigns.avro gs://qwiklabs-gcp-04-13c525021d9c
Copying file://campaigns.avro to gs://qwiklabs-gcp-04-13c525021d9c/campaigns.avro
  Completed files 1/1 | 1.0kiB/1.0kiB                                                                          
student-04-e240913b2dbe@lab-vm:~$ bq query \
 --use_legacy_sql=false \
 'SELECT * FROM `loadavro.campaigns`;'

BigQuery error in query operation: Error processing job 'qwiklabs-
gcp-04-13c525021d9c:bqjob_r2ecacc45c0e4cacb_00000195708978bf_1': Not found: Table qwiklabs-
gcp-04-13c525021d9c:loadavro.campaigns was not found in location US
student-04-e240913b2dbe@lab-vm:~$ 
student-04-e240913b2dbe@lab-vm:~$ gcloud functions logs read loadBigQueryFromAvro
```
