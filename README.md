
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
- [AKS cluster](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough)
- [ACR](https://azure.microsoft.com/en-us/services/container-registry/)
- [Container](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/container-docker-introduction/docker-defined)
- [Deploy Key](https://github.com/microsoft/bedrock/tree/docs_spk/docs/firstWorkload#generate-a-deploy-key-for-the-gitops-resource-manifest-repo)
- [Fabrikate](https://github.com/microsoft/fabrikate)
- [Flux](https://www.weave.works/oss/flux/)
- [GitOps](https://github.com/microsoft/bedrock/blob/docs_spk/docs/why-gitops.md)
- [Helm](https://helm.sh/)
- [HLD, High Level Deployment definition](https://github.com/microsoft/bedrock/blob/docs_spk/docs/high-level-definitions.md)
- [Node Key](https://github.com/microsoft/bedrock/tree/docs_spk/docs/firstWorkload#create-a-node-key)
- [Resource Manifest](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/)
- Ring
- [SPK](https://github.com/CatalystCode/spk)
- [Terraform](https://www.terraform.io/)
