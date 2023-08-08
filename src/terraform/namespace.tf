resource "kubernetes_namespace" "argo-ns" {
  metadata {
    name = "argocd"
  }
}