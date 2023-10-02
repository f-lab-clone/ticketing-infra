resource "helm_release" "kube-prometheus" {
  depends_on = [
    helm_release.mysql-exporter,
    kubernetes_config_map.grafana-dashboards-custom
  ]

  chart      = "kube-prometheus-stack"
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"

  values = [
    "${file("${path.module}/../kubernetes/prometheus/kube_prometheus_custom_values.yaml")}"
  ]
}

resource "helm_release" "mysql-exporter" {
  chart      = "prometheus-mysql-exporter"
  name       = "mysql-exporter"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"

  values = [
    "${file("${path.module}/../kubernetes/prometheus/mysql_exporter_custom_values.yaml")}"
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
    "mysql-exporter.json" = file("${path.module}/../kubernetes/prometheus/dashboards/mysql_exporter.json"),

    "spring-actuator.json" = file("${path.module}/../kubernetes/prometheus/dashboards/spring_actuator.json"),
    "spring-http-example.json" = file("${path.module}/../kubernetes/prometheus/dashboards/spring-http-example.json"),
    

    "nginx.json" = file("${path.module}/../kubernetes/prometheus/dashboards/nginx.json")
    "nginx-controller.json" = file("${path.module}/../kubernetes/prometheus/dashboards/nginx_controller.json"),
    "nginx-request-performance.json" = file("${path.module}/../kubernetes/prometheus/dashboards/nginx-request-performance.json")

    "k6.json" = file("${path.module}/../kubernetes/prometheus/dashboards/k6.json")
    "k6-prometheus.json" = file("${path.module}/../kubernetes/prometheus/dashboards/k6-prometheus.json")
    "k6-native-histograms.json" = file("${path.module}/../kubernetes/prometheus/dashboards/k6-native-histograms.json")
    
  }
}