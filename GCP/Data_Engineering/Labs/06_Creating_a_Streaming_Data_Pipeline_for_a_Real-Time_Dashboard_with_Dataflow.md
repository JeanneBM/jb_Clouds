Task 1. Create a BigQuery dataset
* In this task, you create the taxirides dataset. You have two different options which you can use to create this, using the Google Cloud Shell or the Google Cloud Console.
* In this lab you will be using an extract of the NYC Taxi & Limousine Commission’s open dataset. A small, comma-separated, datafile will be used to simulate periodic updates of taxi data.
* BigQuery is a serverless data warehouse. Tables in BigQuery are organized into datasets. In this lab, taxi data will flow from the standalone file via Dataflow to be stored in BigQuery. With this configuration, any new datafile deposited into the source Cloud Storage bucket would automatically be processed for loading.
* Use one of the following options to create a new BigQuery dataset:

Option 1: The command-line tool
* In Cloud Shell (Cloud Shell icon), run the following command to create the taxirides dataset.
```
bq --location=us-central1 mk taxirides
```
* Run this command to create the taxirides.realtime table (empty schema that you will stream into later).
```
bq --location=us-central1 mk \
--time_partitioning_field timestamp \
--schema ride_id:string,point_idx:integer,latitude:float,longitude:float,\
timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,\
passenger_count:integer -t taxirides.realtime
```
Option 2: The BigQuery Console UI

Note: Skip these steps if you created the tables using the command line.
* In the Google Cloud console, in the Navigation menu(Navigation Menu), click BigQuery.
* If you see the Welcome dialog, click Done.
* Click on View actions (View Actions) next to your Project ID, and then click Create dataset.
* In Dataset ID, type taxirides.
* In Data location, select:
```
us-central1
```
* then click Create Dataset.
* In the Explorer pane, click expand node (Expander) to reveal the new taxirides dataset.
* Click on View actions (View Actions) next to the taxirides dataset, and then click Open.
* Click Create Table.
* In Table, type realtime
* For the schema, click Edit as text and paste in the following:
```
ride_id:string,
point_idx:integer,
latitude:float,
longitude:float,
timestamp:timestamp,
meter_reading:float,
meter_increment:float,
ride_status:string,
passenger_count:integer
```
* In Partition and cluster settings, select timestamp.
* Click Create Table.

Task 2. Copy required lab artifacts
* In this task, you move the required files to your Project.
* Cloud Storage allows world-wide storage and retrieval of any amount of data at any time. You can use Cloud Storage for a range of scenarios including serving website content, storing data for archival and disaster recovery, or distributing large data objects to users via direct download.
* A Cloud Storage bucket was created for you during lab start up.
* In Cloud Shell (Cloud Shell icon), run the following commands to move files needed for the Dataflow job.
```
gcloud storage cp gs://cloud-training/bdml/taxisrcdata/schema.json  gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/schema.json
gcloud storage cp gs://cloud-training/bdml/taxisrcdata/transform.js  gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/transform.js
gcloud storage cp gs://cloud-training/bdml/taxisrcdata/rt_taxidata.csv  gs://qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/rt_taxidata.csv
```
Task 3. Set up a Dataflow Pipeline
* In this task, you set up a streaming data pipeline to read files from your Cloud Storage bucket and write data to BigQuery.
* Dataflow is a serverless way to carry out data analysis.
* Restart the connection to the Dataflow API.
* In the Cloud Shell, run the following commands to ensure that the Dataflow API is enabled cleanly in your project.
```
gcloud services disable dataflow.googleapis.com
gcloud services enable dataflow.googleapis.com
```
* Create a new streaming pipeline:
* In the Cloud console, in the Navigation menu (Navigation Menu), click View all Products > Analytics > Dataflow.
* In the top menu bar, click Create Job From Template.
* Type streaming-taxi-pipeline as the Job name for your Dataflow job.
* In Regional endpoint, select
```
us-central1
```
* In Dataflow template, select the Cloud Storage Text to Bigquery (Stream) template under Process Data Continuously (stream).
Note: Make sure to select the template option which matches with the parameters listed below.
* In Cloud Storage Input File(s), paste or type:
```
qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/rt_taxidata.csv
```
* In Cloud Storage location of your BigQuery schema file, described as a JSON, paste or type:
```
qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/schema.json
```
* In BigQuery Output table, paste or type:
```
qwiklabs-gcp-03-2ce0b304e9a4:taxirides.realtime
```
* In Temporary directory for BigQuery loading process, paste or type:
```
qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp
```
* Click Required Parameters.
* In Temporary location, used for writing temporary files, paste or type:
```
qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp
```
* In JavaScript UDF path in Cloud Storage, paste or type:
```
qwiklabs-gcp-03-2ce0b304e9a4-bucket/tmp/transform.js
```
* In JavaScript UDF name, paste or type:
```
transform
```
* In Max workers, type 2
* In Number of workers, type 1
* Uncheck Use default machine type.
* Under General purpose, choose the following:
* Series: E2
* Machine type: e2-medium (2 vCPU, 4 GB memory)
* Click Run Job.
* Dataflow Template
* A new streaming job has started! You can now see a visual representation of the data pipeline. It will take 3 to 5 minutes for data to begin moving into BigQuery.

Note: If the dataflow job fails for the first time then re-create a new job template with new job name and run the job.

