resource "kubernetes_deployment" "deploy_frontend" {
  metadata {
    labels = {
      "app"                    = "ecommerce"
      "service"                = "frontend"
      "tags.datadoghq.com/env" = "development"
    }
    name      = "frontend"
    namespace = "default"
  }
  spec {
    replicas = 4

    selector {
      match_labels = {
        app     = "ecommerce"
        service = "frontend"
      }
    }
    strategy {
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
      type = "RollingUpdate"
    }

    template {
      metadata {
        labels = {
          "app"                    = "ecommerce"
          "service"                = "frontend"
          "tags.datadoghq.com/env" = "development"
        }
      }

      spec {
        container {
          args    = ["docker-entrypoint.sh"]
          command = ["sh"]
          env {
            name  = "DB_USERNAME"
            value = "user"
          }

          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = "db-password"
                key  = "pw"
              }
            }
          }
          env {
            name = "DD_AGENT_HOST"
            value_from {
              field_ref {
                field_path = "status.hostIP"
              }
            }
          }

          env {
            name  = "DD_LOGS_INJECTION"
            value = true
          }

          env {
            name = "DD_ENV"
            value_from {
              field_ref {
                field_path = "metadata.labels['tags.datadoghq.com/env']"
              }
            }
          }

          env {
            name  = "DD_ANALYTICS_ENABLED"
            value = true
          }

          env {
            name  = "DD_CLIENT_TOKEN"
            value = var.DD_CLIENT_TOKEN
          }

          env {
            name  = "DD_APPLICATION_ID"
            value = var.DD_APPLICATION_ID
          }


          image             = "ddtraining/storefront:latest"
          image_pull_policy = "Always"
          name              = "ecommerce-spree-observability"
          port {
            container_port = 3000
            protocol       = "TCP"
          }

          resources {
            # "limits" = {}
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "frontend" {
  metadata {
    name      = "frontend"
    namespace = "default"
    labels = {
      app     = "ecommerce"
      service = "frontend"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.deploy_frontend.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}



output "frontend" {
  value = "http://${kubernetes_service.frontend.status.0.load_balancer.0.ingress.0.hostname}"
}
