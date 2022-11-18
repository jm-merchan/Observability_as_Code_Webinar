terraform {
  required_providers {
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.18.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7.1"
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

provider "aws" {
  region = var.aws_region
}
