![0_vBzCFONsWRv8xtW2](https://github.com/user-attachments/assets/2c69de1e-9419-4824-9814-4e18681f56f7)


## Terraform Module - Karpenter | 🚀🚀🚀 
Karpenter is an open-source, flexible, high-performance Kubernetes cluster autoscaler built with AWS. Here I will be installing Karpenter and deploying Karpenter Provisioners to an EKS cluster using Terraform



## Key Features of Karpenter
```
✅ Watching for pods that the Kubernetes scheduler has marked as waiting for schedule
✅ Evaluating scheduling constraints (resource requests, node selectors, affinities, tolerations, and topology spread constraints)
✅ Provisioning nodes that meet the requirements of the pods
✅ Removing the nodes when the nodes are no longer needed
```


## Complements :
```
✅ Terraform
✅ Crossplane
```

## Karpenter Example :
```
apiVersion: karpenter.sh/v1alpha5
kind: Provisioner
metadata:
name: default
spec:
#Requirements that constrain the parameters of provisioned nodes. 
#Operators { In, NotIn } are supported to enable including or excluding values
  requirements:
    - key: "node.kubernetes.io/instance-type" #If not included, all instance types are considered
      operator: In
      values: ["m5.large", "m5.2xlarge"]
    - key: "topology.kubernetes.io/zone" #If not included, all zones are considered
      operator: In
      values: ["us-east-1a", "us-east-1b"]
    - key: "kubernetes.io/arch" #If not included, all architectures are considered
	  operator: In
      values: ["arm64", "amd64"]
    - key: " karpenter.sh/capacity-type" #If not included, the webhook for the AWS cloud provider will default to on-demand
      operator: In
      values: ["spot", "on-demand"]
  provider:
    instanceProfile: KarpenterNodeInstanceProfile-eks-karpenter-demo
  ttlSecondsAfterEmpty: 30  
```


