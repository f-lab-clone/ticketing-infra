resource "kubernetes_namespace" "argo-ns" {
  metadata {
    name = "argocd"
  }
}
resource "kubernetes_namespace" "monitoring-ns" {
  metadata {
    name = "monitoring"
  }
}