resource "helm_release" "argocd" {
  name       = "morgo"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"
}