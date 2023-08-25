resource "helm_release" "argocd" {
  name       = "morgo"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"
}

resource "kubernetes_manifest" "application" {
  depends_on = [helm_release.argocd]

  manifest = yamldecode(file("${path.module}/../argocd/applications.yaml"))
}