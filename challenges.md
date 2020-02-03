
The following challenges are part of a workflow to understand and deploy an application on Kubernetes using a Bedrock workflow. In this case, we will deploy the [Azure voting app](https://github.com/Azure-Samples/azure-voting-app-redis).

![voting app](./images/azure-vote.png)

To-do: include overall diagram of the system

### Challenge 0
Objective: Setup for the hack project

Steps:
1. Download and setup the required tools. Follow [these steps](https://github.com/edaena/bedrock-wsl).
2. Create an Azure DevOps project `voting-app-project`
3. Inside the `voting-app-project` create three repositories: `voting-app`, `voting-hld`, `voting-manifest`
4. In Azure DevOps, generate a Personal Access Token(PAT) with this permissions:
- Build (Read & execute)
- Code (Read, write, & manage)
- Variable Groups (Read, create, & manage)
For help setting up the PAT, see 
[guide](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=preview-page).

To-do: include diagram of artifacts (repos)

### Challenge 1
Objective: Understand GitOps

Goals:
- Deploy a Bedrock single-key vault cluster
- Deploy the Azure voting app resource manifest

Azure voting app resource manifest:
```
```
