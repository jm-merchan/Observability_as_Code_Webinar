terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.18.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.15.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40.0"
    }
  }
  required_version = "~> 1.3.4"
}

data "terraform_remote_state" "k8s" {
  backend = "remote"

  config = {
    organization = var.org_name
    workspaces = {
      name = "Kubernetes_App"
    }
  }
}

# Retrieve EKS cluster configuration
data "kubernetes_service" "frontend" {
  metadata {
    name      = "frontend"
    namespace = "default"
  }
}

data "kubernetes_service" "beacon" {
  metadata {
    name      = "datadog"
    namespace = "datadog"
  }
}
