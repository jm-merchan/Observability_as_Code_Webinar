terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "2.13.0"
    }
  }

  required_version = "~> 0.13"
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
