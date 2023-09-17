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
resource "kubernetes_namespace" "ingress-nginx-ns" {
  metadata {
    name = "ingress-nginx"
  }
}