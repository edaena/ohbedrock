
The following challenges are part of a workflow to understand and deploy an application on Kubernetes using a Bedrock workflow. In this case, we will deploy the [Azure voting app](https://github.com/Azure-Samples/azure-voting-app-redis).

![voting app](./images/azure-vote.png)

To-do: include overall diagram of the system

### Challenges (Detailed version)
- [Challenge 0: Setup Tools/Artifacts](./challenges/0.md)
- [Challenge 1: GitOps and AKS](./challenges/1-0.md)
  - [Challenge 1.1: Resource Manifest](./challenges/1-1.md)
  - [Challenge 1.2: Helm (optional)](./challenges/1-2.md)
  - [Challenge 1.3: From Helm to High Level Deployment (HLD) Definitions](./challenges/1-3.md)
- [Challenge 2: HLD to resource manifests DevOps](./challenges/2.md)
- [Challenge 3: App to HLD and ACR DevOps](./challenges/3.md)
- [Challenge 4: Make a revision](./challenges/4.md)
- [Challenge 5: Introspection](./challenges/5.md)
- Challenge 6: Observability
- Challenge 7: Deploying cluster in multiple regions
- Challenge 8: Rings

### Glossary
- AKS cluster
- ACR
- Container
- Deploy Key
- Fabrikate
- Flux
- GitOps
- Helm
- HLD, High Level Deployment definition
- HLD repository
- Node Key
- Resource Manifest
- Resource Manifest repository
- Ring
- SPK
- Terraform
