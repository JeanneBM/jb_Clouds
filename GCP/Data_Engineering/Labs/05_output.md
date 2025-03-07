```
Welcome to Cloud Shell! Type "help" to get started.
Your Cloud Platform project in this session is set to qwiklabs-gcp-04-33309b7906a4.
Use `gcloud config set project [PROJECT_ID]` to change to a different project.
student_04_e240913b2dbe@cloudshell:~ (qwiklabs-gcp-04-33309b7906a4)$ gcloud compute networks subnets update default --region=us-west1 --enable-private-ip-google-access
Updated [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-04-33309b7906a4/regions/us-west1/subnetworks/default].
student_04_e240913b2dbe@cloudshell:~ (qwiklabs-gcp-04-33309b7906a4)$ gsutil mb -p  qwiklabs-gcp-04-33309b7906a4 gs://qwiklabs-gcp-04-33309b7906a4
Creating gs://qwiklabs-gcp-04-33309b7906a4/...
student_04_e240913b2dbe@cloudshell:~ (qwiklabs-gcp-04-33309b7906a4)$ gsutil mb -p  qwiklabs-gcp-04-33309b7906a4 gs://qwiklabs-gcp-04-33309b7906a4-bqtemp
Creating gs://qwiklabs-gcp-04-33309b7906a4-bqtemp/...
student_04_e240913b2dbe@cloudshell:~ (qwiklabs-gcp-04-33309b7906a4)$ bq mk -d  loadavro
Dataset 'qwiklabs-gcp-04-33309b7906a4:loadavro' successfully created.
student_04_e240913b2dbe@cloudshell:~ (qwiklabs-gcp-04-33309b7906a4)$ 
```

