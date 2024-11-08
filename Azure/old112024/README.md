https://azure.microsoft.com/pl-pl/free/#all-free-services

https://azure.microsoft.com/en-us/get-started/on-demand/?OCID=AZ_ODD_RM 

---------------

```
az vm create --resource-group "[resource group name]" --name my-vm --public-ip-sku Standard --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys
```

```
az vm extension set --resource-group "[resource group name]" --vm-name my-vm --name customScript --publisher Microsoft.Azure.Extensions --version 2.1 --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```
---------------

az vm list

IPADDRESS="$(az vm list-ip-addresses --resource-group "[resource group name]" --name my-vm --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" --output tsv)"

az network nsg list --resource-group "[resource group name]" --query '[].name' --output tsv

az network nsg rule list --resource-group "[resource group name]" --nsg-name my-vmNSG

az network nsg rule list --resource-group "[resource group name]" --nsg-name my-vmNSG --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' --output table

az network nsg rule create --resource-group "[resource group name]" --nsg-name my-vmNSG --name allow-http --protocol tcp --priority 100 --destination-port-range 80 --access Allow

az network nsg rule list --resource-group "[resource group name]" --nsg-name my-vmNSG --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' --output table

---------------

