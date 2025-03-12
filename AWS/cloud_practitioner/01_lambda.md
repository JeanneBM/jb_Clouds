Author Lambda Function in Python
* Navigate to Lambda.
* Click Create a function.
* Make sure the Author from scratch option at the top is selected, and then use the following settings:
  * Function name: Type myFunction.
  * Runtime: Select the latest version of Python.
* Expand Change default execution role section, and verify that Create a new role with basic Lambda permissions is selected.
* Click Create function.
* Once the function has been created, scroll down to the Code tab.
* Under Code source, select lambda_function.py.
* Replace the existing sample code with the following:
```
import json

def lambda_handler(event, context):
    message = 'Hello {} {}! Keep being awesome!'.format(event['first_name'], event['last_name'])  

    #print to CloudWatch logs
    print(message)

    return {
        'message' : message
    }
```
* Click Deploy.

Create a Test Event and Execute Lambda
* Select Test > Configure test event.
* For Event name, type myTest.
* In the Event JSON box, replace the sample code with the following:
```
{ "first_name": "Your First Name Here", "last_name": "Your Last Name Here" }
```
* Update the code to use your first and last name.
* Click Format JSON.
* Click Save.
* Click Test.
* Review the execution results that appear.

Verify that CloudWatch has Captured Function Logs
* Click the Monitor tab.
* Click View logs in CloudWatch.
* Under Log streams, click the most recent log stream.
* Review the log. You should see similar output as you did in the execution results.
