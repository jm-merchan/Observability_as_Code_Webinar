resource "datadog_synthetics_test" "beacon" {
  type    = "api"
  subtype = "http"

  request_definition {
    method = "GET"
    url    = "http://${kubernetes_service.beacon.status.0.load_balancer.0.ingress.0.hostname}:8080"
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
