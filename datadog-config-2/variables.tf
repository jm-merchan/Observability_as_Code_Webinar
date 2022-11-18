variable "application" {
  type        = string
  description = "Name of application"
  # default = "eCommerce"
}

variable "datadog_api_key" {
  type        = string
  description = "Datadog API Key"
}

variable "datadog_app_key" {
  type        = string
  description = "Datadog Application Key"
}