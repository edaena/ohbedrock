# ohbedrock
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
This is the Fabrikate definition that refers to the Helm Chart for the Azure Voting App.

Location: [edaena/azure-vote-hld](https://github.com/edaena/azure-vote-hld)

#### Generated Manifest: Azure Voting App
This is a pre-generated manifest to deploy the Azure Voting App on Kubernetes. It uses the DockerHub images `edsa14/azure-vote-front:v1` and `edsa14/redis:v1`.

Location: [edaena/azure-voting-app-manifest](https://github.com/edaena/azure-voting-app-manifest)

