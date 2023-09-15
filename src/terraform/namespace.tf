resource "kubernetes_namespace" "argo-ns" {
  metadata {
    name = "argocd"
    annotations = {
      "scheduler.alpha.kubernetes.io/node-selector": "role=backend"  
    }
  }
}
resource "kubernetes_namespace" "monitoring-ns" {
  metadata {
    name = "monitoring"
    annotations = {
      "scheduler.alpha.kubernetes.io/node-selector": "role=backend"  
    }
  }
}
resource "kubernetes_namespace" "ingress-nginx-ns" {
  metadata {
    name = "ingress-nginx"
    annotations = {
      "scheduler.alpha.kubernetes.io/node-selector": "role=ingress"  
    }
  }
}