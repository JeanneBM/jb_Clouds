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

