```
student_00_721c6a4d1c71@cloudshell:~ (qwiklabs-gcp-03-2ce0b304e9a4)$ bq --location=us-central1 mk taxirides
Dataset 'qwiklabs-gcp-03-2ce0b304e9a4:taxirides' successfully created.
student_00_721c6a4d1c71@cloudshell:~ (qwiklabs-gcp-03-2ce0b304e9a4)$ bq --location=us-central1 mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime
Table 'qwiklabs-gcp-03-2ce0b304e9a4:taxirides.realtime' successfully created.
student_00_721c6a4d1c71@cloudshell:~ (qwiklabs-gcp-03-2ce0b304e9a4)$ 

Your Cloud Platform project in this session is set to qwiklabs-gcp-03-2ce0b304e9a4.
Use `gcloud config set project [PROJECT_ID]` to change to a different project.
student_00_721c6a4d1c71@cloudshell:~ (qwiklabs-gcp-03-2ce0b304e9a4)$ bq --location=us-central1 mk taxirides
Dataset 'qwiklabs-gcp-03-2ce0b304e9a4:taxirides' successfully created.
student_00_721c6a4d1c71@cloudshell:~ (qwiklabs-gcp-03-2ce0b304e9a4)$ bq --location=us-central1 mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime
Table 'qwiklabs-gcp-03-2ce0b304e9a4:taxirides.realtime' successfully created.
student_00_721c6a4d1c71@cloudshell:~ (qwiklabs-gcp-03-2ce0b304e9a4)$ gcloud storage cp gs://cloud-training/bdml/taxisrcdata/schema.json  gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/schema.json
gcloud storage cp gs://cloud-training/bdml/taxisrcdata/transform.js  gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/transform.js
gcloud storage cp gs://cloud-training/bdml/taxisrcdata/rt_taxidata.csv  gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/rt_taxidata.csv
Copying gs://cloud-training/bdml/taxisrcdata/schema.json to gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/schema.json
  Completed files 1/1 | 610.0B/610.0B                                                                                                                                                                                                           
Copying gs://cloud-training/bdml/taxisrcdata/transform.js to gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/transform.js
  Completed files 1/1 | 435.0B/435.0B                                                                                                                                                                                                           
Copying gs://cloud-training/bdml/taxisrcdata/rt_taxidata.csv to gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/rt_taxidata.csv
  Completed files 1/1 | 108.3kiB/108.3kiB                                                                                                                                                                                                       
student_00_721c6a4d1c71@cloudshell:~ (qwiklabs-gcp-03-2ce0b304e9a4)$ gcloud services disable dataflow.googleapis.com
gcloud services enable dataflow.googleapis.com
Operation "operations/acat.p17-821424145822-50a5cc30-0916-40bc-a167-e54ed95b8d5e" finished successfully.
Operation "operations/acf.p2-821424145822-6f95afec-d9d5-440f-b9cd-ed998515b166" finished successfully.
student_00_721c6a4d1c71@cloudshell:~ (qwiklabs-gcp-03-2ce0b304e9a4)$
```
