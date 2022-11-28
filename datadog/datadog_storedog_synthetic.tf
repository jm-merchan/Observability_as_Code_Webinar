resource "datadog_synthetics_test" "tfer--synthetics_ahg-4qy-te5" {
  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Click on button #add-to-cart-button"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"main\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"button\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"button\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" input-group-append \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" input-group-append \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"co\":\"[{\\\"text\\\":\\\"add to cart\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[local-name()=\\\"button\\\"]\"},\"targetOuterHTML\":\"<button name=\\\"button\\\" type=\\\"submit\\\" class=\\\"btn btn-success\\\" id=\\\"add-to-cart-button\\\">\\n                  Add To Cart\\n</button>\",\"url\":\"http://a087d5e0fb2d2474889afeb586e2ba1d-853447894.us-east-1.elb.amazonaws.com/products/datadog-tote\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Click on image \"Datadog Tote\""

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"main\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"a\\\"][1]/*[local-name()=\\\"img\\\"][1]\",\"at\":\"/descendant::*[@alt=\\\"Datadog Tote\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" mt-4 \\\")][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" mx-auto \\\")]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" mt-4 \\\")][2]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"div\\\"][1]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" mx-auto \\\")]\",\"co\":\"[{\\\"text\\\":\\\"datadog tote\\\",\\\"textType\\\":\\\"alt\\\"}]\",\"ro\":\"//*[@alt=\\\"Datadog Tote\\\"]\"},\"targetOuterHTML\":\"<img itemprop=\\\"image\\\" class=\\\"d-block mx-auto\\\" alt=\\\"Datadog Tote\\\" src=\\\"/assets/noimage/small-1eaf254c069b00a8a692912bddd1660da5f1f80ac202c6bdc4d81b40fd2e0792.png\\\">\",\"url\":\"http://a087d5e0fb2d2474889afeb586e2ba1d-853447894.us-east-1.elb.amazonaws.com/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    is_critical          = "true"
    name                 = "Test the active page does not contain text"

    params {
      delay      = "0"
      value      = "error"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertPageLacks"
  }

  device_ids = ["chrome.laptop_large"]
  locations  = ["aws:${var.aws_region}"]
  message    = "eCommerce Application is not responding @jaime.alonso@datadoghq.com"
  name       = "Checkout test"

  options_list {
    accept_self_signed              = "false"
    allow_insecure                  = "false"
    check_certificate_revocation    = "false"
    disable_cors                    = "false"
    disable_csp                     = "false"
    follow_redirects                = "false"
    ignore_server_certificate_error = "false"
    initial_navigation_timeout      = "0"
    min_failure_duration            = "0"
    min_location_failed             = "1"

    monitor_options {
      renotify_interval = "0"
    }

    monitor_priority = "1"
    no_screenshot    = "false"

    retry {
      count    = "0"
      interval = "300"
    }

    rum_settings {
      application_id  = var.DD_APPLICATION_ID
      client_token_id = var.DD_CLIENT_ID
      is_enabled      = "true"
    }

    tick_every = "300"
  }

  request_definition {
    dns_server_port         = "0"
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    port                    = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = data.terraform_remote_state.k8s.outputs.frontend
  }

  status = "live"
  tags   = ["app:ecommerce", "tags.datadoghq.com/env:development", "service: store-frontend"]
  type   = "browser"
}
