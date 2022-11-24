resource "datadog_dashboard" "tfer--dashboard_msy-hmt-yug" {
  is_read_only = "false"
  layout_type  = "ordered"
  reflow_type  = "fixed"
  title        = "Standard Store Dog Dashboard"
  url          = "/dashboard/msy-hmt-yug/standard-store-dog-dashboard"

  widget {
    group_definition {
      background_color = "gray"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "INFRA"

      widget {
        hostmap_definition {
          no_group_hosts  = "true"
          no_metric_hosts = "false"

          request {
            fill {
              q = "sum:kubernetes.cpu.usage.total{*,*} by {host}"
            }
          }

          scope = ["$deployment", "$namespace"]

          style {
            palette      = "YlOrRd"
            palette_flip = "false"
          }

          title       = "CPU utilization per node"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "6"
          x               = "0"
          y               = "4"
        }
      }

      widget {
        hostmap_definition {
          no_group_hosts  = "true"
          no_metric_hosts = "false"

          request {
            fill {
              q = "sum:kubernetes.memory.usage{*,*} by {host}"
            }
          }

          scope = ["$deployment", "$namespace"]

          style {
            palette      = "hostmap_blues"
            palette_flip = "false"
          }

          title       = "Memory usage per node"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "6"
          x               = "6"
          y               = "4"
        }
      }

      widget {
        note_definition {
          background_color = "transparent"
          content          = "This group tracks resource metrics at the node and pod level. See more Kubernetes metrics on our [Kubernetes Overview dashboard](https://app.datadoghq.com/screen/integration/86/kubernetes-overview?from_ts=1647536695024\u0026to_ts=1647540295024\u0026live=true). \n"
          font_size        = "14"
          has_padding      = "true"
          show_tick        = "false"
          text_align       = "left"
          tick_edge        = "left"
          tick_pos         = "50%"
          vertical_align   = "top"
        }

        widget_layout {
          height          = "1"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        query_table_definition {
          request {
            formula {
              alias              = "Free disk space"
              formula_expression = "query1"

              limit {
                count = "50"
                order = "desc"
              }
            }

            formula {
              alias              = "Used disk space"
              formula_expression = "query2"
            }

            limit = "0"

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "avg:system.disk.free{*} by {device}"
              }
            }

            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query2"
                query       = "avg:system.disk.used{*} by {device}"
              }
            }
          }

          title = "Amount of free and used disk space per device"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "9"
          x               = "3"
          y               = "1"
        }
      }

      widget {
        query_value_definition {
          autoscale = "true"
          precision = "1"

          request {
            query {
              metric_query {
                aggregator  = "last"
                data_source = "metrics"
                name        = "query1"
                query       = "avg:system.uptime{*}"
              }
            }
          }

          title = "System uptime"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "3"
          x               = "0"
          y               = "1"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "line"

            formula {
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:kubernetes.cpu.requests{*,*,*} by {host}"
              }
            }

            style {
              palette = "warm"
            }
          }

          show_legend = "false"
          title       = "Sum Kubernetes CPU requests per node"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "6"
          x               = "0"
          y               = "7"
        }
      }

      widget {
        timeseries_definition {
          legend_columns = ["avg", "max", "min", "sum", "value"]
          legend_layout  = "auto"

          request {
            display_type = "line"

            formula {
              formula_expression = "query1"
            }

            on_right_yaxis = "false"

            query {
              metric_query {
                data_source = "metrics"
                name        = "query1"
                query       = "sum:kubernetes.memory.requests{*,*,*} by {host}"
              }
            }

            style {
              palette = "cool"
            }
          }

          show_legend = "false"
          title       = "Sum Kubernetes memory requests per node"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "6"
          x               = "6"
          y               = "7"
        }
      }

      widget {
        toplist_definition {
          request {
            formula {
              formula_expression = "query1"

              limit {
                count = "50"
                order = "desc"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:kubernetes.cpu.usage.total{!pod_name:no_pod,*,*,*} by {pod_name}"
              }
            }

            style {
              palette = "warm"
            }
          }

          title       = "Most CPU-intensive pods"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "6"
          x               = "0"
          y               = "10"
        }
      }

      widget {
        toplist_definition {
          request {
            formula {
              formula_expression = "query1"

              limit {
                count = "50"
                order = "desc"
              }
            }

            query {
              metric_query {
                aggregator  = "avg"
                data_source = "metrics"
                name        = "query1"
                query       = "sum:kubernetes.memory.usage{!pod_name:no_pod,*,*,*} by {pod_name}"
              }
            }

            style {
              palette = "cool"
            }
          }

          title       = "Most memory-intensive pods"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "3"
          is_column_break = "false"
          width           = "6"
          x               = "6"
          y               = "10"
        }
      }
    }

    widget_layout {
      height          = "14"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "6"
    }
  }

  widget {
    group_definition {
      background_color = "vivid_green"
      layout_type      = "ordered"
      show_title       = "true"
      title            = "APM"

      widget {
        topology_map_definition {
          request {
            query {
              data_source = "service_map"
              filters     = ["env:development"]
              service     = "store-frontend"
            }

            request_type = "topology"
          }

          title       = "Service Map"
          title_align = "left"
          title_size  = "16"
        }

        widget_layout {
          height          = "4"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "0"
        }
      }

      widget {
        trace_service_definition {
          display_format     = "two_column"
          env                = "development"
          service            = "store-frontend"
          show_breakdown     = "true"
          show_distribution  = "true"
          show_errors        = "true"
          show_hits          = "true"
          show_latency       = "true"
          show_resource_list = "false"
          size_format        = "medium"
          span_name          = "rack.request"
          title              = "APM Status"
        }

        widget_layout {
          height          = "12"
          is_column_break = "false"
          width           = "12"
          x               = "0"
          y               = "4"
        }
      }
    }

    widget_layout {
      height          = "17"
      is_column_break = "true"
      width           = "12"
      x               = "0"
      y               = "0"
    }
  }

  widget {
    image_definition {
      has_background   = "true"
      has_border       = "true"
      horizontal_align = "center"
      sizing           = "cover"
      url              = "https://static.boredpanda.com/blog/wp-content/uploads/2014/08/dog-opens-counter-window-shiba-inu-doge-gif.gif"
      vertical_align   = "center"
    }

    widget_layout {
      height          = "6"
      is_column_break = "false"
      width           = "6"
      x               = "0"
      y               = "0"
    }
  }

  widget {
    list_stream_definition {
      request {
        columns {
          field = "matches"
          width = "auto"
        }

        columns {
          field = "message"
          width = "auto"
        }

        columns {
          field = "service"
          width = "auto"
        }

        columns {
          field = "status_line"
          width = "auto"
        }

        columns {
          field = "volume"
          width = "auto"
        }

        query {
          data_source = "logs_pattern_stream"
        }

        response_format = "event_list"
      }

      title_align = "left"
      title_size  = "16"
    }

    widget_layout {
      height          = "9"
      is_column_break = "false"
      width           = "12"
      x               = "0"
      y               = "0"
    }
  }

  widget {
    manage_status_definition {
      color_preference    = "text"
      display_format      = "countsAndList"
      hide_zero_counts    = "true"
      query               = ""
      show_last_triggered = "false"
      show_priority       = "false"
      sort                = "status,asc"
      summary_type        = "monitors"
    }

    widget_layout {
      height          = "6"
      is_column_break = "false"
      width           = "6"
      x               = "6"
      y               = "0"
    }
  }
}
