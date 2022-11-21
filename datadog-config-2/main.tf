terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
      version = "3.18.0"
    }
  }

  required_version = "~> 1.3.4"
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
