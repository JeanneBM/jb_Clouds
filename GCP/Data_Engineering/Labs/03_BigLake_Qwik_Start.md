Task 1. Create a connection resource
* BigLake tables access Google Cloud Storage data using a connection resource. A connection resource can be associated with a single table or an arbitrary group of tables in the project.
* From the Navigation Menu, go to BigQuery > BigQuery Studio. Click Done.
* To create a connection, click +ADD, and then click Connections to external data sources.

Note: If you are prompted to enable the BigQuery Connection API click Enable API.
* In the Connection type list, select Vertex AI remote models, remote functions and BigLake (Cloud Resource).
    - add external data source
* In the Connection ID field, enter my-connection.
* For Location type, choose Multi-region and select US (multiple regions in United States) from dropdown.
* Click Create connection.
* To view your connection information, select the connection in the navigation menu.
    - my connection explorer
* In the Connection info section, copy the Service Account ID. You will need this in the following section.
* Click Check my progress to verify the objective.
* Create the connection resource

Task 2. Set up access to a Cloud Storage data lake
* In this section, you will give the new connection resource read-only access to the Cloud Storage data lake so that BigQuery can access Cloud Storage files on behalf of users. We recommend that you grant the connection resource service account the Storage Object Viewer IAM role, which lets the service account access Cloud Storage buckets.
* From the Navigation Menu, go to IAM & Admin > IAM.
* Click +GRANT ACCESS.
* In the New principals field, enter the service account ID that you copied earlier.
* In the Select a role field, select Cloud Storage, and then select Storage Object Viewer.
    - add principals dialogue box
* Click Save.
Note: After you migrate users to BigLake tables, remove direct Cloud Storage permissions from existing users. Direct file access allows users to bypass governance policies (such as row- and column-level security) set on BigLake tables.
* Click Check my progress to verify the objective.
* Set up access to a Cloud Storage data lake

Task 3. Create a BigLake table
* The following example uses the CSV file format, but you can use any format supported by BigLake, as shown in Limitations. If you're familiar with creating tables in BigQuery, then this process should be similar. The only difference is that you specify the associated cloud resource connection.
Note: For optimal performance, we recommend using Cloud Storage single-region or dual-region buckets and not multi-region buckets.
* If no schema was provided and the service account was not granted access to the bucket in the previous step, this step will fail with an access denied message.
* Create a dataset
  - Navigate back to BigQuery > BigQuery Studio.
  - Click the three dots next to your project name and select Create dataset.
  - create dataset
  - For the Dataset ID, use demo_dataset.
  - For Location type, choose Multi-region and select US (multiple regions in United States) from dropdown.
  - Leave the rest of the fields as default and click Create Dataset.
* Now that you have a dataset created, you can copy an existing dataset from Cloud Storage into BigQuery.
* Create the table
    - Click three dots next to demo_dataset, then choose Create table.
    - create-table-1
    - Under Source for Create table from, choose Google Cloud Storage.
Note: A Cloud Storage bucket has been created with two datasets that you will use in this lab.
    - Click Browse to select the dataset. Navigate to the bucket named as qwiklabs-gcp-04-74c117999f1e and then customer.csv file to import it into BigQuery, and click Select.
    - Under Destination, verify your lab project has been selected and you're using the demo_dataset.
    - For the table name, use biglake_table.
    - Set the table type to External Table.
    - Select the box to Create a BigLake table using a Cloud Resource connection.
    - Verify that your connection ID us.my-connection is selected. Your configuration should resemble the following:
    - destination table
    - Under Schema, enable Edit as text and copy and paste the following schema into the text box:
```
[
{
    "name": "customer_id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "first_name",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "last_name",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "company",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "address",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "city",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "country",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "postal_code",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "phone",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "fax",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "email",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "support_rep_id",
    "type": "INTEGER",
    "mode": "NULLABLE"
  }
]
```

Note: Typically data lakes do not have a predefined schema. For this lab's purposes, we are using one to make setting column-level policies clearer.
* Click Create Table.
* Click Check my progress to verify the objective.
* Create the BigLake table

Task 4. Query a BigLake table through BigQuery
* Now that you've created the BigLake table, you can use any BigQuery client to submit a query.
* From the biglake_table preview toolbar, click Query > In new tab.
* Run the following to query the BigLake table through the BigQuery Editor:
```
SELECT * FROM `qwiklabs-gcp-04-74c117999f1e.demo_dataset.biglake_table`
```
* Click Run.
* Verify you can see all of the columns and data in the resulting table.

