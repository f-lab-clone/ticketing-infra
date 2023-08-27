resource "helm_release" "kube-prometheus" {
  chart      = "kube-prometheus-stack"
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
}