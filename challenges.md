
The following challenges are part of a workflow to understand and deploy an application on Kubernetes using a Bedrock workflow. In this case, we will deploy the [Azure voting app](https://github.com/Azure-Samples/azure-voting-app-redis).

![voting app](./images/azure-vote.png)

To-do: include overall diagram of the system

### Challenge 0: Setup Tools/Artifacts
Objective: Setup for the hack project

Steps:
1. Download and setup the required tools. Follow [these steps](https://github.com/edaena/bedrock-wsl).
2. Create an Azure DevOps project called `voting-app-project`
3. Inside the `voting-app-project` create three repositories: `voting-app`, `voting-hld`, `voting-manifest`
4. In Azure DevOps, generate a Personal Access Token(PAT) with this permissions:
- Build (Read & execute)
- Code (Read, write, & manage)
- Variable Groups (Read, create, & manage)

For help setting up the PAT, see 
[guide](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=preview-page).

To-do: include diagram of artifacts (repos)

### Challenge 1: GitOps and AKS
Objective: Understand GitOps

Goals:
- Deploy a Bedrock single-key vault cluster
- Deploy the Azure voting app resource manifest

Steps:
- Deploy a kubernetes single key-vault cluster with flux via `spk`
- Clone the `voting-manifest` repo that was created in the previous challenge
- Push the `azure-vote.yaml`(resource manifest file) for the voting app in the `voting-manifest` repository.

Azure voting app resource manifest:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-back
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-back
  template:
    metadata:
      labels:
        app: azure-vote-back
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-back
        image: edsa14/redis:v1
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 6379
          name: redis
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-back
spec:
  ports:
  - port: 6379
  selector:
    app: azure-vote-back
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-front
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-front
  template:
    metadata:
      labels:
        app: azure-vote-front
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-front
        image: edsa14/azure-vote-front:v1
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 80
        env:
        - name: REDIS
          value: "azure-vote-back"
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-front
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: azure-vote-front
```

### Challenge 1.1: Resource Manifest
Objective: Understand the pros and cons of working with raw resource manifests.

Goal: Make a change to the voting app resource manifest. Verify it was automatically deployed via GitOps.

Steps:
- Change the docker image tag for the voting app from `v1` to `v2` in the `azure-vote.yaml`. New image name: `edsa14/azure-vote-front:v1`
- Push the change to the repository

To-do: Include image of new app

Challenge 1.2

### Challenge 1.2: Helm (optional)
Objective: Generate a resource manifest from a helm chart 

Goal: Get a basic understanding of the pros/cons of Helm.

Steps:
- Clone the [repository](https://github.com/edaena/helm-charts) with the helm chart for the azure voting app. 
- `cd helm-charts`
- `helm template ./azure-vote`
- Change the image tag in `values.yaml` to `v2`
- `helm template ./azure-vote`

Verify that the generated resource manifest has the `v2` image tag.

### Challenge 1.3: From Helm to High Level Deployment Definitions
Objective: Generate a resource manifest from an HLD

Goal: Understand the benefits of using HLDs for large applications with several deploying environments.

Steps:
