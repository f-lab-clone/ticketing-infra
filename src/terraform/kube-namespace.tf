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


resource "kubernetes_manifest" "argocd-quata" {
  depends_on = [kubernetes_namespace.argo-ns]

  manifest = yamldecode(file("${path.module}/../kubernetes/namespace-resources/argocd-quata.yaml"))
}

resource "kubernetes_manifest" "monitoring-quata" {
  depends_on = [kubernetes_namespace.monitoring-ns]

  manifest = yamldecode(file("${path.module}/../kubernetes/namespace-resources/monitoring-quata.yaml"))
}