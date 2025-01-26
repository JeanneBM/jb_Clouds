az login; az group list --query [].name; az storage account list --query [].name; az account show

variable group in the Pipelines Library:
BACKEND_RESOURCE_GROUP_NAME - Resource group name
BACKEND_AZURE_STORAGE_ACCOUNT_NAME - Storage account name
BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME - tfstate
BACKEND_AZURE_STORAGE_ACCOUNT_KEY_NAME - terraform.tfstate
BACKEND_TENANT_ID - Tenant ID
BACKEND_CLIENT_ID - Application Client ID from the service principal
BACKEND_CLIENT_SECRET - Secret from the service principal
BACKEND_SUBSCRIPTION_ID - Subscription ID

Enter the following values:
Subscription ID - from previous objective
Subscription Name - from previous objective
Service Principal Id - Application Client ID from the service principal
Service Principal Key - Secret from the service principal
Tenant ID - from previous objective
Service connection name: tacowagon-dev
*box to grant access permission to all pipelines

Verify+Save

Azure DevOps->Pipelines->Create pipeline->Azure Repos Git->the repository->Starter pipeline-name the file to pr->plan.yml->contents[pool section]->main branch->All pipelines->Rename/move->Rename to pr-plan
Azure DevOps->Pipelines->Create pipeline->Azure Repos Git->the repository->Starter pipeline-name the file to merge-apply.yml->contents[pool section]->main branch->All pipelines->Rename/move->Rename to merge-apply

Pipelines Library->variable group->Pipeline permissions->+the pr-plan+merge-apply
Repos->Branches->...->Branch policies->+Build Validation->defaults->Save
Repos->Branches->New->+branch "first-deploy"->New->terraform.tfvars->Edit->RESOURCE_GROUP_NAME->Commit to the first-deploy branch->+Pull request->defaults->Create->Merge->Verify->Complete

Self-hosted Agent in Azure

Copy the Terraform configuration from local workstation
Create a Personal Access Token in your Azure DevOps account with Full Access permissions

terraform.tfvars:
====================
resource_group_name - the resource group
azp_token - PAT created
azp_org_name - organization name

terraform init; terraform apply -auto-approve

# Before
pool:
  vmImage: ubuntu-latest
# After
pool: aci-agents