Task 2 SSH
```
student-04-e240913b2dbe@lab-vm:~$ wget https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/campaigns.avro
--2025-03-07 14:15:06--  https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/campaigns.avro
Resolving storage.googleapis.com (storage.googleapis.com)... 108.177.98.207, 74.125.197.207, 74.125.135.207, ...
Connecting to storage.googleapis.com (storage.googleapis.com)|108.177.98.207|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1067 (1.0K) [application/octet-stream]
Saving to: ‘campaigns.avro’

campaigns.avro              100%[===========================================>]   1.04K  --.-KB/s    in 0s      

2025-03-07 14:15:06 (8.38 MB/s) - ‘campaigns.avro’ saved [1067/1067]

student-04-e240913b2dbe@lab-vm:~$ gcloud storage cp campaigns.avro gs://qwiklabs-gcp-04-33309b7906a4
Copying file://campaigns.avro to gs://qwiklabs-gcp-04-33309b7906a4/campaigns.avro
  Completed files 1/1 | 1.0kiB/1.0kiB                                                                          
student-04-e240913b2dbe@lab-vm:~$ wget https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/dataproc-templates.zip
--2025-03-07 14:15:23--  https://storage.googleapis.com/cloud-training/dataengineering/lab_assets/idegc/dataproc-templates.zip
Resolving storage.googleapis.com (storage.googleapis.com)... 108.177.98.207, 74.125.197.207, 74.125.135.207, ...
Connecting to storage.googleapis.com (storage.googleapis.com)|108.177.98.207|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22294152 (21M) [application/zip]
Saving to: ‘dataproc-templates.zip’

dataproc-templates.zip      100%[===========================================>]  21.26M  --.-KB/s    in 0.1s    

2025-03-07 14:15:23 (200 MB/s) - ‘dataproc-templates.zip’ saved [22294152/22294152]

student-04-e240913b2dbe@lab-vm:~$ unzip dataproc-templates.zip
Archive:  dataproc-templates.zip
   creating: dataproc-templates/
  inflating: dataproc-templates/CODE_OF_CONDUCT.md  
   creating: dataproc-templates/airflow/
   creating: dataproc-templates/airflow/tests/
   creating: dataproc-templates/airflow/tests/dags/
  inflating: dataproc-templates/airflow/tests/dags/test_submit_pyspark_dataproc_template.py  
  inflating: dataproc-templates/airflow/tests/dags/test_submit_spark_dataproc_template.py  
  inflating: dataproc-templates/airflow/tests/test_integrity.py  
   creating: dataproc-templates/airflow/tests/test_util/
  inflating: dataproc-templates/airflow/tests/test_util/helper_functions.py  
   creating: dataproc-templates/airflow/dags/
   creating: dataproc-templates/airflow/dags/config/
  inflating: dataproc-templates/airflow/dags/config/submit_pyspark_dataproc_template.ini  
  inflating: dataproc-templates/airflow/dags/config/submit_spark_dataproc_template.ini  
  inflating: dataproc-templates/airflow/dags/submit_spark_dataproc_template.py  
  inflating: dataproc-templates/airflow/dags/submit_pyspark_dataproc_template.py  
  inflating: dataproc-templates/airflow/README.md  
   creating: dataproc-templates/.kokoro/
  inflating: dataproc-templates/.kokoro/requirements.in  
   creating: dataproc-templates/.kokoro/release/
  inflating: dataproc-templates/.kokoro/release/common.cfg  
  inflating: dataproc-templates/.kokoro/release/release.cfg  
  inflating: dataproc-templates/.kokoro/trampoline.sh  
  inflating: dataproc-templates/.kokoro/requirements.txt  
  inflating: dataproc-templates/.kokoro/populate-secrets.sh  
  inflating: dataproc-templates/.kokoro/trampoline_v2.sh  
  inflating: dataproc-templates/.kokoro/release.sh  
   creating: dataproc-templates/java/
  inflating: dataproc-templates/java/JAVA_LICENSE_HEADER  
   creating: dataproc-templates/java/.ci/
  inflating: dataproc-templates/java/.ci/Jenkinsfile  
  inflating: dataproc-templates/java/.gitignore  
   creating: dataproc-templates/java/bin/
  inflating: dataproc-templates/java/bin/dataproc_template_functions.sh  
  inflating: dataproc-templates/java/bin/start.sh  
   creating: dataproc-templates/java/src/
   creating: dataproc-templates/java/src/test/
   creating: dataproc-templates/java/src/test/java/
   creating: dataproc-templates/java/src/test/java/com/
   creating: dataproc-templates/java/src/test/java/com/google/
   creating: dataproc-templates/java/src/test/java/com/google/cloud/
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/hbase/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/hbase/HbaseToGCSTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/hive/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/hive/HiveToGCSTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/hive/HiveToBigQueryTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/s3/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/s3/S3ToBigQueryTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/pubsub/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/pubsub/PubSubToBQTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/pubsub/PubSubToBigTableTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/pubsub/PubSubToGCSTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/gcs/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/gcs/GCStoBigqueryTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/gcs/GCSToSpannerTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/gcs/GCStoBigTableTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/gcs/GCStoJDBCTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/gcs/GCStoGCSTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/gcs/GCStoMongoTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/gcs/TextToBigqueryTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/config/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/config/InputConfigTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/config/OutputConfigTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/config/GeneralTemplateConfigTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/config/QueryConfigTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/main/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/main/DataProcTemplateTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/main/GCSToBigTableHFileTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/pubsublite/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/pubsublite/PubSubLiteToBigTableTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/general/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/general/GeneralTemplateTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/bigquery/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/bigquery/BigQueryToGCSTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/databases/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/databases/MongoToGCSTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/databases/CassandraToBQTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/databases/CassandraToGCSTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/databases/SpannerToGCSTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/kafka/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/kafka/KafkaToBQTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/kafka/KafkaToBQDstreamTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/kafka/KafkaToGCSTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/kafka/KafkaReaderTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/kafka/KafkaToGCSDstreamTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/redshift/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/redshift/RedshiftToGCSTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/dataplex/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/dataplex/DataplexGCSToBQTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/snowflake/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/snowflake/SnowflakeToGCSTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/util/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/util/PropertyUtilTest.java  
   creating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/jdbc/
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/jdbc/JDBCToJDBCTest.java  
  inflating: dataproc-templates/java/src/test/java/com/google/cloud/dataproc/templates/jdbc/JDBCToGCSTest.java  
   creating: dataproc-templates/java/src/test/resources/
  inflating: dataproc-templates/java/src/test/resources/log4j-spark-driver-template.properties  
   creating: dataproc-templates/java/src/main/
   creating: dataproc-templates/java/src/main/java/
   creating: dataproc-templates/java/src/main/java/com/
   creating: dataproc-templates/java/src/main/java/com/google/
   creating: dataproc-templates/java/src/main/java/com/google/cloud/
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/word/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/word/WordCount.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/hbase/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/hbase/HbaseToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/hbase/README.md  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/hbase/Dockerfile  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/BaseTemplate.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/hive/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/hive/HiveToBigQuery.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/hive/HiveToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/hive/README.md  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/s3/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/s3/S3ToBigQuery.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/s3/README.md  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/pubsub/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/pubsub/PubSubToBQ.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/pubsub/README.md  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/pubsub/PubSubToBigTable.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/pubsub/PubSubToGCS.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/TextToBigquery.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/GCStoMongo.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/GCSToJDBCConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/README.md  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/GCStoBigquery.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/GCSToSpannerConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/GCStoGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/GCSToJDBC.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/GCSToSpanner.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/gcs/GCStoBigTable.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/config/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/config/InputConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/config/OutputConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/config/QueryConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/config/GeneralTemplateConfig.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/main/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/main/DataProcTemplate.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/pubsublite/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/pubsublite/PubSubLiteToBigTable.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/pubsublite/README.md  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/general/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/general/GeneralTemplate.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/general/README.md  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/bigquery/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/bigquery/BigQueryToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/bigquery/README.md  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/CassandraToBqConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/RedshiftToGCSConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/SpannerToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/README.md  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/RedshiftToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/CassandraToGCSConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/CassandraToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/SpannerToGCSConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/MongoToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/databases/CassandraToBQ.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/kafka/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/kafka/KafkaToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/kafka/KafkaToGCSDstream.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/kafka/KafkaToBQDstream.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/kafka/KafkaToBQ.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/kafka/README.md  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/kafka/KafkaToPubSub.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/kafka/KafkaReader.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/dataplex/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/dataplex/DataplexGCStoBQ.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/dataplex/README.md  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/snowflake/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/snowflake/README.md  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/snowflake/SnowflakeToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/snowflake/SnowflakeToGCSConfig.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/Dataplex/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/Dataplex/DataplexAPIUtil.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/Dataplex/DataplexEntityUtil.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/Dataplex/DataplexAssetUtil.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/TemplateConstants.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/PropertyUtil.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/ReadSchemaUtil.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/DataprocTemplateException.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/ValidationUtil.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/util/TemplateUtil.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/JDBCToGCS.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/JDBCToSpanner.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/README.md  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/JDBCToGCSConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/JDBCToJDBC.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/JDBCToJDBCConfig.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/JDBCToBigQuery.java  
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/templates/jdbc/JDBCToSpannerConfig.java  
   creating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/dialects/
  inflating: dataproc-templates/java/src/main/java/com/google/cloud/dataproc/dialects/SpannerJdbcDialect.java  
   creating: dataproc-templates/java/src/main/resources/
  inflating: dataproc-templates/java/src/main/resources/logback.xml  
  inflating: dataproc-templates/java/src/main/resources/template.properties  
  inflating: dataproc-templates/java/src/main/resources/hbase-site.xml  
  inflating: dataproc-templates/java/src/main/resources/logback-test.xml  
  inflating: dataproc-templates/java/README.md  
  inflating: dataproc-templates/java/pom.xml  
  inflating: dataproc-templates/CONTRIBUTORS.md  
   creating: dataproc-templates/python/
  inflating: dataproc-templates/python/.pylintrc  
   creating: dataproc-templates/python/build/
   creating: dataproc-templates/python/build/lib/
   creating: dataproc-templates/python/build/lib/test/
   creating: dataproc-templates/python/build/lib/test/mongo/
 extracting: dataproc-templates/python/build/lib/test/mongo/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/mongo/test_mongo_to_gcs.py  
  inflating: dataproc-templates/python/build/lib/test/mongo/test_mongo_to_bq.py  
   creating: dataproc-templates/python/build/lib/test/hbase/
  inflating: dataproc-templates/python/build/lib/test/hbase/test_hbase_to_gcs.py  
 extracting: dataproc-templates/python/build/lib/test/hbase/__init__.py  
   creating: dataproc-templates/python/build/lib/test/hive/
  inflating: dataproc-templates/python/build/lib/test/hive/test_hive_to_gcs.py  
 extracting: dataproc-templates/python/build/lib/test/hive/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/hive/test_hive_to_bigquery.py  
   creating: dataproc-templates/python/build/lib/test/hive/util/
 extracting: dataproc-templates/python/build/lib/test/hive/util/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/hive/util/test_hive_ddl_extractor.py  
   creating: dataproc-templates/python/build/lib/test/s3/
 extracting: dataproc-templates/python/build/lib/test/s3/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/s3/test_s3_to_bigquery.py  
   creating: dataproc-templates/python/build/lib/test/azure/
 extracting: dataproc-templates/python/build/lib/test/azure/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/azure/test_azure_blob_storage_to_bigquery.py  
   creating: dataproc-templates/python/build/lib/test/gcs/
 extracting: dataproc-templates/python/build/lib/test/gcs/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/gcs/test_gcs_to_bigquery.py  
  inflating: dataproc-templates/python/build/lib/test/gcs/test_text_to_bigquery.py  
  inflating: dataproc-templates/python/build/lib/test/gcs/test_gcs_to_mongo.py  
  inflating: dataproc-templates/python/build/lib/test/gcs/test_gcs_to_jdbc.py  
  inflating: dataproc-templates/python/build/lib/test/gcs/test_gcs_to_bigtable.py  
  inflating: dataproc-templates/python/build/lib/test/gcs/test_gcs_to_gcs.py  
   creating: dataproc-templates/python/build/lib/test/pubsublite/
 extracting: dataproc-templates/python/build/lib/test/pubsublite/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/pubsublite/test_pubsublite_to_bigtable.py  
  inflating: dataproc-templates/python/build/lib/test/pubsublite/test_pubsublite_to_gcs.py  
   creating: dataproc-templates/python/build/lib/test/bigquery/
  inflating: dataproc-templates/python/build/lib/test/bigquery/test_bigquery_to_gcs.py  
 extracting: dataproc-templates/python/build/lib/test/bigquery/__init__.py  
   creating: dataproc-templates/python/build/lib/test/redshift/
  inflating: dataproc-templates/python/build/lib/test/redshift/test_redshift_to_gcs.py  
 extracting: dataproc-templates/python/build/lib/test/redshift/__init__.py  
   creating: dataproc-templates/python/build/lib/test/cassandra/
  inflating: dataproc-templates/python/build/lib/test/cassandra/test_cassandra_to_gcs.py  
 extracting: dataproc-templates/python/build/lib/test/cassandra/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/cassandra/test_cassandra_to_bq.py  
   creating: dataproc-templates/python/build/lib/test/elasticsearch/
  inflating: dataproc-templates/python/build/lib/test/elasticsearch/test_elasticsearch_to_gcs.py  
 extracting: dataproc-templates/python/build/lib/test/elasticsearch/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/elasticsearch/test_elasticsearch_to_bq.py  
  inflating: dataproc-templates/python/build/lib/test/elasticsearch/test_elasticsearch_to_bigtable.py  
   creating: dataproc-templates/python/build/lib/test/util/
 extracting: dataproc-templates/python/build/lib/test/util/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/util/test_elasticsearch_transformations.py  
  inflating: dataproc-templates/python/build/lib/test/util/test_argument_parsing.py  
   creating: dataproc-templates/python/build/lib/test/jdbc/
 extracting: dataproc-templates/python/build/lib/test/jdbc/__init__.py  
  inflating: dataproc-templates/python/build/lib/test/jdbc/test_jdbc_to_gcs.py  
  inflating: dataproc-templates/python/build/lib/test/jdbc/test_jdbc_to_bigquery.py  
  inflating: dataproc-templates/python/build/lib/test/jdbc/test_jdbc_to_jdbc.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/
   creating: dataproc-templates/python/build/lib/dataproc_templates/mongo/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/mongo/mongo_to_bq.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/mongo/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/mongo/mongo_to_gcs.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/hbase/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/hbase/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/hbase/hbase_to_gcs.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/hive/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/hive/hive_to_bigquery.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/hive/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/hive/hive_to_gcs.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/hive/util/
 extracting: dataproc-templates/python/build/lib/dataproc_templates/hive/util/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/hive/util/hive_ddl_extractor.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/__init__.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/s3/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/s3/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/s3/s3_to_bigquery.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/template_name.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/base_template.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/azure/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/azure/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/azure/azure_blob_storage_to_bigquery.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/gcs/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/gcs/gcs_to_gcs.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/gcs/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/gcs/gcs_to_jdbc.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/gcs/text_to_bigquery.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/gcs/gcs_to_bigquery.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/gcs/gcs_to_mongo.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/gcs/gcs_to_bigtable.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/pubsublite/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/pubsublite/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/pubsublite/pubsublite_to_bigtable.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/pubsublite/pubsublite_to_gcs.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/bigquery/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/bigquery/bigquery_to_gcs.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/bigquery/__init__.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/kafka/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/kafka/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/kafka/kafka_to_bq.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/kafka/kafka_to_gcs.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/redshift/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/redshift/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/redshift/redshift_to_gcs.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/cassandra/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/cassandra/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/cassandra/cassandra_to_gcs.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/cassandra/cassandra_to_bigquery.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/snowflake/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/snowflake/snowflake_to_gcs.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/snowflake/__init__.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/elasticsearch/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/elasticsearch/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/elasticsearch/elasticsearch_to_gcs.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/elasticsearch/elasticsearch_to_bq.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/elasticsearch/elasticsearch_to_bigtable.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/util/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/util/dataframe_writer_wrappers.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/util/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/util/tracking.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/util/template_constants.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/util/secret_manager.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/util/elasticsearch_transformations.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/util/dataframe_reader_wrappers.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/util/argument_parsing.py  
   creating: dataproc-templates/python/build/lib/dataproc_templates/jdbc/
  inflating: dataproc-templates/python/build/lib/dataproc_templates/jdbc/__init__.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/jdbc/jdbc_to_gcs.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/jdbc/jdbc_to_jdbc.py  
  inflating: dataproc-templates/python/build/lib/dataproc_templates/jdbc/jdbc_to_bigquery.py  
   creating: dataproc-templates/python/build/bdist.linux-x86_64/
   creating: dataproc-templates/python/test/
   creating: dataproc-templates/python/test/mongo/
 extracting: dataproc-templates/python/test/mongo/__init__.py  
  inflating: dataproc-templates/python/test/mongo/test_mongo_to_gcs.py  
  inflating: dataproc-templates/python/test/mongo/test_mongo_to_bq.py  
   creating: dataproc-templates/python/test/hbase/
  inflating: dataproc-templates/python/test/hbase/test_hbase_to_gcs.py  
 extracting: dataproc-templates/python/test/hbase/__init__.py  
   creating: dataproc-templates/python/test/hive/
  inflating: dataproc-templates/python/test/hive/test_hive_to_gcs.py  
 extracting: dataproc-templates/python/test/hive/__init__.py  
  inflating: dataproc-templates/python/test/hive/test_hive_to_bigquery.py  
   creating: dataproc-templates/python/test/hive/util/
 extracting: dataproc-templates/python/test/hive/util/__init__.py  
  inflating: dataproc-templates/python/test/hive/util/test_hive_ddl_extractor.py  
 extracting: dataproc-templates/python/test/__init__.py  
   creating: dataproc-templates/python/test/s3/
 extracting: dataproc-templates/python/test/s3/__init__.py  
  inflating: dataproc-templates/python/test/s3/test_s3_to_bigquery.py  
   creating: dataproc-templates/python/test/azure/
 extracting: dataproc-templates/python/test/azure/__init__.py  
  inflating: dataproc-templates/python/test/azure/test_azure_blob_storage_to_bigquery.py  
   creating: dataproc-templates/python/test/gcs/
 extracting: dataproc-templates/python/test/gcs/__init__.py  
  inflating: dataproc-templates/python/test/gcs/test_gcs_to_bigquery.py  
  inflating: dataproc-templates/python/test/gcs/test_text_to_bigquery.py  
  inflating: dataproc-templates/python/test/gcs/test_gcs_to_mongo.py  
  inflating: dataproc-templates/python/test/gcs/test_gcs_to_jdbc.py  
  inflating: dataproc-templates/python/test/gcs/test_gcs_to_bigtable.py  
  inflating: dataproc-templates/python/test/gcs/test_gcs_to_gcs.py  
   creating: dataproc-templates/python/test/pubsublite/
 extracting: dataproc-templates/python/test/pubsublite/__init__.py  
  inflating: dataproc-templates/python/test/pubsublite/test_pubsublite_to_bigtable.py  
  inflating: dataproc-templates/python/test/pubsublite/test_pubsublite_to_gcs.py  
   creating: dataproc-templates/python/test/bigquery/
  inflating: dataproc-templates/python/test/bigquery/test_bigquery_to_gcs.py  
 extracting: dataproc-templates/python/test/bigquery/__init__.py  
   creating: dataproc-templates/python/test/redshift/
  inflating: dataproc-templates/python/test/redshift/test_redshift_to_gcs.py  
 extracting: dataproc-templates/python/test/redshift/__init__.py  
   creating: dataproc-templates/python/test/cassandra/
  inflating: dataproc-templates/python/test/cassandra/test_cassandra_to_gcs.py  
 extracting: dataproc-templates/python/test/cassandra/__init__.py  
  inflating: dataproc-templates/python/test/cassandra/test_cassandra_to_bq.py  
   creating: dataproc-templates/python/test/snowflake/
  inflating: dataproc-templates/python/test/snowflake/test_snowflake_to_gcs.py  
   creating: dataproc-templates/python/test/elasticsearch/
  inflating: dataproc-templates/python/test/elasticsearch/test_elasticsearch_to_gcs.py  
 extracting: dataproc-templates/python/test/elasticsearch/__init__.py  
  inflating: dataproc-templates/python/test/elasticsearch/test_elasticsearch_to_bq.py  
  inflating: dataproc-templates/python/test/elasticsearch/test_elasticsearch_to_bigtable.py  
   creating: dataproc-templates/python/test/util/
 extracting: dataproc-templates/python/test/util/__init__.py  
  inflating: dataproc-templates/python/test/util/test_elasticsearch_transformations.py  
  inflating: dataproc-templates/python/test/util/test_argument_parsing.py  
   creating: dataproc-templates/python/test/jdbc/
 extracting: dataproc-templates/python/test/jdbc/__init__.py  
  inflating: dataproc-templates/python/test/jdbc/test_jdbc_to_gcs.py  
  inflating: dataproc-templates/python/test/jdbc/test_jdbc_to_bigquery.py  
  inflating: dataproc-templates/python/test/jdbc/test_jdbc_to_jdbc.py  
   creating: dataproc-templates/python/google_dataproc_templates.egg-info/
  inflating: dataproc-templates/python/google_dataproc_templates.egg-info/PKG-INFO  
 extracting: dataproc-templates/python/google_dataproc_templates.egg-info/dependency_links.txt  
  inflating: dataproc-templates/python/google_dataproc_templates.egg-info/requires.txt  
  inflating: dataproc-templates/python/google_dataproc_templates.egg-info/SOURCES.txt  
 extracting: dataproc-templates/python/google_dataproc_templates.egg-info/top_level.txt  
  inflating: dataproc-templates/python/setup.py  
   creating: dataproc-templates/python/.ci/
  inflating: dataproc-templates/python/.ci/Jenkinsfile  
  inflating: dataproc-templates/python/MANIFEST.in  
  inflating: dataproc-templates/python/.gitignore  
  inflating: dataproc-templates/python/setup.cfg  
  inflating: dataproc-templates/python/release-please-config.json  
   creating: dataproc-templates/python/bin/
  inflating: dataproc-templates/python/bin/dataproc_template_functions.sh  
  inflating: dataproc-templates/python/bin/start.sh  
   creating: dataproc-templates/python/dist/
  inflating: dataproc-templates/python/dist/dataproc_templates_distribution.egg  
  inflating: dataproc-templates/python/README.md  
  inflating: dataproc-templates/python/requirements.txt  
   creating: dataproc-templates/python/dataproc_templates/
   creating: dataproc-templates/python/dataproc_templates/mongo/
  inflating: dataproc-templates/python/dataproc_templates/mongo/mongo_to_bq.py  
  inflating: dataproc-templates/python/dataproc_templates/mongo/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/mongo/mongo_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/mongo/README.md  
   creating: dataproc-templates/python/dataproc_templates/hbase/
  inflating: dataproc-templates/python/dataproc_templates/hbase/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/hbase/README.md  
  inflating: dataproc-templates/python/dataproc_templates/hbase/Dockerfile  
  inflating: dataproc-templates/python/dataproc_templates/hbase/hbase_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/hbase/hbase-site.xml  
   creating: dataproc-templates/python/dataproc_templates/hive/
  inflating: dataproc-templates/python/dataproc_templates/hive/hive_to_bigquery.py  
  inflating: dataproc-templates/python/dataproc_templates/hive/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/hive/README.md  
  inflating: dataproc-templates/python/dataproc_templates/hive/hive_to_gcs.py  
   creating: dataproc-templates/python/dataproc_templates/hive/util/
 extracting: dataproc-templates/python/dataproc_templates/hive/util/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/hive/util/hive_ddl_extractor.py  
  inflating: dataproc-templates/python/dataproc_templates/hive/util/README.md  
  inflating: dataproc-templates/python/dataproc_templates/__init__.py  
   creating: dataproc-templates/python/dataproc_templates/s3/
  inflating: dataproc-templates/python/dataproc_templates/s3/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/s3/README.md  
  inflating: dataproc-templates/python/dataproc_templates/s3/s3_to_bigquery.py  
  inflating: dataproc-templates/python/dataproc_templates/template_name.py  
  inflating: dataproc-templates/python/dataproc_templates/base_template.py  
   creating: dataproc-templates/python/dataproc_templates/azure/
  inflating: dataproc-templates/python/dataproc_templates/azure/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/azure/azure_blob_storage_to_bigquery.py  
  inflating: dataproc-templates/python/dataproc_templates/azure/README.md  
   creating: dataproc-templates/python/dataproc_templates/gcs/
  inflating: dataproc-templates/python/dataproc_templates/gcs/gcs_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/gcs/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/gcs/gcs_to_jdbc.py  
  inflating: dataproc-templates/python/dataproc_templates/gcs/text_to_bigquery.py  
  inflating: dataproc-templates/python/dataproc_templates/gcs/README.md  
  inflating: dataproc-templates/python/dataproc_templates/gcs/Dockerfile  
  inflating: dataproc-templates/python/dataproc_templates/gcs/gcs_to_bigquery.py  
  inflating: dataproc-templates/python/dataproc_templates/gcs/gcs_to_mongo.py  
  inflating: dataproc-templates/python/dataproc_templates/gcs/hbase-site.xml  
  inflating: dataproc-templates/python/dataproc_templates/gcs/gcs_to_bigtable.py  
   creating: dataproc-templates/python/dataproc_templates/pubsublite/
  inflating: dataproc-templates/python/dataproc_templates/pubsublite/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/pubsublite/pubsublite_to_bigtable.py  
  inflating: dataproc-templates/python/dataproc_templates/pubsublite/README.md  
  inflating: dataproc-templates/python/dataproc_templates/pubsublite/pubsublite_to_gcs.py  
   creating: dataproc-templates/python/dataproc_templates/bigquery/
  inflating: dataproc-templates/python/dataproc_templates/bigquery/bigquery_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/bigquery/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/bigquery/README.md  
   creating: dataproc-templates/python/dataproc_templates/kafka/
  inflating: dataproc-templates/python/dataproc_templates/kafka/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/kafka/kafka_to_bq.py  
  inflating: dataproc-templates/python/dataproc_templates/kafka/README.md  
  inflating: dataproc-templates/python/dataproc_templates/kafka/kafka_to_gcs.py  
   creating: dataproc-templates/python/dataproc_templates/redshift/
  inflating: dataproc-templates/python/dataproc_templates/redshift/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/redshift/redshift_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/redshift/README.md  
   creating: dataproc-templates/python/dataproc_templates/cassandra/
  inflating: dataproc-templates/python/dataproc_templates/cassandra/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/cassandra/README.md  
  inflating: dataproc-templates/python/dataproc_templates/cassandra/cassandra_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/cassandra/cassandra_to_bigquery.py  
   creating: dataproc-templates/python/dataproc_templates/snowflake/
  inflating: dataproc-templates/python/dataproc_templates/snowflake/snowflake_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/snowflake/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/snowflake/README.md  
   creating: dataproc-templates/python/dataproc_templates/elasticsearch/
  inflating: dataproc-templates/python/dataproc_templates/elasticsearch/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/elasticsearch/elasticsearch_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/elasticsearch/README.md  
  inflating: dataproc-templates/python/dataproc_templates/elasticsearch/Dockerfile  
  inflating: dataproc-templates/python/dataproc_templates/elasticsearch/hbase-site.xml  
  inflating: dataproc-templates/python/dataproc_templates/elasticsearch/elasticsearch_to_bq.py  
  inflating: dataproc-templates/python/dataproc_templates/elasticsearch/elasticsearch_to_bigtable.py  
   creating: dataproc-templates/python/dataproc_templates/util/
  inflating: dataproc-templates/python/dataproc_templates/util/dataframe_writer_wrappers.py  
  inflating: dataproc-templates/python/dataproc_templates/util/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/util/tracking.py  
  inflating: dataproc-templates/python/dataproc_templates/util/template_constants.py  
  inflating: dataproc-templates/python/dataproc_templates/util/secret_manager.py  
  inflating: dataproc-templates/python/dataproc_templates/util/elasticsearch_transformations.py  
  inflating: dataproc-templates/python/dataproc_templates/util/dataframe_reader_wrappers.py  
  inflating: dataproc-templates/python/dataproc_templates/util/argument_parsing.py  
   creating: dataproc-templates/python/dataproc_templates/jdbc/
  inflating: dataproc-templates/python/dataproc_templates/jdbc/__init__.py  
  inflating: dataproc-templates/python/dataproc_templates/jdbc/jdbc_to_gcs.py  
  inflating: dataproc-templates/python/dataproc_templates/jdbc/README.md  
  inflating: dataproc-templates/python/dataproc_templates/jdbc/jdbc_to_jdbc.py  
  inflating: dataproc-templates/python/dataproc_templates/jdbc/jdbc_to_bigquery.py  
  inflating: dataproc-templates/python/main.py  
 extracting: dataproc-templates/python/version.py  
  inflating: dataproc-templates/.gitignore  
  inflating: dataproc-templates/.trampolinerc  
 extracting: dataproc-templates/.release-please-manifest.json  
  inflating: dataproc-templates/cloudbuild.yaml  
  inflating: dataproc-templates/CONTRIBUTING.md  
  inflating: dataproc-templates/README.md  
  inflating: dataproc-templates/CHANGELOG.md  
   creating: dataproc-templates/docs/
  inflating: dataproc-templates/docs/release-please-pr.png  
  inflating: dataproc-templates/docs/commit-checker-error.png  
  inflating: dataproc-templates/docs/commit-checker-release-automation.md  
  inflating: dataproc-templates/docs/commit-checker-bot.png  
   creating: dataproc-templates/notebooks/
   creating: dataproc-templates/notebooks/test/
   creating: dataproc-templates/notebooks/test/util/
  inflating: dataproc-templates/notebooks/test/util/test_notebook_functions.py  
  inflating: dataproc-templates/notebooks/test/util/test_jdbc_input_manager.py  
 extracting: dataproc-templates/notebooks/__init__.py  
   creating: dataproc-templates/notebooks/mssql2bq/
  inflating: dataproc-templates/notebooks/mssql2bq/README.md  
  inflating: dataproc-templates/notebooks/mssql2bq/mssql-to-bigquery-notebook.ipynb  
   creating: dataproc-templates/notebooks/mysql2spanner/
  inflating: dataproc-templates/notebooks/mysql2spanner/__init__.py  
  inflating: dataproc-templates/notebooks/mysql2spanner/MySqlToSpanner_notebook.ipynb  
  inflating: dataproc-templates/notebooks/mysql2spanner/MySqlToSpanner_parameterize_script.py  
  inflating: dataproc-templates/notebooks/mysql2spanner/README.md  
  inflating: dataproc-templates/notebooks/run_notebook.py  
   creating: dataproc-templates/notebooks/oracle2bq/
  inflating: dataproc-templates/notebooks/oracle2bq/__init__.py  
  inflating: dataproc-templates/notebooks/oracle2bq/OracleToBigQuery_parameterize_script.py  
  inflating: dataproc-templates/notebooks/oracle2bq/OracleToBigQuery_notebook.ipynb  
  inflating: dataproc-templates/notebooks/oracle2bq/README.md  
   creating: dataproc-templates/notebooks/oracle2spanner/
  inflating: dataproc-templates/notebooks/oracle2spanner/README.md  
  inflating: dataproc-templates/notebooks/oracle2spanner/OracleToSpanner_notebook.ipynb  
   creating: dataproc-templates/notebooks/hive2bq/
  inflating: dataproc-templates/notebooks/hive2bq/__init__.py  
  inflating: dataproc-templates/notebooks/hive2bq/HiveToBigquery_parameterize_script.py  
  inflating: dataproc-templates/notebooks/hive2bq/HiveToBigquery_notebook.ipynb  
  inflating: dataproc-templates/notebooks/hive2bq/README.md  
   creating: dataproc-templates/notebooks/hive2bq/images/
  inflating: dataproc-templates/notebooks/hive2bq/images/HiveToBQ_Flow.png  
   creating: dataproc-templates/notebooks/oracle2postgres/
  inflating: dataproc-templates/notebooks/oracle2postgres/OracleToPostgres_notebook.ipynb  
  inflating: dataproc-templates/notebooks/oracle2postgres/__init__.py  
  inflating: dataproc-templates/notebooks/oracle2postgres/README.md  
  inflating: dataproc-templates/notebooks/oracle2postgres/OracleToPostgres_parameterize_script.py  
   creating: dataproc-templates/notebooks/parameterize_script/
  inflating: dataproc-templates/notebooks/parameterize_script/script_name.py  
  inflating: dataproc-templates/notebooks/parameterize_script/__init__.py  
  inflating: dataproc-templates/notebooks/parameterize_script/base_parameterize_script.py  
   creating: dataproc-templates/notebooks/parameterize_script/util/
  inflating: dataproc-templates/notebooks/parameterize_script/util/__init__.py  
  inflating: dataproc-templates/notebooks/parameterize_script/util/notebook_constants.py  
  inflating: dataproc-templates/notebooks/parameterize_script/util/argument_parsing.py  
   creating: dataproc-templates/notebooks/mssql2postgresql/
  inflating: dataproc-templates/notebooks/mssql2postgresql/README.md  
  inflating: dataproc-templates/notebooks/mssql2postgresql/mssql-to-postgres-notebook.ipynb  
  inflating: dataproc-templates/notebooks/README.md  
  inflating: dataproc-templates/notebooks/requirements.txt  
   creating: dataproc-templates/notebooks/postgresql2bq/
  inflating: dataproc-templates/notebooks/postgresql2bq/PostgreSqlToBigQuery_parameterize_script.py  
  inflating: dataproc-templates/notebooks/postgresql2bq/__init__.py  
  inflating: dataproc-templates/notebooks/postgresql2bq/postgresql-to-bigquery-notebook.ipynb  
  inflating: dataproc-templates/notebooks/postgresql2bq/README.md  
   creating: dataproc-templates/notebooks/util/
 extracting: dataproc-templates/notebooks/util/__init__.py  
  inflating: dataproc-templates/notebooks/util/notebook_functions.py  
  inflating: dataproc-templates/notebooks/util/global_typeconvert.config.yaml  
  inflating: dataproc-templates/notebooks/util/sql_translation.py  
   creating: dataproc-templates/notebooks/util/jdbc/
 extracting: dataproc-templates/notebooks/util/jdbc/__init__.py  
  inflating: dataproc-templates/notebooks/util/jdbc/jdbc_input_manager_interface.py  
   creating: dataproc-templates/notebooks/util/jdbc/engines/
 extracting: dataproc-templates/notebooks/util/jdbc/engines/__init__.py  
  inflating: dataproc-templates/notebooks/util/jdbc/engines/mysql_input_manager.py  
  inflating: dataproc-templates/notebooks/util/jdbc/engines/oracle_input_manager.py  
  inflating: dataproc-templates/notebooks/util/jdbc/jdbc_input_manager.py  
   creating: dataproc-templates/notebooks/generic_notebook/
  inflating: dataproc-templates/notebooks/generic_notebook/README.md  
   creating: dataproc-templates/notebooks/generic_notebook/images/
  inflating: dataproc-templates/notebooks/generic_notebook/images/create_notebook.png  
  inflating: dataproc-templates/notebooks/generic_notebook/images/clone_repository.png  
  inflating: dataproc-templates/notebooks/generic_notebook/vertex_pipeline_pyspark.ipynb  
  inflating: dataproc-templates/dp-templates.png  
   creating: dataproc-templates/.git/
  inflating: dataproc-templates/.git/description  
  inflating: dataproc-templates/.git/packed-refs  
   creating: dataproc-templates/.git/logs/
   creating: dataproc-templates/.git/logs/refs/
   creating: dataproc-templates/.git/logs/refs/heads/
  inflating: dataproc-templates/.git/logs/refs/heads/main  
   creating: dataproc-templates/.git/logs/refs/remotes/
   creating: dataproc-templates/.git/logs/refs/remotes/origin/
  inflating: dataproc-templates/.git/logs/refs/remotes/origin/HEAD  
  inflating: dataproc-templates/.git/logs/HEAD  
   creating: dataproc-templates/.git/objects/
   creating: dataproc-templates/.git/objects/pack/
  inflating: dataproc-templates/.git/objects/pack/pack-e4d71afaa4da093008dcc723aef9bf13516f01a5.pack  
  inflating: dataproc-templates/.git/objects/pack/pack-e4d71afaa4da093008dcc723aef9bf13516f01a5.idx  
   creating: dataproc-templates/.git/objects/info/
  inflating: dataproc-templates/.git/config  
   creating: dataproc-templates/.git/refs/
   creating: dataproc-templates/.git/refs/heads/
  inflating: dataproc-templates/.git/refs/heads/main  
   creating: dataproc-templates/.git/refs/remotes/
   creating: dataproc-templates/.git/refs/remotes/origin/
 extracting: dataproc-templates/.git/refs/remotes/origin/HEAD  
   creating: dataproc-templates/.git/refs/tags/
   creating: dataproc-templates/.git/branches/
 extracting: dataproc-templates/.git/HEAD  
   creating: dataproc-templates/.git/info/
  inflating: dataproc-templates/.git/info/exclude  
  inflating: dataproc-templates/.git/index  
   creating: dataproc-templates/.git/hooks/
  inflating: dataproc-templates/.git/hooks/update.sample  
  inflating: dataproc-templates/.git/hooks/pre-merge-commit.sample  
  inflating: dataproc-templates/.git/hooks/pre-applypatch.sample  
  inflating: dataproc-templates/.git/hooks/pre-push.sample  
  inflating: dataproc-templates/.git/hooks/pre-commit.sample  
  inflating: dataproc-templates/.git/hooks/commit-msg.sample  
  inflating: dataproc-templates/.git/hooks/prepare-commit-msg.sample  
  inflating: dataproc-templates/.git/hooks/push-to-checkout.sample  
  inflating: dataproc-templates/.git/hooks/applypatch-msg.sample  
  inflating: dataproc-templates/.git/hooks/post-update.sample  
  inflating: dataproc-templates/.git/hooks/fsmonitor-watchman.sample  
  inflating: dataproc-templates/.git/hooks/pre-rebase.sample  
  inflating: dataproc-templates/.git/hooks/pre-receive.sample  
   creating: dataproc-templates/.github/
   creating: dataproc-templates/.github/workflows/
  inflating: dataproc-templates/.github/workflows/python-publish.yml  
  inflating: dataproc-templates/.github/workflows/execute_jenkins_build_python.yml  
  inflating: dataproc-templates/.github/workflows/commit-checker.yml  
  inflating: dataproc-templates/.github/workflows/execute_jenkins_integration_tests_python.yml  
  inflating: dataproc-templates/.github/workflows/execute_jenkins_integration_tests_java.yml  
  inflating: dataproc-templates/.github/workflows/execute_jenkins_build_java.yml  
 extracting: dataproc-templates/.github/release-trigger.yml  
  inflating: dataproc-templates/.github/release-please.yml  
  inflating: dataproc-templates/LICENSE  
student-04-e240913b2dbe@lab-vm:~$ cd dataproc-templates/pytho
```
Task 3
```
student-04-e240913b2dbe@lab-vm:~$ cd dataproc-templates/python
student-04-e240913b2dbe@lab-vm:~/dataproc-templates/python$ ./bin/start.sh -- --template=GCSTOBIGQUERY     --gcs.bigquery.input.format="avro"     --gcs.bigquery.input.location="gs://qwiklabs-gcp-04-33309b7906a4"     --gcs.bigquery.input.inferschema="true"     --gcs.bigquery.output.dataset="loadavro"     --gcs.bigquery.output.table="campaigns"     --gcs.bigquery.output.mode=overwrite    --gcs.bigquery.temp.bucket.name="qwiklabs-gcp-04-33309b7906a4-bqtemp"
GCP_PROJECT=qwiklabs-gcp-04-33309b7906a4
REGION=us-west1
GCS_STAGING_LOCATION=gs://qwiklabs-gcp-04-33309b7906a4
/usr/lib/python3/dist-packages/setuptools/dist.py:461: UserWarning: Normalizing '0.5.0-beta' to '0.5.0b0'
  warnings.warn(tmpl.format(**locals()))
running bdist_egg
running egg_info
writing google_dataproc_templates.egg-info/PKG-INFO
writing dependency_links to google_dataproc_templates.egg-info/dependency_links.txt
writing requirements to google_dataproc_templates.egg-info/requires.txt
writing top-level names to google_dataproc_templates.egg-info/top_level.txt
reading manifest file 'google_dataproc_templates.egg-info/SOURCES.txt'
reading manifest template 'MANIFEST.in'
writing manifest file 'google_dataproc_templates.egg-info/SOURCES.txt'
installing library code to build/bdist.linux-x86_64/egg
running install_lib
running build_py
creating build/bdist.linux-x86_64/egg
creating build/bdist.linux-x86_64/egg/dataproc_templates
copying build/lib/dataproc_templates/template_name.py -> build/bdist.linux-x86_64/egg/dataproc_templates
creating build/bdist.linux-x86_64/egg/dataproc_templates/jdbc
copying build/lib/dataproc_templates/jdbc/jdbc_to_bigquery.py -> build/bdist.linux-x86_64/egg/dataproc_templates/jdbc
copying build/lib/dataproc_templates/jdbc/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/jdbc
copying build/lib/dataproc_templates/jdbc/jdbc_to_jdbc.py -> build/bdist.linux-x86_64/egg/dataproc_templates/jdbc
copying build/lib/dataproc_templates/jdbc/jdbc_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/jdbc
creating build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch
copying build/lib/dataproc_templates/elasticsearch/elasticsearch_to_bq.py -> build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch
copying build/lib/dataproc_templates/elasticsearch/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch
copying build/lib/dataproc_templates/elasticsearch/elasticsearch_to_bigtable.py -> build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch
copying build/lib/dataproc_templates/elasticsearch/elasticsearch_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch
copying build/lib/dataproc_templates/base_template.py -> build/bdist.linux-x86_64/egg/dataproc_templates
creating build/bdist.linux-x86_64/egg/dataproc_templates/cassandra
copying build/lib/dataproc_templates/cassandra/cassandra_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/cassandra
copying build/lib/dataproc_templates/cassandra/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/cassandra
copying build/lib/dataproc_templates/cassandra/cassandra_to_bigquery.py -> build/bdist.linux-x86_64/egg/dataproc_templates/cassandra
creating build/bdist.linux-x86_64/egg/dataproc_templates/snowflake
copying build/lib/dataproc_templates/snowflake/snowflake_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/snowflake
copying build/lib/dataproc_templates/snowflake/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/snowflake
creating build/bdist.linux-x86_64/egg/dataproc_templates/hbase
copying build/lib/dataproc_templates/hbase/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/hbase
copying build/lib/dataproc_templates/hbase/hbase_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/hbase
creating build/bdist.linux-x86_64/egg/dataproc_templates/hive
copying build/lib/dataproc_templates/hive/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/hive
copying build/lib/dataproc_templates/hive/hive_to_bigquery.py -> build/bdist.linux-x86_64/egg/dataproc_templates/hive
copying build/lib/dataproc_templates/hive/hive_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/hive
creating build/bdist.linux-x86_64/egg/dataproc_templates/hive/util
copying build/lib/dataproc_templates/hive/util/hive_ddl_extractor.py -> build/bdist.linux-x86_64/egg/dataproc_templates/hive/util
copying build/lib/dataproc_templates/hive/util/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/hive/util
creating build/bdist.linux-x86_64/egg/dataproc_templates/pubsublite
copying build/lib/dataproc_templates/pubsublite/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/pubsublite
copying build/lib/dataproc_templates/pubsublite/pubsublite_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/pubsublite
copying build/lib/dataproc_templates/pubsublite/pubsublite_to_bigtable.py -> build/bdist.linux-x86_64/egg/dataproc_templates/pubsublite
copying build/lib/dataproc_templates/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates
creating build/bdist.linux-x86_64/egg/dataproc_templates/redshift
copying build/lib/dataproc_templates/redshift/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/redshift
copying build/lib/dataproc_templates/redshift/redshift_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/redshift
creating build/bdist.linux-x86_64/egg/dataproc_templates/gcs
copying build/lib/dataproc_templates/gcs/gcs_to_mongo.py -> build/bdist.linux-x86_64/egg/dataproc_templates/gcs
copying build/lib/dataproc_templates/gcs/gcs_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/gcs
copying build/lib/dataproc_templates/gcs/gcs_to_bigtable.py -> build/bdist.linux-x86_64/egg/dataproc_templates/gcs
copying build/lib/dataproc_templates/gcs/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/gcs
copying build/lib/dataproc_templates/gcs/gcs_to_jdbc.py -> build/bdist.linux-x86_64/egg/dataproc_templates/gcs
copying build/lib/dataproc_templates/gcs/text_to_bigquery.py -> build/bdist.linux-x86_64/egg/dataproc_templates/gcs
copying build/lib/dataproc_templates/gcs/gcs_to_bigquery.py -> build/bdist.linux-x86_64/egg/dataproc_templates/gcs
creating build/bdist.linux-x86_64/egg/dataproc_templates/kafka
copying build/lib/dataproc_templates/kafka/kafka_to_bq.py -> build/bdist.linux-x86_64/egg/dataproc_templates/kafka
copying build/lib/dataproc_templates/kafka/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/kafka
copying build/lib/dataproc_templates/kafka/kafka_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/kafka
creating build/bdist.linux-x86_64/egg/dataproc_templates/s3
copying build/lib/dataproc_templates/s3/s3_to_bigquery.py -> build/bdist.linux-x86_64/egg/dataproc_templates/s3
copying build/lib/dataproc_templates/s3/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/s3
creating build/bdist.linux-x86_64/egg/dataproc_templates/mongo
copying build/lib/dataproc_templates/mongo/mongo_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/mongo
copying build/lib/dataproc_templates/mongo/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/mongo
copying build/lib/dataproc_templates/mongo/mongo_to_bq.py -> build/bdist.linux-x86_64/egg/dataproc_templates/mongo
creating build/bdist.linux-x86_64/egg/dataproc_templates/util
copying build/lib/dataproc_templates/util/template_constants.py -> build/bdist.linux-x86_64/egg/dataproc_templates/util
copying build/lib/dataproc_templates/util/argument_parsing.py -> build/bdist.linux-x86_64/egg/dataproc_templates/util
copying build/lib/dataproc_templates/util/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/util
copying build/lib/dataproc_templates/util/dataframe_writer_wrappers.py -> build/bdist.linux-x86_64/egg/dataproc_templates/util
copying build/lib/dataproc_templates/util/secret_manager.py -> build/bdist.linux-x86_64/egg/dataproc_templates/util
copying build/lib/dataproc_templates/util/elasticsearch_transformations.py -> build/bdist.linux-x86_64/egg/dataproc_templates/util
copying build/lib/dataproc_templates/util/tracking.py -> build/bdist.linux-x86_64/egg/dataproc_templates/util
copying build/lib/dataproc_templates/util/dataframe_reader_wrappers.py -> build/bdist.linux-x86_64/egg/dataproc_templates/util
creating build/bdist.linux-x86_64/egg/dataproc_templates/bigquery
copying build/lib/dataproc_templates/bigquery/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/bigquery
copying build/lib/dataproc_templates/bigquery/bigquery_to_gcs.py -> build/bdist.linux-x86_64/egg/dataproc_templates/bigquery
creating build/bdist.linux-x86_64/egg/dataproc_templates/azure
copying build/lib/dataproc_templates/azure/__init__.py -> build/bdist.linux-x86_64/egg/dataproc_templates/azure
copying build/lib/dataproc_templates/azure/azure_blob_storage_to_bigquery.py -> build/bdist.linux-x86_64/egg/dataproc_templates/azure
creating build/bdist.linux-x86_64/egg/test
creating build/bdist.linux-x86_64/egg/test/jdbc
copying build/lib/test/jdbc/test_jdbc_to_jdbc.py -> build/bdist.linux-x86_64/egg/test/jdbc
copying build/lib/test/jdbc/test_jdbc_to_gcs.py -> build/bdist.linux-x86_64/egg/test/jdbc
copying build/lib/test/jdbc/__init__.py -> build/bdist.linux-x86_64/egg/test/jdbc
copying build/lib/test/jdbc/test_jdbc_to_bigquery.py -> build/bdist.linux-x86_64/egg/test/jdbc
creating build/bdist.linux-x86_64/egg/test/elasticsearch
copying build/lib/test/elasticsearch/test_elasticsearch_to_bq.py -> build/bdist.linux-x86_64/egg/test/elasticsearch
copying build/lib/test/elasticsearch/__init__.py -> build/bdist.linux-x86_64/egg/test/elasticsearch
copying build/lib/test/elasticsearch/test_elasticsearch_to_gcs.py -> build/bdist.linux-x86_64/egg/test/elasticsearch
copying build/lib/test/elasticsearch/test_elasticsearch_to_bigtable.py -> build/bdist.linux-x86_64/egg/test/elasticsearch
creating build/bdist.linux-x86_64/egg/test/cassandra
copying build/lib/test/cassandra/__init__.py -> build/bdist.linux-x86_64/egg/test/cassandra
copying build/lib/test/cassandra/test_cassandra_to_gcs.py -> build/bdist.linux-x86_64/egg/test/cassandra
copying build/lib/test/cassandra/test_cassandra_to_bq.py -> build/bdist.linux-x86_64/egg/test/cassandra
creating build/bdist.linux-x86_64/egg/test/hbase
copying build/lib/test/hbase/__init__.py -> build/bdist.linux-x86_64/egg/test/hbase
copying build/lib/test/hbase/test_hbase_to_gcs.py -> build/bdist.linux-x86_64/egg/test/hbase
creating build/bdist.linux-x86_64/egg/test/hive
copying build/lib/test/hive/test_hive_to_bigquery.py -> build/bdist.linux-x86_64/egg/test/hive
copying build/lib/test/hive/test_hive_to_gcs.py -> build/bdist.linux-x86_64/egg/test/hive
copying build/lib/test/hive/__init__.py -> build/bdist.linux-x86_64/egg/test/hive
creating build/bdist.linux-x86_64/egg/test/hive/util
copying build/lib/test/hive/util/__init__.py -> build/bdist.linux-x86_64/egg/test/hive/util
copying build/lib/test/hive/util/test_hive_ddl_extractor.py -> build/bdist.linux-x86_64/egg/test/hive/util
creating build/bdist.linux-x86_64/egg/test/pubsublite
copying build/lib/test/pubsublite/test_pubsublite_to_gcs.py -> build/bdist.linux-x86_64/egg/test/pubsublite
copying build/lib/test/pubsublite/__init__.py -> build/bdist.linux-x86_64/egg/test/pubsublite
copying build/lib/test/pubsublite/test_pubsublite_to_bigtable.py -> build/bdist.linux-x86_64/egg/test/pubsublite
creating build/bdist.linux-x86_64/egg/test/redshift
copying build/lib/test/redshift/test_redshift_to_gcs.py -> build/bdist.linux-x86_64/egg/test/redshift
copying build/lib/test/redshift/__init__.py -> build/bdist.linux-x86_64/egg/test/redshift
creating build/bdist.linux-x86_64/egg/test/gcs
copying build/lib/test/gcs/test_text_to_bigquery.py -> build/bdist.linux-x86_64/egg/test/gcs
copying build/lib/test/gcs/__init__.py -> build/bdist.linux-x86_64/egg/test/gcs
copying build/lib/test/gcs/test_gcs_to_gcs.py -> build/bdist.linux-x86_64/egg/test/gcs
copying build/lib/test/gcs/test_gcs_to_mongo.py -> build/bdist.linux-x86_64/egg/test/gcs
copying build/lib/test/gcs/test_gcs_to_bigquery.py -> build/bdist.linux-x86_64/egg/test/gcs
copying build/lib/test/gcs/test_gcs_to_jdbc.py -> build/bdist.linux-x86_64/egg/test/gcs
copying build/lib/test/gcs/test_gcs_to_bigtable.py -> build/bdist.linux-x86_64/egg/test/gcs
creating build/bdist.linux-x86_64/egg/test/s3
copying build/lib/test/s3/__init__.py -> build/bdist.linux-x86_64/egg/test/s3
copying build/lib/test/s3/test_s3_to_bigquery.py -> build/bdist.linux-x86_64/egg/test/s3
creating build/bdist.linux-x86_64/egg/test/mongo
copying build/lib/test/mongo/test_mongo_to_gcs.py -> build/bdist.linux-x86_64/egg/test/mongo
copying build/lib/test/mongo/__init__.py -> build/bdist.linux-x86_64/egg/test/mongo
copying build/lib/test/mongo/test_mongo_to_bq.py -> build/bdist.linux-x86_64/egg/test/mongo
creating build/bdist.linux-x86_64/egg/test/util
copying build/lib/test/util/test_argument_parsing.py -> build/bdist.linux-x86_64/egg/test/util
copying build/lib/test/util/__init__.py -> build/bdist.linux-x86_64/egg/test/util
copying build/lib/test/util/test_elasticsearch_transformations.py -> build/bdist.linux-x86_64/egg/test/util
creating build/bdist.linux-x86_64/egg/test/bigquery
copying build/lib/test/bigquery/__init__.py -> build/bdist.linux-x86_64/egg/test/bigquery
copying build/lib/test/bigquery/test_bigquery_to_gcs.py -> build/bdist.linux-x86_64/egg/test/bigquery
creating build/bdist.linux-x86_64/egg/test/azure
copying build/lib/test/azure/__init__.py -> build/bdist.linux-x86_64/egg/test/azure
copying build/lib/test/azure/test_azure_blob_storage_to_bigquery.py -> build/bdist.linux-x86_64/egg/test/azure
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/template_name.py to template_name.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/jdbc/jdbc_to_bigquery.py to jdbc_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/jdbc/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/jdbc/jdbc_to_jdbc.py to jdbc_to_jdbc.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/jdbc/jdbc_to_gcs.py to jdbc_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch/elasticsearch_to_bq.py to elasticsearch_to_bq.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch/elasticsearch_to_bigtable.py to elasticsearch_to_bigtable.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/elasticsearch/elasticsearch_to_gcs.py to elasticsearch_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/base_template.py to base_template.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/cassandra/cassandra_to_gcs.py to cassandra_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/cassandra/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/cassandra/cassandra_to_bigquery.py to cassandra_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/snowflake/snowflake_to_gcs.py to snowflake_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/snowflake/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/hbase/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/hbase/hbase_to_gcs.py to hbase_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/hive/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/hive/hive_to_bigquery.py to hive_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/hive/hive_to_gcs.py to hive_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/hive/util/hive_ddl_extractor.py to hive_ddl_extractor.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/hive/util/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/pubsublite/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/pubsublite/pubsublite_to_gcs.py to pubsublite_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/pubsublite/pubsublite_to_bigtable.py to pubsublite_to_bigtable.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/redshift/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/redshift/redshift_to_gcs.py to redshift_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/gcs/gcs_to_mongo.py to gcs_to_mongo.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/gcs/gcs_to_gcs.py to gcs_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/gcs/gcs_to_bigtable.py to gcs_to_bigtable.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/gcs/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/gcs/gcs_to_jdbc.py to gcs_to_jdbc.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/gcs/text_to_bigquery.py to text_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/gcs/gcs_to_bigquery.py to gcs_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/kafka/kafka_to_bq.py to kafka_to_bq.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/kafka/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/kafka/kafka_to_gcs.py to kafka_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/s3/s3_to_bigquery.py to s3_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/s3/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/mongo/mongo_to_gcs.py to mongo_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/mongo/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/mongo/mongo_to_bq.py to mongo_to_bq.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/util/template_constants.py to template_constants.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/util/argument_parsing.py to argument_parsing.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/util/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/util/dataframe_writer_wrappers.py to dataframe_writer_wrappers.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/util/secret_manager.py to secret_manager.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/util/elasticsearch_transformations.py to elasticsearch_transformations.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/util/tracking.py to tracking.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/util/dataframe_reader_wrappers.py to dataframe_reader_wrappers.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/bigquery/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/bigquery/bigquery_to_gcs.py to bigquery_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/azure/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/dataproc_templates/azure/azure_blob_storage_to_bigquery.py to azure_blob_storage_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/jdbc/test_jdbc_to_jdbc.py to test_jdbc_to_jdbc.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/jdbc/test_jdbc_to_gcs.py to test_jdbc_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/jdbc/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/jdbc/test_jdbc_to_bigquery.py to test_jdbc_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/elasticsearch/test_elasticsearch_to_bq.py to test_elasticsearch_to_bq.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/elasticsearch/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/elasticsearch/test_elasticsearch_to_gcs.py to test_elasticsearch_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/elasticsearch/test_elasticsearch_to_bigtable.py to test_elasticsearch_to_bigtable.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/cassandra/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/cassandra/test_cassandra_to_gcs.py to test_cassandra_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/cassandra/test_cassandra_to_bq.py to test_cassandra_to_bq.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/hbase/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/hbase/test_hbase_to_gcs.py to test_hbase_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/hive/test_hive_to_bigquery.py to test_hive_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/hive/test_hive_to_gcs.py to test_hive_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/hive/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/hive/util/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/hive/util/test_hive_ddl_extractor.py to test_hive_ddl_extractor.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/pubsublite/test_pubsublite_to_gcs.py to test_pubsublite_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/pubsublite/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/pubsublite/test_pubsublite_to_bigtable.py to test_pubsublite_to_bigtable.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/redshift/test_redshift_to_gcs.py to test_redshift_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/redshift/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/gcs/test_text_to_bigquery.py to test_text_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/gcs/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/gcs/test_gcs_to_gcs.py to test_gcs_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/gcs/test_gcs_to_mongo.py to test_gcs_to_mongo.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/gcs/test_gcs_to_bigquery.py to test_gcs_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/gcs/test_gcs_to_jdbc.py to test_gcs_to_jdbc.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/gcs/test_gcs_to_bigtable.py to test_gcs_to_bigtable.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/s3/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/s3/test_s3_to_bigquery.py to test_s3_to_bigquery.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/mongo/test_mongo_to_gcs.py to test_mongo_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/mongo/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/mongo/test_mongo_to_bq.py to test_mongo_to_bq.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/util/test_argument_parsing.py to test_argument_parsing.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/util/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/util/test_elasticsearch_transformations.py to test_elasticsearch_transformations.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/bigquery/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/bigquery/test_bigquery_to_gcs.py to test_bigquery_to_gcs.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/azure/__init__.py to __init__.cpython-39.pyc
byte-compiling build/bdist.linux-x86_64/egg/test/azure/test_azure_blob_storage_to_bigquery.py to test_azure_blob_storage_to_bigquery.cpython-39.pyc
creating build/bdist.linux-x86_64/egg/EGG-INFO
copying google_dataproc_templates.egg-info/PKG-INFO -> build/bdist.linux-x86_64/egg/EGG-INFO
copying google_dataproc_templates.egg-info/SOURCES.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
copying google_dataproc_templates.egg-info/dependency_links.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
copying google_dataproc_templates.egg-info/requires.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
copying google_dataproc_templates.egg-info/top_level.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
zip_safe flag not set; analyzing archive contents...
creating 'dist/google_dataproc_templates-0.5.0b0-py3.9.egg' and adding 'build/bdist.linux-x86_64/egg' to it
removing 'build/bdist.linux-x86_64/egg' (and everything under it)
Will rename output .egg file from dist/google_dataproc_templates-0.5.0b0-py3.9.egg to dist/dataproc_templates_distribution.egg
JOB_TYPE is SERVERLESS, so will submit on serverless Spark
Triggering Spark Submit job
gcloud beta dataproc batches submit pyspark ./bin/../main.py --version=1.1 --project=qwiklabs-gcp-04-33309b7906a4 --region=us-west1 --jars=file:///usr/lib/spark/external/spark-avro.jar,gs://cloud-training/dataengineering/lab_assets/idegc/spark-bigquery_2.12-20221021-2134.jar --labels=job_type=dataproc_template --deps-bucket=gs://qwiklabs-gcp-04-33309b7906a4 --py-files=./bin/../dist/dataproc_templates_distribution.egg -- --template=GCSTOBIGQUERY --gcs.bigquery.input.format=avro --gcs.bigquery.input.location=gs://qwiklabs-gcp-04-33309b7906a4 --gcs.bigquery.input.inferschema=true --gcs.bigquery.output.dataset=loadavro --gcs.bigquery.output.table=campaigns --gcs.bigquery.output.mode=overwrite --gcs.bigquery.temp.bucket.name=qwiklabs-gcp-04-33309b7906a4-bqtemp
Batch [95db710eddd04ecca5f12090b2dd36aa] submitted.
Using the default container image
Waiting for container log creation
PYSPARK_PYTHON=/opt/dataproc/conda/bin/python
JAVA_HOME=/usr/lib/jvm/temurin-11-jdk-amd64
SPARK_EXTRA_CLASSPATH=
:: loading settings :: file = /etc/spark/conf/ivysettings.xml
25/03/07 14:26:54 INFO tracking: Tracked invocation: austin_311
25/03/07 14:26:54 INFO base_template: Starting Cloud Storage to BigQuery Spark job with parameters:
{'gcs.bigquery.input.chartoescapequoteescaping': '',
 'gcs.bigquery.input.columnnameofcorruptrecord': '',
 'gcs.bigquery.input.comment': '',
 'gcs.bigquery.input.dateformat': '',
 'gcs.bigquery.input.emptyvalue': '',
 'gcs.bigquery.input.encoding': '',
 'gcs.bigquery.input.enforceschema': '',
 'gcs.bigquery.input.escape': '',
 'gcs.bigquery.input.format': 'avro',
 'gcs.bigquery.input.header': 'true',
 'gcs.bigquery.input.ignoreleadingwhitespace': '',
 'gcs.bigquery.input.ignoretrailingwhitespace': '',
 'gcs.bigquery.input.inferschema': 'true',
 'gcs.bigquery.input.linesep': '',
 'gcs.bigquery.input.locale': '',
 'gcs.bigquery.input.location': 'gs://qwiklabs-gcp-04-33309b7906a4',
 'gcs.bigquery.input.maxcharspercolumn': '',
 'gcs.bigquery.input.maxcolumns': '',
 'gcs.bigquery.input.mode': '',
 'gcs.bigquery.input.multiline': '',
 'gcs.bigquery.input.nanvalue': '',
 'gcs.bigquery.input.negativeinf': '',
 'gcs.bigquery.input.nullvalue': '',
 'gcs.bigquery.input.positiveinf': '',
 'gcs.bigquery.input.quote': '',
 'gcs.bigquery.input.samplingratio': '',
 'gcs.bigquery.input.sep': '',
 'gcs.bigquery.input.timestampformat': '',
 'gcs.bigquery.input.timestampntzformat': '',
 'gcs.bigquery.input.unescapedquotehandling': '',
 'gcs.bigquery.output.dataset': 'loadavro',
 'gcs.bigquery.output.mode': 'overwrite',
 'gcs.bigquery.output.table': 'campaigns',
 'gcs.bigquery.temp.bucket.name': 'qwiklabs-gcp-04-33309b7906a4-bqtemp'}
25/03/07 14:26:57 WARN FileStreamSink: Assume no metadata directory. Error while looking for metadata directory in the path: gs://qwiklabs-gcp-04-33309b7906a4.
java.lang.IllegalArgumentException: java.net.URISyntaxException: Relative path in absolute URI: gs://qwiklabs-gcp-04-33309b7906a4_spark_metadata
        at org.apache.hadoop.fs.Path.initialize(Path.java:263)
        at org.apache.hadoop.fs.Path.<init>(Path.java:161)
        at org.apache.hadoop.fs.Path.<init>(Path.java:129)
        at org.apache.spark.sql.execution.streaming.FileStreamSink$.getMetadataLogPath(FileStreamSink.scala:72)
        at org.apache.spark.sql.execution.streaming.FileStreamSink$.hasMetadata(FileStreamSink.scala:55)
        at org.apache.spark.sql.execution.datasources.DataSource.resolveRelation(DataSource.scala:370)
        at org.apache.spark.sql.DataFrameReader.loadV1Source(DataFrameReader.scala:228)
        at org.apache.spark.sql.DataFrameReader.$anonfun$load$2(DataFrameReader.scala:210)
        at scala.Option.getOrElse(Option.scala:189)
        at org.apache.spark.sql.DataFrameReader.load(DataFrameReader.scala:210)
        at org.apache.spark.sql.DataFrameReader.load(DataFrameReader.scala:185)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
        at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
        at java.base/java.lang.reflect.Method.invoke(Method.java:566)
        at py4j.reflection.MethodInvoker.invoke(MethodInvoker.java:244)
        at py4j.reflection.ReflectionEngine.invoke(ReflectionEngine.java:357)
        at py4j.Gateway.invoke(Gateway.java:282)
        at py4j.commands.AbstractCommand.invokeMethod(AbstractCommand.java:132)
        at py4j.commands.CallCommand.execute(CallCommand.java:79)
        at py4j.ClientServerConnection.waitForCommands(ClientServerConnection.java:182)
        at py4j.ClientServerConnection.run(ClientServerConnection.java:106)
        at java.base/java.lang.Thread.run(Thread.java:829)
Caused by: java.net.URISyntaxException: Relative path in absolute URI: gs://qwiklabs-gcp-04-33309b7906a4_spark_metadata
        at java.base/java.net.URI.checkPath(URI.java:1940)
        at java.base/java.net.URI.<init>(URI.java:757)
        at org.apache.hadoop.fs.Path.initialize(Path.java:260)
        ... 22 more
25/03/07 14:27:25 INFO BigQueryClient: Submitted job LoadJobConfiguration{type=LOAD, destinationTable=GenericData{classInfo=[datasetId, projectId, tableId], {datasetId=loadavro, projectId=qwiklabs-gcp-04-33309b7906a4, tableId=campaigns}}, decimalTargetTypes=null, destinationEncryptionConfiguration=null, createDisposition=CREATE_IF_NEEDED, writeDisposition=WRITE_TRUNCATE, formatOptions=FormatOptions{format=PARQUET}, nullMarker=null, maxBadRecords=null, schema=Schema{fields=[Field{name=created_at, type=STRING, mode=NULLABLE, description=null, policyTags=null, maxLength=null, scale=null, precision=null, defaultValueExpression=null}, Field{name=period, type=INTEGER, mode=NULLABLE, description=null, policyTags=null, maxLength=null, scale=null, precision=null, defaultValueExpression=null}, Field{name=campaign_name, type=STRING, mode=NULLABLE, description=null, policyTags=null, maxLength=null, scale=null, precision=null, defaultValueExpression=null}, Field{name=amount, type=INTEGER, mode=NULLABLE, description=null, policyTags=null, maxLength=null, scale=null, precision=null, defaultValueExpression=null}, Field{name=advertising_channel, type=STRING, mode=NULLABLE, description=null, policyTags=null, maxLength=null, scale=null, precision=null, defaultValueExpression=null}, Field{name=bid_type, type=STRING, mode=NULLABLE, description=null, policyTags=null, maxLength=null, scale=null, precision=null, defaultValueExpression=null}, Field{name=id, type=INTEGER, mode=NULLABLE, description=null, policyTags=null, maxLength=null, scale=null, precision=null, defaultValueExpression=null}]}, ignoreUnknownValue=null, sourceUris=[gs://qwiklabs-gcp-04-33309b7906a4-bqtemp/.spark-bigquery-app-20250307142648-0000-f478fc4b-bc67-40b6-8d26-285dfb30f98b/part-00000-a5e11ca8-e1de-49f2-aefa-9e3131e424e5-c000.snappy.parquet], schemaUpdateOptions=null, autodetect=null, timePartitioning=null, clustering=null, useAvroLogicalTypes=null, labels=null, jobTimeoutMs=null, rangePartitioning=null, hivePartitioningOptions=null, referenceFileSchemaUri=null}. jobId: JobId{project=qwiklabs-gcp-04-33309b7906a4, job=ab850291-1ef1-4250-80fd-4945bd990d95, location=US}
25/03/07 14:27:28 INFO BigQueryClient: Done loading to qwiklabs-gcp-04-33309b7906a4.loadavro.campaigns. jobId: JobId{project=qwiklabs-gcp-04-33309b7906a4, job=ab850291-1ef1-4250-80fd-4945bd990d95, location=US}
Batch [95db710eddd04ecca5f12090b2dd36aa] finished.
metadata:
  '@type': type.googleapis.com/google.cloud.dataproc.v1.BatchOperationMetadata
  batch: projects/qwiklabs-gcp-04-33309b7906a4/locations/us-west1/batches/95db710eddd04ecca5f12090b2dd36aa
  batchUuid: 72de09d2-158a-4404-916a-8ff31862eda5
  createTime: '2025-03-07T14:24:14.798591Z'
  description: Batch
  labels:
    goog-dataproc-batch-id: 95db710eddd04ecca5f12090b2dd36aa
    goog-dataproc-batch-uuid: 72de09d2-158a-4404-916a-8ff31862eda5
    goog-dataproc-drz-resource-uuid: batch-72de09d2-158a-4404-916a-8ff31862eda5
    goog-dataproc-location: us-west1
    job_type: dataproc_template
  operationType: BATCH
name: projects/qwiklabs-gcp-04-33309b7906a4/regions/us-west1/operations/5fe81c2d-2168-31f9-a4fa-26c2708f7349

 Spark Command ran successful 
We will love to hear your feedback at: https://forms.gle/XXCJeWeCJJ9fNLQS6
Email us at: dataproc-templates-support-external@googlegroups.com
student-04-e240913b2dbe@lab-vm:~/dataproc-templates/python$ 
```


Task 4
```
Linux lab-vm 5.10.0-33-cloud-amd64 #1 SMP Debian 5.10.226-1 (2024-10-03) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Fri Mar  7 14:23:34 2025 from 35.235.248.1
student-04-e240913b2dbe@lab-vm:~$ bq query \
 --use_legacy_sql=false \
 'SELECT * FROM `loadavro.campaigns`;'
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
student-04-e240913b2dbe@lab-vm:~$ 
```
