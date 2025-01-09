resource "helm_release" "karpenter" {
  namespace = kubernetes_namespace.karpenter.id

  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  version    = "0.9.0"

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_assumable_role_karpenter.iam_role_arn
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "clusterEndpoint"
    value = data.aws_eks_cluster.this.endpoint
  }
  set {
    name  = "aws.defaultInstanceProfile"
    value = aws_iam_instance_profile.karpenter.name
  }
}
