resource "kubernetes_manifest" "deployment_advertisements" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app"                    = "ecommerce"
        "service"                = "advertisements"
        "tags.datadoghq.com/env" = "development"
      }
      "name"      = "advertisements"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app"     = "ecommerce"
          "service" = "advertisements"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "creationTimestamp" = null
          "labels" = {
            "app"                    = "ecommerce"
            "service"                = "advertisements"
            "tags.datadoghq.com/env" = "development"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "flask",
                "run",
                "--port=5002",
                "--host=0.0.0.0",
              ]
              "command" = [
                "ddtrace-run",
              ]
              "env" = [
                {
                  "name"  = "FLASK_APP"
                  "value" = "ads.py"
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
                  "value" = "advertisements-service"
                },
                {
                  "name" = "DD_ENV"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.labels['tags.datadoghq.com/env']"
                    }
                  }
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
              ]
              "image" = "ddtraining/advertisements:latest"
              "name"  = "advertisements"
              "ports" = [
                {
                  "containerPort" = 5002
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

resource "kubernetes_manifest" "service_advertisements" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app"     = "ecommerce"
        "service" = "advertisements"
      }
      "name"      = "advertisements"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "port"       = 5002
          "protocol"   = "TCP"
          "targetPort" = 5002
        },
      ]
      "selector" = {
        "app"     = "ecommerce"
        "service" = "advertisements"
      }
    }
  }
}