Task 4. Analyze the taxi data using BigQuery
* In this task, you analyze the data as it is streaming.
* In the Cloud console, in the Navigation menu (Navigation Menu), click BigQuery.
* If the Welcome dialog appears, click Done.
* In the Query Editor, type the following, and then click Run:
```
SELECT * FROM taxirides.realtime LIMIT 10
```
Note: If no records are returned, wait another minute and re-run the above query (Dataflow takes 3-5 minutes to setup the stream).
* Your output will look similar to the following: Sample BigQuery output from query

Task 5. Perform aggregations on the stream for reporting
* In this task, you calculate aggregations on the stream for reporting.
* In the Query Editor, clear the current query.
* Copy and paste the following query, and then click Run.
```
WITH streaming_data AS (

SELECT
  timestamp,
  TIMESTAMP_TRUNC(timestamp, HOUR, 'UTC') AS hour,
  TIMESTAMP_TRUNC(timestamp, MINUTE, 'UTC') AS minute,
  TIMESTAMP_TRUNC(timestamp, SECOND, 'UTC') AS second,
  ride_id,
  latitude,
  longitude,
  meter_reading,
  ride_status,
  passenger_count
FROM
  taxirides.realtime
ORDER BY timestamp DESC
LIMIT 1000

)

# calculate aggregations on stream for reporting:
SELECT
 ROW_NUMBER() OVER() AS dashboard_sort,
 minute,
 COUNT(DISTINCT ride_id) AS total_rides,
 SUM(meter_reading) AS total_revenue,
 SUM(passenger_count) AS total_passengers
FROM streaming_data
GROUP BY minute, timestamp
```
Note: Ensure Dataflow is registering data in BigQuery before proceeding to the next task.
* The result shows key metrics by the minute for every taxi drop-off.
* Click Save > Save query.
* In the Save query dialog, in the Name field, type My Saved Query.
* In Region, ensure that the region matches the Qwiklabs Lab Region.
* Click Save.

Task 6. Stop the Dataflow Job
* In this task, you stop the Dataflow job to free up resources for your project.
* In the Cloud console, in the Navigation menu (Navigation Menu), click View all Products > Analytics > Dataflow.
* Click the streaming-taxi-pipeline, or the new job name.
* Click Stop, and then select Cancel > Stop Job.

Task 7. Create a real-time dashboard
* In this task, you create a real-time dashboard to visualize the data.
* In the Cloud console, in the Navigation menu (Navigation Menu), click BigQuery.
* In the Explorer Pane, expand your Project ID.
* Expand Queries, and then click My Saved Query.
* Your query is loaded in to the query editor.
* Click Run.
* In the Query results section, click Open in > Looker Studio.
* Looker Studio Opens. Click Get started.
* In the Looker Studio window, click your bar chart.
* (Bar Chart
* The Chart pane appears.
* Click Add a chart, and then select Combo chart.
* Combo chart
* In the Setup pane, in Data Range Dimension, hover over minute (Date) and click X to remove it.
* In the Data pane, click dashboard_sort and drag it to Setup > Data Range Dimension > Add dimension.
* In Setup > Dimension, click minute, and then select dashboard_sort.
* In Setup > Metric, click dashboard_sort, and then select total_rides.
* In Setup > Metric, click Record Count, and then select total_passengers.
* In Setup > Metric, click Add metric, and then select total_revenue.
* In Setup > Sort, click total_rides, and then select dashboard_sort.

In Setup > Sort, click Ascending.

Your chart should look similar to this:

Sample chart

Note: Visualizing data at a minute-level granularity is currently not supported in Looker Studio as a timestamp. This is why we created our own dashboard_sort dimension.
When you're happy with your dashboard, click Save and share to save this data source.

If prompted to complete your account setup, type your country and company details, agree to the terms and conditions, and then click Continue.

If prompted which updates you want to receive, answer no to all, then click Continue.

If prompted with the Review data access before saving window, click Acknowledge and save.

If prompted to choose an account select your Student Account.

Whenever anyone visits your dashboard, it will be up-to-date with the latest transactions. You can try it yourself by clicking More options (More Options), and then Refresh data.

Task 8. Create a time series dashboard
In this task, you create a time series chart.

Click this Looker Studio link to open Looker Studio in a new browser tab.

On the Reports page, in the Start with a Template section, click the [+] Blank Report template.

A new, empty report opens with the Add data to report window.

From the list of Google Connectors, select the BigQuery tile.

Click Custom Query, and then select your ProjectID. This should appear in the following format, qwiklabs-gcp-xxxxxxx.

In Enter Custom Query, paste the following query:

SELECT
  *
FROM
  taxirides.realtime
WHERE
  ride_status='enroute'
Copied!
Click Add > Add To Report.

A new untitled report appears. It may take up to a minute for the screen to finish refreshing.

Create a time series chart
In the Data pane, click Add a Field > Add calculated field.

Click All Fields on the left corner.

Change the timestamp field type to Date & Time > Date Hour Minute (YYYYMMDDhhmm).

In the change timestamp dialog, click Continue, and then click Done.

In the top menu, click Add a chart.

Choose Time series chart.

Time Series

Position the chart in the bottom left corner - in the blank space.

In Setup > Dimension, click timestamp (Date), and then select timestamp.

In Setup > Dimension, click timestamp, and then select calendar. Calendar

In Data Type, select Date & Time > Date Hour Minute.

Click outside the dialog to close it. You do not need to add a name.

In Setup > Metric, click Record Count, and then select meter reading.