Task 5. Set up access control policies
* Once a BigLake table has been created, it can be managed in a similar fashion to BigQuery tables. To create access control policies for BigLake tables, you'll first create a taxonomy of policy tags in BigQuery. Then, apply the policy tags to the sensitive rows or columns. In this section, you will create a column level policy. For directions on setting up row-level security, see the row-level security guide.
* For these purposes, a BigQuery taxonomy named biglake-taxonomy-1r94a and an associated policy tag named biglake-policy has been created for you.
* Add policy tags to columns
* You will now use the policy tag you created to restrict access to certain columns within the BigQuery table. For this example, you will restrict access to sensitive information such as address, postal code, and phone number.
* From the Navigation Menu, go to BigQuery > BigQuery Studio.
* Navigate to demo-dataset > biglake_table and click the table to open the table schema page.
* Click Edit Schema.
* Check the boxes next to the address, postal_code, and phone fields.
  - highlight schema columns
* Click Add policy tag.
* Click biglake-taxonomy-1r94a to expand it to select biglake-policy.
  - add policy tag to columns
* Click Select.
* Your columns should now have the policy tags attached to them.
    - attached policy tags
* Click Save.
* Verify your table schema now resembles the following.

    - table schema updated

Note: The warning signs on the columns signal you don't have access to those particular fields based on the security policies in place.
* Verify the column level security
* Open the query editor for the biglake_table.
* Run the following to query the BigLake table through the BigQuery Editor:
```
SELECT * FROM `qwiklabs-gcp-04-74c117999f1e.demo_dataset.biglake_table`
```
* Click Run.
* You should receive an error access denied error:
  - access denied error
* Now, run the following query, omitting the columns you don't have access to:
```
SELECT *  EXCEPT(address, phone, postal_code)
FROM `qwiklabs-gcp-04-74c117999f1e.demo_dataset.biglake_table`
```
* The query should run without any issues and return the columns you have access to. This example shows that column level security enforced through BigQuery can also be applied to BigLake tables.

Task 6. Upgrade external tables to BigLake tables
* You can upgrade existing tables to BigLake tables by associating the existing table to a cloud resource connection. For a complete list of flags and arguments, see bq update and bq mkdef.
* Create the external table
* Click three dots next to demo_dataset, then choose Create table.
    - Under Source for Create table from, choose Google Cloud Storage.
    - Click Browse to select the dataset. Navigate to the bucket named qwiklabs-gcp-04-74c117999f1e and then invoice.csv file to import it into BigQuery, and click Select.
    - Under Destination, verify your lab project has been selected and you're using the demo_dataset.
    - For the table name, use external_table.
    - Set the table type to External Table.

Note: Do not specify a Cloud Resource connection yet.
    - Under Schema, enable Edit as text and copy and paste the following schema into the text box:
```
[
{
    "name": "invoice_id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "customer_id",
    "type": "INTEGER",
    "mode": "REQUIRED"
  },
  {
    "name": "invoice_date",
    "type": "TIMESTAMP",
    "mode": "REQUIRED"
  },
  {
    "name": "billing_address",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "billing_city",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "billing_state",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "billing_country",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "billing_postal_code",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "total",
    "type": "NUMERIC",
    "mode": "REQUIRED"
  }
]
```
* Click Create Table.
* Click Check my progress to verify the objective.
* Create the external table
* Update external table to Biglake table
* Open a new Cloud Shell window and run the following command to generate a new external table definition that specifies the connection to use:
```
export PROJECT_ID=$(gcloud config get-value project)
bq mkdef \
--autodetect \
--connection_id=$PROJECT_ID.US.my-connection \
--source_format=CSV \
"gs://$PROJECT_ID/invoice.csv" > /tmp/tabledef.json
```
* Verify your table definition has been created:
```
cat /tmp/tabledef.json
```
Get the schema from your table:
bq show --schema --format=prettyjson  demo_dataset.external_table > /tmp/schema
Copied!
Update the table using the new external table definition:
bq update --external_table_definition=/tmp/tabledef.json --schema=/tmp/schema demo_dataset.external_table
Copied!
Click Check my progress to verify the objective.
Please update external table to Biglake table.
Update external table to Biglake table

Please update external table to Biglake table.

Verify the updated table
From the Navigation Menu, go to BigQuery > BigQuery Studio.

Navigate to demo-dataset > and double click external_table.

Open the Details tab.

Verify under External Data Configuration that the table is now using the proper Connection ID.

external data configuration

Great! You successfully upgraded the existing external table to a BigLake table by associating it to a cloud resource connection.
