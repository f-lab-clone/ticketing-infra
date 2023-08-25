resource "helm_release" "argocd" {
  name       = "morgo"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"
}

resource "kubernetes_manifest" "prod" {
  depends_on = [helm_release.argocd]

  manifest = yamldecode(file("${path.module}/../kubernetes/applications.yaml"))
}