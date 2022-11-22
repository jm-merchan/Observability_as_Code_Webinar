resource "kubernetes_manifest" "serviceaccount_postgres" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "name"      = "postgres"
      "namespace" = "default"
    }
  }
}

resource "kubernetes_manifest" "secret_db_password" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "pw" = "password"
    }
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "app"     = "ecommerce"
        "service" = "db"
      }
      "name"      = "db-password"
      "namespace" = "default"
    }
    "type" = "Opaque"
  }
}

resource "kubernetes_manifest" "persistentvolume_task_pv_volume" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "PersistentVolume"
    "metadata" = {
      "labels" = {
        "type" = "local"
      }
      "name" = "task-pv-volume"
    }
    "spec" = {
      "accessModes" = [
        "ReadWriteOnce",
      ]
      "capacity" = {
        "storage" = "5Gi"
      }
      "hostPath" = {
        "path" = "/mnt/data"
      }
      "persistentVolumeReclaimPolicy" = "Retain"
      "storageClassName"              = "manual"
    }
  }
}

resource "kubernetes_manifest" "persistentvolumeclaim_task_pvc_volume" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "PersistentVolumeClaim"
    "metadata" = {
      "name"      = "task-pvc-volume"
      "namespace" = "default"
    }
    "spec" = {
      "accessModes" = [
        "ReadWriteOnce",
      ]
      "resources" = {
        "requests" = {
          "storage" = "1Gi"
        }
      }
      "storageClassName" = "manual"
    }
  }
}

resource "kubernetes_manifest" "deployment_db" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app"     = "ecommerce"
        "service" = "db"
      }
      "name"      = "db"
      "namespace" = "default"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app"     = "ecommerce"
          "service" = "db"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "labels" = {
            "app"     = "ecommerce"
            "service" = "db"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
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
                  "name"  = "PGDATA"
                  "value" = "/var/lib/postgresql/data/mydata"
                },
              ]
              "image" = "postgres:11-alpine"
              "name"  = "postgres"
              "ports" = [
                {
                  "containerPort" = 5432
                },
              ]
              "resources" = {}
              "securityContext" = {
                "privileged" = true
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/var/lib/postgresql/data"
                  "name"      = "postgresdb"
                },
              ]
            },
          ]
          "serviceAccountName" = "postgres"
          "volumes" = [
            {
              "name" = "postgresdb"
              "persistentVolumeClaim" = {
                "claimName" = "task-pvc-volume"
              }
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_db" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "creationTimestamp" = null
      "labels" = {
        "app"     = "ecommerce"
        "service" = "db"
      }
      "name"      = "db"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "port"       = 5432
          "protocol"   = "TCP"
          "targetPort" = 5432
        },
      ]
      "selector" = {
        "app"     = "ecommerce"
        "service" = "db"
      }
    }
  }
}
