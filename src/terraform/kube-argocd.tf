resource "helm_release" "argocd" {
  name       = "morgo"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"

  set {
    name = "global.nodeSelector.role"
    value = "backend"
  }
}

resource "kubernetes_manifest" "development" {
  depends_on = [helm_release.argocd]

  manifest = yamldecode(file("${path.module}/../kubernetes/applications.yaml"))
}