resource "datadog_synthetics_test" "beacon" {
  type    = "api"
  subtype = "http"

  request_definition {
    method = "GET"
    url    = data.terraform_remote_state.k8s.outputs.web_endpoint
  }

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  locations = ["aws:${var.aws_region}"]
  options_list {
    tick_every          = 900
    min_location_failed = 1
  }

  name    = "beacon API Check"
  message = "Oh no! Light from the beacon app is no longer shining!"
  tags    = ["app:beacon", "env:demo"]

  status = "live"
}

resource "datadog_synthetics_test" "eCommerce" {
  type    = "api"
  subtype = "http"

  request_definition {
    method = "GET"
    url    = data.terraform_remote_state.k8s.outputs.frontend
  }

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  locations = ["aws:${var.aws_region}"]
  options_list {
    tick_every          = 60
    min_location_failed = 1
  }

  name    = "Checking eCommerce app via API"
  message = "eCommerce Application is not responding to GET requests"
  tags    = ["app:ecommerce", "tags.datadoghq.com/env:development"]

  status = "live"
}

resource "datadog_synthetics_test" "eCommerce_browser" {
  type    = "browser"
  subtype = "http"

  request_definition {
    method = "GET"
    url    = data.terraform_remote_state.k8s.outputs.frontend
  }

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  device_ids = ["laptop_large"]

  locations = ["aws:${var.aws_region}"]
  options_list {
    tick_every          = 1200
    min_location_failed = 1
  }

  name    = "Checking eCommerce app via browser"
  message = "eCommerce Application is not responding"
  tags    = ["app:ecommerce", "tags.datadoghq.com/env:development"]

  status = "live"
}