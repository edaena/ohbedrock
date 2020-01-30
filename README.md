# OH Bedrock
Hacking the Azure voting app on Bedrock.

### Docker images
#### DockerHub:
- [edsa14/azure-vote-front:v1](https://hub.docker.com/repository/docker/edsa14/azure-vote-front)
- [edsa14/redis:v1](https://hub.docker.com/repository/docker/edsa14/redis)

#### ACR:
- edaenaacr.azurecr.io/oh/azure-vote-front:v1
- edaenaacr.azurecr.io/oh/redis:v1


## Repos
These are the repositories relevant for a bedrock workflow using the Azure voting app.

#### Helm Chart: Azure Voting App
By default the chart uses the ACR docker images, as it can be seen [here](https://github.com/edaena/helm-charts/blob/da7a3eb19cdc1d661bc0ff3b1eb88c64fd7e9f08/chart-source/azure-vote/values.yaml#L10).

Location: [edaena/helm-charts/azure-vote](https://github.com/edaena/helm-charts/tree/master/chart-source/azure-vote)


#### Fabrikate Component: Azure Voting App
This is the Fabrikate definition that refers to the Helm Chart for the voting app.

Location: [edaena/azure-vote-hld](https://github.com/edaena/azure-vote-hld)

#### Generated Manifest: Azure Voting App
This is a pre-generated manifest for the voting app. It is ready to be deployed to a Kubernetes cluster as-is. It uses the DockerHub images `edsa14/azure-vote-front:v1` and `edsa14/redis:v1`.

Location: [edaena/azure-voting-app-manifest](https://github.com/edaena/azure-voting-app-manifest)

## Setup Bedrock Pipelines using SPK
This section is a work in progress and it follows the steps from the Bedrock [guideline](https://github.com/CatalystCode/spk/blob/master/docs/project-service-management-guide.md#initializing-the-high-level-definition-repository) to manage a project using `spk`.

These are the steps that have been tested so far:
- Create an Azure project in Azure DevOps called `ohbedrock`
- Create three repositories in the `ohbedrock` project: `ohhld`, `ohmanifests`, `ohinfra`
- Create a PAT with access to: Build (read & execute), Code (read, write, manage), Variable Groups (read, create, manage)
- Pre-populate the `azure-devops` section of the `spk-config.yaml`. See [this](https://github.com/CatalystCode/spk/blob/master/spk-config.yaml) template.
- run `spk init -f spk-config.yaml`
- Clone the repos: `ohhld` and `ohmanifests`
- `cd ohhld`
- `spk hld init`
- Change the `component.yaml` to use the Azure Voting App fabrikate component instead of the cloud native stack:
```
name: default-component
subcomponents:
  - name: azure-vote
    method: git
    source: 'https://github.com/edaena/azure-vote-hld.git'
```
- Commit all the files to the `ohhld` repo
- `spk hld install-manifest-pipeline`
- Successfully installed pipeline in the `ohbedrock` project
- Verified that the pipeline automatically generated the manifests and committed them to the `ohmanifests` repository


To be continued:
- onboard the azure voting service
- generate the pipeline to go from service to docker image
