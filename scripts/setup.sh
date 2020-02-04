#!/bin/bash

[ ! -z "$SPK_VARIABLE_GROUP_NAME" ] || { echo "Provide SPK_VARIABLE_GROUP_NAME"; exit 1;}
[ ! -z "$AZDO_ORG_URL" ] || { echo "Provide AZDO_ORG_URL. Eg. https://dev.azure.com/MyOrganization/ "; exit 1;}
[ ! -z "$AZDO_PROJECT_NAME" ] || { echo "Provide AZDO_PROJECT_NAME"; exit 1;}

# The introspection setup script
# Create resource group
# Create storage account and table for introspection
# Add introspection variables to variable group

# Get alias

user_alias=$(az ad signed-in-user show | jq '.mailNickname' -r)
rg=$user_alias'-spkrg'
sa=$user_alias'spksa'
tn='spkdeployments'
pk='azure-vote'

if [ "$1" == "values" ]; then
    echo "account_name: $sa"
    echo "table_name: $tn"
    echo "partition_key: $pk"
    sa_key=$(az storage account keys list -n $sa -g $rg | jq '.[0].value')
    echo "key: $sa_key"
fi

if [ "$1" == "create" ]; then
    echo "User alias $user_alias"

    # create resource group
    echo "Create resource group: $rg"
    az group create -l westus -n $rg

    echo "Create storage account: $sa"
    az storage account create -n $sa -g $rg

    echo "Create table in storage account $sa"
    az storage table create -n $tn --account-name $sa

    sa_key=$(az storage account keys list -n $sa -g $rg | jq '.[0].value')
    echo "key: $sa_key" >> introspection-values.txt

    # Get variable group information
    echo "Get variable group id..."
    vg_result=$(az pipelines variable-group list --org $AZDO_ORG_URL -p $AZDO_PROJECT_NAME)
    vg_id=$(az pipelines variable-group list --org $AZDO_ORG_URL -p $AZDO_PROJECT_NAME | jq '.[] | select(.name=="'$SPK_VARIABLE_GROUP_NAME'") | .id')

    echo "Add variables to variable group $SPK_VARIABLE_GROUP_NAME"
    az pipelines variable-group variable create --id $vg_id --org $AZDO_ORG_URL -p $AZDO_PROJECT_NAME --name INTROSPECTION_ACCOUNT_KEY --value $sa_key --secret
    az pipelines variable-group variable create --id $vg_id --org $AZDO_ORG_URL -p $AZDO_PROJECT_NAME --name INTROSPECTION_ACCOUNT_NAME --value $sa
    az pipelines variable-group variable create --id $vg_id --org $AZDO_ORG_URL -p $AZDO_PROJECT_NAME --name INTROSPECTION_PARTITION_KEY --value $pk
    az pipelines variable-group variable create --id $vg_id --org $AZDO_ORG_URL -p $AZDO_PROJECT_NAME --name INTROSPECTION_TABLE_NAME --value $tn
fi

