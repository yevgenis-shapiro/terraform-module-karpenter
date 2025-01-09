data "kubectl_path_documents" "provisioner_manifests" {
  pattern = "./karpenter-provisioner-manifests/*.yaml"
  vars = {
    cluster_name = var.cluster_name
  }
}

resource "kubectl_manifest" "provisioners" {
  for_each  = data.kubectl_path_documents.provisioner_manifests.manifests
  yaml_body = each.value
}
