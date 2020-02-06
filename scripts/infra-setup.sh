#!/bin/bash

echo "**************************"
echo "Bedrock OpenHack"
echo "Infra prerequisites setup"
echo "**************************"
echo ""

subscription=$(az account show | jq '.name' -r)
id=$(az account show | jq '.id' -r)
user_alias=$(az ad signed-in-user show | jq '.mailNickname' -r)

sa=$user_alias'spkinfrasa'
sac='infracontainer'
cluster_name=$user_alias'-spk-cluster'

echo "Creating resources in subscription: $subscription"
echo "Get user alias..."

echo "User alias: $user_alias"

rgi=$user_alias'-spkinfra-rg'
rg=$user_alias'-spkcluster-rg'
echo "Create resource group: $rg"
resource_group=$(az group create -l westus -n $rg)

echo "Create resource group: $rgi"
resource_group=$(az group create -l westus -n $rgi)

echo "Create service principal"
> service-principal.json
sp=$(az ad sp create-for-rbac --scopes "/subscriptions/"$id >> service-principal.json)

dir=$(pwd)
echo "Created service principal at $dir/service-principal.json"

# Create storage account
echo "Create storage account: $sa"
storage=$(az storage account create -n $sa -g $rg)
a_key=$(az storage account keys list -n $sa -g $rg | jq '.[0].value')
container=$(az storage container create --name $sac --account-key $a_key --account-name $sa)

echo "Storage account key: $a_key"
echo "Container $sac"

# Create Deploy Key
echo ""
echo "Create deployment key"
mkdir -p deployment
mkdir -p deployment/keys
ssh-keygen -b 4096 -t rsa -f deployment/keys/gitops-ssh-key

echo ""
echo "Create node key"
ssh-keygen -b 4096 -t rsa -f deployment/keys/node-ssh-key

# Save values in a file:
> infra-values.txt
echo "Subscription id: $id" >> infra-values.txt
echo "ARM_SUBSCRIPTION_ID: $id" >> infra-values.txt

echo "" >> infra-values.txt
echo "cluster_name: $cluster_name" >> infra-values.txt
echo "dns_prefix: $cluster_name" >> infra-values.txt

echo "" >> infra-values.txt
echo "resource_group_name: $rg" >> infra-values.txt
echo "global_resource_group_name (common infra): $rgi" >> infra-values.txt

echo "" >> infra-values.txt
echo "keyvault_name: $user_alias""spkkv" >> infra-values.txt
echo "subnet_name: $rgi-spk-mysubnet" >> infra-values.txt
echo "vnet_name: $rgi-spk-vnet" >> infra-values.txt
echo "keyvault_resource_group: $rgi" >> infra-values.txt

echo "" >> infra-values.txt
echo "storage_account_name: $sa" >> infra-values.txt
echo "access_key (for storage account): $a_key" >> infra-values.txt
echo "container_name: $sac" >> infra-values.txt

echo "" >> infra-values.txt
echo "gitops_ssh_key: $dir/deployment/keys/gitops-ssh-key" >> infra-values.txt
#echo "gitops_path: $dir/deployment/keys/gitops-ssh-key" >> infra-values.txt

echo "" >> infra-values.txt
echo "Deploy key path: $dir/deployment/keys/gitops-ssh-key" >> infra-values.txt
echo "Deploy public key file: $dir/deployment/keys/gitops-ssh-key.pub" >> infra-values.txt

echo "" >> infra-values.txt
echo "Node key path: $dir/deployment/keys/node-ssh-key" >> infra-values.txt
echo "Node public key file: $dir/deployment/keys/node-ssh-key.pub" >> infra-values.txt
echo ""
echo "Saved infra values at $dir/infra-values.txt"
