Task 1. Create a database for replication
```
gcloud services enable sqladmin.googleapis.com

POSTGRES_INSTANCE=postgres-db
DATASTREAM_IPS=104.199.6.64,34.78.213.130,35.205.33.30,35.205.125.111,35.187.27.174
gcloud sql instances create ${POSTGRES_INSTANCE} \
    --database-version=POSTGRES_14 \
    --cpu=2 --memory=10GB \
    --authorized-networks=${DATASTREAM_IPS} \
    --region=europe-west1 \
    --root-password pwd \
    --database-flags=cloudsql.logical_decoding=on

gcloud sql connect postgres-db --user=postgres
```
Output:
```
Welcome to Cloud Shell! Type "help" to get started.
Your Cloud Platform project in this session is set to qwiklabs-gcp-00-fd0eb55ab888.
Use `gcloud config set project [PROJECT_ID]` to change to a different project.
student_04_e07050128df4@cloudshell:~ (qwiklabs-gcp-00-fd0eb55ab888)$ gcloud services enable sqladmin.googleapis.com
student_04_e07050128df4@cloudshell:~ (qwiklabs-gcp-00-fd0eb55ab888)$ POSTGRES_INSTANCE=postgres-db
DATASTREAM_IPS=104.199.6.64,34.78.213.130,35.205.33.30,35.205.125.111,35.187.27.174
gcloud sql instances create ${POSTGRES_INSTANCE} \
    --database-version=POSTGRES_14 \
    --cpu=2 --memory=10GB \
    --authorized-networks=${DATASTREAM_IPS} \
    --region=europe-west1 \
    --root-password pwd \
    --database-flags=cloudsql.logical_decoding=on
Creating Cloud SQL instance for POSTGRES_14...done.                                                                                                                                                       
Created [https://sqladmin.googleapis.com/sql/v1beta4/projects/qwiklabs-gcp-00-fd0eb55ab888/instances/postgres-db].
NAME: postgres-db
DATABASE_VERSION: POSTGRES_14
LOCATION: europe-west1-d
TIER: db-custom-2-10240
PRIMARY_ADDRESS: 35.205.144.119
PRIVATE_ADDRESS: -
STATUS: RUNNABLE
student_04_e07050128df4@cloudshell:~ (qwiklabs-gcp-00-fd0eb55ab888)$ gcloud sql connect postgres-db --user=postgres
Allowlisting your IP for incoming connection for 5 minutes...working
```
```
CREATE SCHEMA IF NOT EXISTS test;

CREATE TABLE IF NOT EXISTS test.example_table (
id  SERIAL PRIMARY KEY,
text_col VARCHAR(50),
int_col INT,
date_col TIMESTAMP
);

ALTER TABLE test.example_table REPLICA IDENTITY DEFAULT; 

INSERT INTO test.example_table (text_col, int_col, date_col) VALUES
('hello', 0, '2020-01-01 00:00:00'),
('goodbye', 1, NULL),
('name', -987, NOW()),
('other', 2786, '2021-01-01 00:00:00');
```

```
CREATE PUBLICATION test_publication FOR ALL TABLES;
ALTER USER POSTGRES WITH REPLICATION;
SELECT PG_CREATE_LOGICAL_REPLICATION_SLOT('test_replication', 'pgoutput');
```

Task 2. Create the Datastream resources and start replication

Now that the database is ready, create the Datastream connection profiles and stream to begin replication.

* From the Navigation menu, click on View All Products under Analytics select Datastream
* Click Enable to enable the Datastream API.
* Create connection profiles

Create two connection profiles, one for the PostgreSQL source, and another for the BigQuery destination.

PostgreSQL connection profile
* In the Cloud console, navigate to the Connection Profiles tab and click Create Profile.
* Select the PostgreSQL connection profile type.
* Use postgres-cp as the name and ID of the connection profile.
* Enter the database connection details:
    - Region: europe-west1
    - To find the IP address of your Cloud SQL instance:
    - From the Navigation menu, click on SQL.
    - On the SQL page, locate your PostgreSQL instance (typically named postgres-db).
    - Copy the public IP address of the instance.
    - Username: postgres
    - Password: pwd
    - Database: postgres
* Click Continue.
* Leave the encryption as NONE, and click CONTINUE.
* Select the IP allowlisting connectivity method, and click Continue.
* Click RUN TEST to make sure that Datastream can reach the database.
* Click Create.

BigQuery connection profile
* In the Cloud console, navigate to the Connection Profiles tab and click Create Profile.
* Select the BigQuery connection profile type.
* Use bigquery-cp as the name and ID of the connection profile.
    - Region europe-west1
* Click Create.

Create stream

Create the stream which connects the connection profiles created above and defines the configuration for the data to stream from source to destination.

* In the Cloud console, navigate to the Streams tab and click Create Stream.
* Use test-stream as the name and ID of the stream.
* Region europe-west1
* Select PostgreSQL as the source type
* Select BigQuery as destination type
* Click CONTINUE.

step 1 of create stream details page filled in
Define the source

* Select the postgres-cp connection profile created in the previous step.
* [Optional] Test connectivity by clicking RUN TEST
* Click CONTINUE.

Configure the source
* Specify the replication slot name as test_replication.
* Specify the publication name as test_publication.
* Select the test schema for replication.
* Click Continue.
* Define the destination
* Select the bigquery-cp connection profile created in the previous step, then click Continue.
* step 4 of the create stream page with bigquery-cp selected

Configure the destination
* Choose Region and select europe-west1 as the BigQuery dataset location.
* Set the staleness limit to 0 seconds.
* Click Continue.
Review and create the stream
Finally, validate the stream details by clicking RUN VALIDATION. Once validation completes successfully, click CREATE AND START.

    - validation results with green check marks
    - Wait approximately 1-2 minutes until the stream status is shown as running.

Task 3. View the data in BigQuery
Now that the stream is running, see the data replicating into the BigQuery dataset.

In the Google Cloud console, from the Navigation menu go to BigQuery.
In the BigQuery Studio explorer, expand the project node to see the list of datasets.
Expand the test dataset node.
Click on the example_table table.
Click on the PREVIEW tab to see the data in BigQuery.
Note: The data might take few minutes to appear in Preview section.
BigQuery Explorer page with the example_table visible
If you see the message "There is no data to display" on the preview tab, you can verify the data using the following command.

```
SELECT * FROM test.example_table ORDER BY id;
```
Task 4. Check that changes in the source are replicated to BigQuery

```
gcloud sql connect postgres-db --user=postgres


INSERT INTO test.example_table (text_col, int_col, date_col) VALUES
('abc', 0, '2022-10-01 00:00:00'),
('def', 1, NULL),
('ghi', -987, NOW());

UPDATE test.example_table SET int_col=int_col*2; 

DELETE FROM test.example_table WHERE text_col = 'abc';

SELECT * FROM test.example_table ORDER BY id;
```
