Task 1: Deploy GKE Clusters
Access Google Cloud Console:

Open your web browser and navigate to the Google Cloud Console.

Sign in with your Google Cloud account.

Navigate to Kubernetes Engine:

On the left-hand Navigation menu, click Kubernetes Engine > Clusters.

Create a GKE Cluster:

Click the Create button to begin creating a new GKE cluster.

Configure Cluster Settings:

In the Cluster basics section:

Set the Cluster name to autopilot-cluster-1.

Set the Location type to Region and choose us-east1 as the region.

Leave all other settings at their defaults (e.g., Kubernetes version, node pool configuration).

Review and Create:

Scroll down and review the configuration.

Click Create to start provisioning the cluster.

Wait for Cluster Provisioning:

The cluster will take a few minutes to provision. You can monitor the progress on the Clusters page.

Verify Cluster Creation:

Once the cluster is ready, you’ll see autopilot-cluster-1 listed on the Clusters page.

Click on the cluster name (autopilot-cluster-1) to view its details.

Explore Cluster Details:

Scroll down to view additional details about the cluster.

Click the Storage tab to view storage-related configurations.

Task 2: Deploy a Sample Workload
Navigate to Workloads:

On the left-hand Navigation menu, click Kubernetes Engine > Workloads.

Create a Deployment:

Click Create deployment.

Configure Deployment:

In the Deployment name field, enter nginx-1.

For the container image, accept the default nginx:latest.

Leave all other settings at their defaults.

Deploy the Workload:

Click Deploy to create the deployment.

Verify Deployment:

Once the deployment is complete, the screen will refresh to show the details of the nginx-1 workload.

Task 3: View Details About Workloads
Navigate to Workloads:

On the left-hand Navigation menu, click Kubernetes Engine > Workloads.

View Workload Details:

Click on the nginx-1 workload to view its details.

Explore Tabs:

Overview Tab: View resource utilization charts, Pod details, and links to logs.

Details Tab: View Pod specifications, replica status, and autoscaler details.

Revision History Tab: View revisions made to the workload.

Events Tab: View events associated with the workload.

YAML Tab: View the complete YAML file defining the workload.

View Pod Details:

Scroll down to the Managed Pods section in the Overview tab.

Click on the name of one of the Pods to view its details.

Explore Pod Details:

Overview Tab: View Pod configuration and resource utilization.

Events Tab: View events related to the Pod.

Logs Tab: Access container logs in Cloud Operations.

YAML Tab: View the detailed YAML file for the Pod configuration.


