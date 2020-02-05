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

echo "Creating resources in subscription: $subscription"
echo "Get user alias..."

echo "User alias: $user_alias"

rg=$user_alias'-spkcluster-rg'
echo "Create resource group: $rg"
#resource_group=$(az group create -l westus -n $rg)

echo "Create service principal"
#> service-principal.json
#sp=$(az ad sp create-for-rbac --scopes "/subscriptions/"$id >> service-principal.json)

dir=$(pwd)
echo "Resource group: $rg"
echo "Created service principal at $dir/service-principal.json"

# Create storage account
echo "Create storage account: $sa"
#storage=$(az storage account create -n $sa -g $rg)
#a_key=$(az storage account keys list -n $sa -g $rg | jq '.[0].value')
#container=$(az storage container create --name $sac --account-key $a_key --account-name $sa)

echo "Storage account key: $a_key"
echo "Container $sac"

# Create Deploy Key
echo ""
echo "Create deployment key"
mkdir -p cluster-deployment
mkdir -p cluster-deployment/keys
ssh-keygen -b 4096 -t rsa -f cluster-deployment/keys/gitops-ssh-key

echo ""
echo "Create node key"
ssh-keygen -b 4096 -t rsa -f cluster-deployment/keys/node-ssh-key

# Save values in a file:
> infra-values.txt
echo "Subscription id: $id" >> infra-values.txt
echo "Resource group: $rg" >> infra-values.txt
echo "Storage account: $sa" >> infra-values.txt
echo "Storage account key: $a_key" >> infra-values.txt
echo "Container: $sac" >> infra-values.txt
echo "" >> infra-values.txt
echo "Deploy key path: $dir/cluster-deployment/keys/gitops-ssh-key" >> infra-values.txt
echo "Deploy public key file: $dir/cluster-deployment/keys/gitops-ssh-key.pub" >> infra-values.txt
echo "" >> infra-values.txt
echo "Node key path: $dir/cluster-deployment/keys/node-ssh-key" >> infra-values.txt
echo "Node public key file: $dir/cluster-deployment/keys/node-ssh-key.pub" >> infra-values.txt
echo ""
echo "Saved infra values at $dir/infra-values.txt"
