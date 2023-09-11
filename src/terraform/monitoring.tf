resource "helm_release" "kube-prometheus" {
  chart      = "kube-prometheus-stack"
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"

  values = [
    "${file("${path.module}/../grafana/kube_prometheus_custom_values.yaml")}"
  ]
}

resource "helm_release" "mysql-exporter" {
  chart      = "prometheus-mysql-exporter"
  name       = "mysql-exporter"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"

  values = [
    "${file("${path.module}/../grafana/mysql_exporter_custom_values.yaml")}"
  ]
}


resource "kubernetes_config_map" "grafana-dashboards-custom" {
  metadata {
    name      = "grafana-dashboard-custom"
    namespace = kubernetes_namespace.monitoring-ns.metadata[0].name

    labels = {
      grafana_dashboard = 1
    }

    annotations = {
      k8s-sidecar-target-directory = "/tmp/dashboards/custom"
    }
  }

  data = {
    "test-dashboard.json" = file("${path.module}/../grafana/dashboards/test_dashboard.json"),
    "mysql-exporter.json" = file("${path.module}/../grafana/dashboards/mysql_exporter.json")
  }
}