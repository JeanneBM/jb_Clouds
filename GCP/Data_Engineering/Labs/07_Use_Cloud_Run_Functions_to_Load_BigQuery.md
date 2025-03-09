Task 1. Create a function
* First, you're going to create a simple function named loadBigQueryFromAvro. This function reads an Avro file that is uploaded to Cloud Storage and then creates and loads a table in BigQuery.
* To create a cloud function:
    - In the Cloud Console, on the Navigation menu (Navigation menu), click Compute Engine. You should see a provisioned linux instance:
    - VM instances tabbed page with a linux instance listed
    - Click on the SSH button. You will be brought to an interactive shell.
    - In the SSH terminal, run the following command to set the Cloud Run functions region:
```
gcloud config set functions/region REGION
```
* Create and open index.js to edit:
```
nano index.js
```
* Copy the following into the index.js file; this the code for the Cloud Function.
```
/**
* index.js Cloud Function - Avro on GCS to BQ
*/
const {Storage} = require('@google-cloud/storage');
const {BigQuery} = require('@google-cloud/bigquery');

const storage = new Storage();
const bigquery = new BigQuery();

exports.loadBigQueryFromAvro = async (event, context) => {
    try {
        // Check for valid event data and extract bucket name
        if (!event || !event.bucket) {
            throw new Error('Invalid event data. Missing bucket information.');
        }

        const bucketName = event.bucket;
        const fileName = event.name;

        // BigQuery configuration
        const datasetId = 'loadavro';
        const tableId = fileName.replace('.avro', ''); 

        const options = {
            sourceFormat: 'AVRO',
            autodetect: true, 
            createDisposition: 'CREATE_IF_NEEDED',
            writeDisposition: 'WRITE_TRUNCATE',     
        };

        // Load job configuration
        const loadJob = bigquery
            .dataset(datasetId)
            .table(tableId)
            .load(storage.bucket(bucketName).file(fileName), options);

        await loadJob;
        console.log(`Job ${loadJob.id} completed. Created table ${tableId}.`);

    } catch (error) {
        console.error('Error loading data into BigQuery:', error);
        throw error; 
    }
};
```
* Exit nano (Ctrl+x) and save (Y) the file.
* Create a function.

Task 2. Create a Cloud Storage bucket and BigQuery dataset
* Next, you're going to set up background infrastructure to store assets used to invoke the Cloud Run function (a Cloud Storage bucket) and store the output in BigQuery when it completes.
* Use the following command to create a new Cloud Storage bucket as a staging location:
```
gsutil mb -p  PROJECT_ID gs://PROJECT_ID
```
* Create a BQ dataset to store the data.
```
bq mk -d  loadavro
```
* Create a Cloud Storage bucket and BigQuery dataset.

Task 3. Deploy your function
* Next, you're going to deploy the new Cloud Run function and trigger it so that the data is loaded into BigQuery.
* In order to ensure all system settings are in place disable and re-enable the Cloud Run functions API. First you need to disable the Cloud Run functions API:
```
gcloud services disable cloudfunctions.googleapis.com
```
* Re-enable the Cloud Run functions API:
```
gcloud services enable cloudfunctions.googleapis.com
```
* For the Cloud Run function to process you must add the artifactregistry.reader permission to your appspot service account.
```
gcloud projects add-iam-policy-binding PROJECT_ID \
--member="serviceAccount:PROJECT_ID@appspot.gserviceaccount.com" \
--role="roles/artifactregistry.reader"
```
* Two javascript libraries must be installed to read from Cloud Storage and store the output in BigQuery.
```
npm install @google-cloud/storage @google-cloud/bigquery
```
Note: You may safely ignore any messages during the library installation that show entries like Unsupported Engine.
* Deploy the function using the command below.
```
gcloud functions deploy loadBigQueryFromAvro \
    --project PROJECT_ID \
    --runtime nodejs20 \
    --trigger-resource gs://PROJECT_ID \
    --trigger-event google.storage.object.finalize \
    --no-gen2
```
* In the termial output of the function deployment you will see status showing as Active. This indicates that the function has been successfully deployed.
```
### Subsection of Terminal Output ###
name: projects/qwiklabs-gcp-03-d57647f277c4/locations/us-west1/functions/loadBigQueryFromAvro
runtime: nodejs20
serviceAccountEmail: qwiklabs-gcp-03-d57647f277c4@appspot.gserviceaccount.com
sourceUploadUrl: https://storage.googleapis.com/uploads-997667274127.us-west1.cloudfunctions.appspot.com/0b46d543-5391-4094-a344-4357e246492b.zip
status: ACTIVE
timeout: 60s
updateTime: '2024-08-16T18:15:02.321Z'
versionId: '1'
```
* Next, download the Avro file that will be processed by the Cloud Run function for storage in BigQuery.
```
wget https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/campaigns.avro
```
* Move the Avro file to the staging Cloud Storage bucket you created earlier. This action will trigger the Cloud Run function.
```
gcloud storage cp campaigns.avro gs://PROJECT_ID
```
* Deploy a function.

