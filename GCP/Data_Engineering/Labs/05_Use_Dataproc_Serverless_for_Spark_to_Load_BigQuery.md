Task 1. Complete environment configuration tasks
* First, you're going to perform a few environment configuration tasks to support the execution of a Dataproc Serverless workload.
* In the Cloud Shell, run the following command to enable Private IP Access:
```
gcloud compute networks subnets update default --region=us-west1 --enable-private-ip-google-access
```
* Use the following command to create a new Cloud Storage bucket as a staging location:
```
gsutil mb -p  qwiklabs-gcp-04-33309b7906a4 gs://qwiklabs-gcp-04-33309b7906a4
```
* Use the following command to create a new Cloud Storage bucket as temporary location for BigQuery while it creates and loads a table:
```
gsutil mb -p  qwiklabs-gcp-04-33309b7906a4 gs://qwiklabs-gcp-04-33309b7906a4-bqtemp
```
* Create a BQ dataset to store the data.
```
bq mk -d  loadavro
```
* Complete environment configuration tasks

Task 2. Download lab assets
* Next, you're going to download a few assets necessary to complete the lab into lab provided Compute Engine VM. You will perform the rest of the steps in the lab inside the Compute Engine VM.
* From the Navigation menu click on Compute Engine. Here you'll see a linux VM provisioned for you. Click the SSH button next to the lab-vm instance.
* GCE VM Instance Page
* At the VM terminal prompt, download the Avro file that will be processed for storage in BigQuery.
```
wget https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/campaigns.avro
```
* Next, move the Avro file to the staging Cloud Storage bucket you created earlier.
```
gcloud storage cp campaigns.avro gs://qwiklabs-gcp-04-33309b7906a4
```
* Download an archive containing the Spark code to be executed against the Serverless environment.
```
wget https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/dataproc-templates.zip
```
* Extract the archive.
```
unzip dataproc-templates.zip
```
* Change to the Python directory.
```
cd dataproc-templates/python
```

Task 3. Configure and execute the Spark code
* Next, you're going to set a few environment variables into VM instance terminal and execute a Spark template to load data into BigQuery.
* Set the following environment variables for the Dataproc Serverless environment.
```
export GCP_PROJECT=qwiklabs-gcp-04-33309b7906a4
export REGION=us-west1
export GCS_STAGING_LOCATION=gs://qwiklabs-gcp-04-33309b7906a4
export JARS=gs://cloud-training/dataengineering/lab_assets/idegc/spark-bigquery_2.12-20221021-2134.jar
```
* Run the following code to execute the Spark Cloud Storage to BigQuery template to load the Avro file in to BigQuery.
```
./bin/start.sh \
-- --template=GCSTOBIGQUERY \
    --gcs.bigquery.input.format="avro" \
    --gcs.bigquery.input.location="gs://qwiklabs-gcp-04-33309b7906a4" \
    --gcs.bigquery.input.inferschema="true" \
    --gcs.bigquery.output.dataset="loadavro" \
    --gcs.bigquery.output.table="campaigns" \
    --gcs.bigquery.output.mode=overwrite\
    --gcs.bigquery.temp.bucket.name="qwiklabs-gcp-04-33309b7906a4-bqtemp"
```
Note: You may safely ignore any warning stating: WARN FileStreamSink: Assume no metadata directory. Error while looking for metadata directory in the path... Because this is a small test, a metadata directory is not required.

Note: If you see an error message stating that the batch job has failed, please wait, then re-run the command until the job succeeds.
* Configure and execute the Spark code

Task 4. Confirm that the data was loaded into BigQuery
* Now that you have successfully executed the Spark template, it is time to examine the results in BigQuery.
* View the data in the new table in BigQuery.
```
bq query \
 --use_legacy_sql=false \
 'SELECT * FROM `loadavro.campaigns`;'
```

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
