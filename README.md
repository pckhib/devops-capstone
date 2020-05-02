# Cloud DevOps - Capstone

## Create Kubernetes Cluster

In order to create the Kubernetes Cluster, run the following command:

```shell
eksctl create cluster -f cluster.yml
```

## Jenkins Pipeline

The Jenkins Pipeline performs the following tasks:

- HTML Linting
- Build Docker Image
- Push Docker Image to DockerHub
- Create Kubernetes Configuration
- Create Blue Deployment
- Create Green Deployment
- Setup LoadBalancer to use Blue Deployment
- Ask for switch to Green Deployment
- Setup LoadBalancer to use Green Deployment
- Print some information about the Deployment
