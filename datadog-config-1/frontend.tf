resource "kubernetes_manifest" "deployment_frontend" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "ecommerce"
        "service" = "frontend"
        "tags.datadoghq.com/env" = "development"
      }
      "name" = "frontend"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "ecommerce"
          "service" = "frontend"
        }
      }
      "strategy" = {
        "rollingUpdate" = {
          "maxSurge" = "25%"
          "maxUnavailable" = "25%"
        }
        "type" = "RollingUpdate"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "ecommerce"
            "service" = "frontend"
            "tags.datadoghq.com/env" = "development"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "docker-entrypoint.sh",
              ]
              "command" = [
                "sh",
              ]
              "env" = [
                {
                  "name" = "DB_USERNAME"
                  "value" = "user"
                },
                {
                  "name" = "DB_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "pw"
                      "name" = "db-password"
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
                  "name" = "DD_LOGS_INJECTION"
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
                {
                  "name" = "DD_ANALYTICS_ENABLED"
                  "value" = "true"
                },
              ]
              "image" = "ddtraining/storefront:latest"
              "imagePullPolicy" = "Always"
              "name" = "ecommerce-spree-observability"
              "ports" = [
                {
                  "containerPort" = 3000
                  "protocol" = "TCP"
                },
              ]
              "resources" = {
                # "limits" = {}
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "100Mi"
                }
              }
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_frontend" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "ecommerce"
        "service" = "frontend"
      }
      "name" = "frontend"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 80
          "protocol" = "TCP"
          "targetPort" = 3000
        },
      ]
      "selector" = {
        "app" = "ecommerce"
        "service" = "frontend"
      }
      "type" = "LoadBalancer"
    }
  }
}


resource "null_resource" "exampleA" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region}  update-kubeconfig  --name ${data.aws_eks_cluster.cluster.name} \ 
    && kubectl get svc frontend -o json | jq .status.loadBalancer.ingress[0].hostname >> frontend.txt"
  }
  depends_on = [kubernetes_manifest.service_frontend]
}
/*
resource "null_resource" "exampleB" {
  provisioner "local-exec" {
    command = "kubectl get svc frontend -o json | jq .status.loadBalancer.ingress[0].hostname >> frontend.txt"
  }
  depends_on = [kubernetes_manifest.service_frontend]
}
*/
data "local_file" "frontend-fqdn" {
  filename = "${path.module}/frontend.txt"
  depends_on = [
    null_resource.exampleA
  ]
}

output "frontend-fqdn" {
  value = data.local_file.frontend-fqdn.content
}