Task 4. Confirm that the data was loaded into BigQuery
* Now that you have deployed and triggered the Cloud Run function, it is time to examine the results in BigQuery.
* To view the data in the new table in BigQuery, run the following query in the SSH terminal using the bq command.
```
bq query \
 --use_legacy_sql=false \
 'SELECT * FROM `loadavro.campaigns`;'
```
Note: The Cloud Run function will typically process very quickly but it is possible the query run against BigQuery may not return results. If that is the case for you please wait a moment and run the query again.

The query should return results similiar to the following:

Example output:
```
+------------+--------+---------------------+--------+---------------------+----------+-----+
| created_at | period |    campaign_name    | amount | advertising_channel | bid_type | id  |
+------------+--------+---------------------+--------+---------------------+----------+-----+
| 2020-09-17 |     90 | NA - Video - Other  |     41 | Video               | CPC      |  81 |
| 2021-01-19 |     30 | NA - Video - Promo  |    325 | Video               | CPC      | 137 |
| 2021-06-28 |     30 | NA - Video - Promo  |     78 | Video               | CPC      | 214 |
| 2021-03-15 |     30 | EU - Search - Brand |    465 | Search              | CPC      | 170 |
| 2022-01-01 |     30 | EU - Search - Brand |     83 | Search              | CPC      | 276 |
| 2020-02-18 |     30 | EU - Search - Brand |     30 | Search              | CPC      |  25 |
| 2021-06-08 |     30 | EU - Search - Brand |    172 | Search              | CPC      | 201 |
| 2020-11-29 |     60 | EU - Search - Other |     83 | Search              | CPC      | 115 |
| 2021-09-11 |     30 | EU - Search - Other |     86 | Search              | CPC      | 237 |
| 2022-02-17 |     30 | EU - Search - Other |     64 | Search              | CPC      | 296 |
+------------+--------+---------------------+--------+---------------------+----------+-----+
```
Task 5. View logs
* Any time that a Cloud Run function is executed detailed logs are maintained. As the final step in this lab you are going to examine the logs for your Cloud Run function.
* To check the logs and see your messages in the log history run the following command in the SSH terminal.
```
gcloud functions logs read loadBigQueryFromAvro
```
Messages in the log appear similar to the following:
```
LEVEL: D
NAME: loadBigQueryFromAvro
EXECUTION_ID: t0dtbms7lcvl
TIME_UTC: 2024-08-15 16:01:54.377
LOG: Function execution took 3143 ms, finished with status: 'ok'

LEVEL: 
NAME: loadBigQueryFromAvro
EXECUTION_ID: t0dtbms7lcvl
TIME_UTC: 2024-08-15 16:01:54.367
LOG: Job undefined completed. Created table campaigns.

LEVEL: D
NAME: loadBigQueryFromAvro
EXECUTION_ID: t0dtbms7lcvl
TIME_UTC: 2024-08-15 16:01:51.234
LOG: Function execution started
```
