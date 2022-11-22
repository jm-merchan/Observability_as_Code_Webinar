resource "kubernetes_manifest" "deployment_discounts" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app"                    = "ecommerce"
        "service"                = "discounts"
        "tags.datadoghq.com/env" = "development"
      }
      "name"      = "discounts"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app"     = "ecommerce"
          "service" = "discounts"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "creationTimestamp" = null
          "labels" = {
            "app"                    = "ecommerce"
            "service"                = "discounts"
            "tags.datadoghq.com/env" = "development"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "flask",
                "run",
                "--port=5001",
                "--host=0.0.0.0",
              ]
              "command" = [
                "ddtrace-run",
              ]
              "env" = [
                {
                  "name"  = "FLASK_APP"
                  "value" = "discounts.py"
                },
                {
                  "name"  = "FLASK_DEBUG"
                  "value" = "1"
                },
                {
                  "name" = "POSTGRES_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key"  = "pw"
                      "name" = "db-password"
                    }
                  }
                },
                {
                  "name"  = "POSTGRES_USER"
                  "value" = "user"
                },
                {
                  "name"  = "POSTGRES_HOST"
                  "value" = "db"
                },
                {
                  "name"  = "DATADOG_SERVICE_NAME"
                  "value" = "discountsservice"
                },
                {
                  "name" = "DD_AGENT_HOST"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "status.hostIP"
                    }
                  }
                },
                {
                  "name"  = "DD_LOGS_INJECTION"
                  "value" = "true"
                },
                {
                  "name"  = "DD_ANALYTICS_ENABLED"
                  "value" = "true"
                },
                {
                  "name"  = "DD_PROFILING_ENABLED"
                  "value" = "true"
                },
                {
                  "name" = "DD_ENV"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.labels['tags.datadoghq.com/env']"
                    }
                  }
                },
              ]
              "image" = "ddtraining/discounts:latest"
              "name"  = "discounts"
              "ports" = [
                {
                  "containerPort" = 5001
                },
              ]
              "resources" = {}
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_discounts" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app"     = "ecommerce"
        "service" = "discounts"
      }
      "name"      = "discounts"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "port"       = 5001
          "protocol"   = "TCP"
          "targetPort" = 5001
        },
      ]
      "selector" = {
        "app"     = "ecommerce"
        "service" = "discounts"
      }
      "sessionAffinity" = "None"
      "type"            = "ClusterIP"
    }
  }
}
