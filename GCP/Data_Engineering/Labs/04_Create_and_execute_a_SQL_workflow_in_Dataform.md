Task 1. Create a Dataform repository
* In the Console, expand the Navigation menu, then select BigQuery > Dataform.
* Click CREATE REPOSITORY.
* On the Create repository page, do the following:
  - In the Repository ID field, enter quickstart-repository.
  - In the Region list, select us-east4.
* Click CREATE.
* Once the repository is created, you will see the Dataform service account. Please copy this down, so you can use it later to assign necessary permissions.
* Click Go to Repositories.
Note: If you get permission denied error related to API request wait for few minutes and create the repository again.

* Click Check my progress to verify the objective.
* Create a Dataform repository.

Task 2. Create and initialize a Dataform development workspace
* On the Dataform page, click on the quickstart-repository repository you just created.
* Click CREATE DEVELOPMENT WORKSPACE.
* In the Create development workspace window, do the following:
* In the Workspace ID field, enter quickstart-workspace.
* Click CREATE.
* Once created, click on the quickstart-workspace development workspace.
* Click INITIALIZE WORKSPACE.
* Create a Dataform workspace.

Task 3. Create a SQLX file for defining a view
* In this section, you define a view that you will later use as a data source for a table.
* In the Files pane, next to definitions, click the More menu.
* Click Create file.
* In the Create new file pane, do the following:
* In the Add a file path field, enter definitions/quickstart-source.sqlx.
* Click CREATE FILE.
* Define a view
* In the Files pane, expand the definitions folder.
* Click quickstart-source.sqlx.
* In the file, enter the following code snippet:
```
config {
  type: "view"
}

SELECT
  "apples" AS fruit,
  2 AS count
UNION ALL
SELECT
  "oranges" AS fruit,
  5 AS count
UNION ALL
SELECT
  "pears" AS fruit,
  1 AS count
UNION ALL
SELECT
  "bananas" AS fruit,
  0 AS count
```
Task 4. Create a SQLX file for table definition
* In the following sections, you define the table type in a SQLX file, and then write a SELECT statement to define the table structure within the same file.
* In the Files pane, next to definitions, click the More menu, and then select Create file.
* In the Add a file path field, enter definitions/quickstart-table.sqlx.
* Click CREATE FILE.
* Define the table type, structure and dependencies
* In the Files pane, expand the definitions directory.
* Select quickstart-table.sqlx, and then enter the following table type and SELECT statement:
```
config {
  type: "table"
}

SELECT
  fruit,
  SUM(count) as count
FROM ${ref("quickstart-source")}
GROUP BY 1
```
Note: You might notice an error note in the compiled queries section. Ignore the message and proceed to further steps to execute the workflow.

Task 5. Grant Dataform access to BigQuery
* In the Google Cloud console, on the Navigation menu (Navigation menu icon), select IAM & Admin > IAM.
* Click VIEW BY PRINCIPALS. Next, click GRANT ACCESS
* In the New principals field, enter your Dataform service account ID.
* In the Select a role drop-down list, select the BigQuery Job User role.
* Click Add another role, and then in the Select a role drop-down list, select the BigQuery Data Editor role.
* Click Add another role, and then in the Select a role drop-down list, select the BigQuery Data Viewer role.
* Click Save.
* Grant Dataform access to BigQuery.

Task 6. Execute the workflow
* In the Console, go to Navigation Menu > BigQuery > Dataform.
* Click on quickstart-repository to open the repository.
* Click on quickstart-workspace to open the development workspace.
* On the quickstart-workspace page, click START EXECUTION.
* Click Execute actions.
* Click All actions tab.
* In the Execute pane, click START EXECUTION.
* Dataform uses the default repository settings to create the contents of your workflow in a BigQuery dataset called dataform.
* Create and execute the SQL workflow.
* View execution logs
* On the quickstart-workspace page, click EXECUTIONS to open the Executions pane.
* To view details of your execution, click the latest execution.
