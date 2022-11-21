
resource "datadog_dashboard_json" "dashboard_json" {
  dashboard = <<EOF
{
  "title": "eCommerce Containers Dashboard",
  "description": "For containers related to eCommerce service",
  "widgets": [
    {
      "id": 7798658189808489,
      "definition": {
        "type": "note",
        "content": "\n\nContainers",
        "background_color": "blue",
        "font_size": "24",
        "text_align": "center",
        "show_tick": true,
        "tick_pos": "50%",
        "tick_edge": "right"
      }
    },
    {
      "id": 7987792356635335,
      "definition": {
        "title": "Running container change",
        "title_size": "16",
        "title_align": "center",
        "time": {
          "live_span": "5m"
        },
        "type": "query_value",
        "requests": [
          {
            "formulas": [
              {
                "formula": "100 * (query1 / timeshift(query1, -300))"
              }
            ],
            "conditional_formats": [
              {
                "hide_value": false,
                "comparator": ">=",
                "palette": "white_on_green",
                "value": 80
              },
              {
                "hide_value": false,
                "comparator": ">",
                "palette": "white_on_yellow",
                "value": 50
              },
              {
                "hide_value": false,
                "comparator": ">=",
                "palette": "white_on_red",
                "value": 0
              }
            ],
            "response_format": "scalar",
            "queries": [
              {
                "query": "sum:docker.containers.running{$scope}",
                "data_source": "metrics",
                "name": "query1",
                "aggregator": "last"
              }
            ]
          }
        ],
        "autoscale": false,
        "custom_unit": "%",
        "text_align": "center",
        "precision": 0
      }
    },
    {
      "id": 6160509653135078,
      "definition": {
        "title": "Running containers",
        "title_size": "16",
        "title_align": "center",
        "time": {
          "live_span": "1m"
        },
        "type": "query_value",
        "requests": [
          {
            "response_format": "scalar",
            "queries": [
              {
                "query": "sum:docker.containers.running{$scope}",
                "data_source": "metrics",
                "name": "query1",
                "aggregator": "last"
              }
            ]
          }
        ],
        "autoscale": true,
        "text_align": "center",
        "precision": 0
      }
    },
    {
      "id": 3555337064012219,
      "definition": {
        "title": "Stopped containers",
        "title_size": "16",
        "title_align": "center",
        "time": {
          "live_span": "1m"
        },
        "type": "query_value",
        "requests": [
          {
            "response_format": "scalar",
            "queries": [
              {
                "query": "sum:docker.containers.stopped{$scope}",
                "data_source": "metrics",
                "name": "query1",
                "aggregator": "last"
              }
            ]
          }
        ],
        "autoscale": true,
        "text_align": "center",
        "precision": 0
      }
    },
    {
      "id": 7863469139068599,
      "definition": {
        "title": "Running containers by image",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "1h"
        },
        "type": "toplist",
        "requests": [
          {
            "q": "timeshift(top(sum:docker.containers.running{$scope} by {docker_image}.fill(60), 20, 'last', 'desc'), 40)",
            "style": {
              "palette": "dog_classic"
            }
          }
        ]
      }
    },
    {
      "id": 7754421685521733,
      "definition": {
        "title": "",
        "time": {
          "live_span": "1d"
        },
        "type": "event_timeline",
        "query": "sources:docker"
      }
    },
    {
      "id": 8273467504375765,
      "definition": {
        "title": "Running containers by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "sum:docker.containers.running{$scope} by {docker_image}.fill(0)",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "display_type": "bars"
          }
        ]
      }
    },
    {
      "id": 4305333092761746,
      "definition": {
        "title": "",
        "time": {
          "live_span": "1d"
        },
        "type": "event_stream",
        "query": "sources:docker",
        "event_size": "s"
      }
    },
    {
      "id": 5970914899396258,
      "definition": {
        "type": "note",
        "content": "[CPU Core Load](https://www.datadoghq.com/blog/how-to-monitor-docker-resource-metrics/#toc2)",
        "background_color": "blue",
        "font_size": "24",
        "text_align": "center",
        "show_tick": true,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 8266586278925709,
      "definition": {
        "type": "note",
        "content": "Memory",
        "background_color": "blue",
        "font_size": "24",
        "text_align": "center",
        "show_tick": true,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 4915886418788714,
      "definition": {
        "type": "note",
        "content": "Network",
        "background_color": "blue",
        "font_size": "24",
        "text_align": "center",
        "show_tick": true,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 1208866483305317,
      "definition": {
        "type": "note",
        "content": "I/O",
        "background_color": "blue",
        "font_size": "24",
        "text_align": "center",
        "show_tick": true,
        "tick_pos": "50%",
        "tick_edge": "bottom"
      }
    },
    {
      "id": 7171317507927626,
      "definition": {
        "title": "CPU user by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "avg:docker.cpu.user{$scope} by {docker_image}.fill(0)",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "style": {
              "palette": "cool"
            },
            "display_type": "line"
          }
        ]
      }
    },
    {
      "id": 273032047117144,
      "definition": {
        "title": "RSS memory by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "avg:docker.mem.rss{$scope} by {docker_image}.fill(0)",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "display_type": "line"
          }
        ]
      }
    },
    {
      "id": 4520972285768804,
      "definition": {
        "title": "Avg. rx bytes by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "avg:docker.net.bytes_rcvd{$scope} by {docker_image}",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "style": {
              "palette": "cool"
            },
            "display_type": "area"
          }
        ]
      }
    },
    {
      "id": 7666308852829264,
      "definition": {
        "title": "Avg. I/O bytes read by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "avg:docker.io.read_bytes{$scope} by {docker_image}",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "style": {
              "palette": "dog_classic"
            },
            "display_type": "area"
          }
        ]
      }
    },
    {
      "id": 5389784174748563,
      "definition": {
        "title": "CPU system by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "avg:docker.cpu.system{$scope} by {docker_image}.fill(0)",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "style": {
              "palette": "cool"
            },
            "display_type": "line"
          }
        ]
      }
    },
    {
      "id": 1007345555385911,
      "definition": {
        "title": "Swap by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "avg:docker.mem.swap{$scope} by {docker_image}",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "display_type": "line"
          }
        ]
      }
    },
    {
      "id": 5580052476004235,
      "definition": {
        "title": "Avg. tx bytes by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "avg:docker.net.bytes_sent{$scope} by {docker_image}",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "style": {
              "palette": "purple"
            },
            "display_type": "area"
          }
        ]
      }
    },
    {
      "id": 2790786991197888,
      "definition": {
        "title": "Avg. I/O bytes written by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "avg:docker.io.write_bytes{$scope} by {docker_image}",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "style": {
              "palette": "dog_classic"
            },
            "display_type": "area"
          }
        ]
      }
    },
    {
      "id": 8356009826858574,
      "definition": {
        "title": "Most CPU-intensive containers",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "1h"
        },
        "type": "toplist",
        "requests": [
          {
            "formulas": [
              {
                "formula": "query1",
                "limit": {
                  "count": 5,
                  "order": "desc"
                }
              }
            ],
            "style": {
              "palette": "cool"
            },
            "response_format": "scalar",
            "queries": [
              {
                "query": "avg:docker.cpu.user{$scope} by {container_name}",
                "data_source": "metrics",
                "name": "query1",
                "aggregator": "max"
              }
            ]
          }
        ]
      }
    },
    {
      "id": 447984644992128,
      "definition": {
        "title": "Cache memory by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": true,
        "legend_layout": "auto",
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "query": "sum:docker.mem.cache{$scope} by {docker_image}",
                "data_source": "metrics",
                "name": "query1"
              }
            ],
            "display_type": "line"
          }
        ]
      }
    },
    {
      "id": 1841199717359832,
      "definition": {
        "title": "Most tx-intensive containers",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "1h"
        },
        "type": "toplist",
        "requests": [
          {
            "formulas": [
              {
                "formula": "query1",
                "limit": {
                  "count": 5,
                  "order": "desc"
                }
              }
            ],
            "style": {
              "palette": "purple"
            },
            "response_format": "scalar",
            "queries": [
              {
                "query": "avg:docker.net.bytes_sent{$scope} by {container_name}",
                "data_source": "metrics",
                "name": "query1",
                "aggregator": "max"
              }
            ]
          }
        ]
      }
    },
    {
      "id": 1583703755329048,
      "definition": {
        "title": "CPU by container",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "heatmap",
        "requests": [
          {
            "q": "avg:docker.cpu.user{$scope} by {container_name}"
          }
        ]
      }
    },
    {
      "id": 8254198146866840,
      "definition": {
        "title": "Most RAM-intensive containers",
        "title_size": "16",
        "title_align": "left",
        "time": {
          "live_span": "1h"
        },
        "type": "toplist",
        "requests": [
          {
            "formulas": [
              {
                "formula": "query1",
                "limit": {
                  "count": 5,
                  "order": "desc"
                }
              }
            ],
            "style": {
              "palette": "dog_classic"
            },
            "response_format": "scalar",
            "queries": [
              {
                "query": "avg:docker.mem.rss{$scope} by {container_name}",
                "data_source": "metrics",
                "name": "query1",
                "aggregator": "max"
              }
            ]
          }
        ]
      }
    },
    {
      "id": 3704463519760724,
      "definition": {
        "title": "tx by container",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "heatmap",
        "requests": [
          {
            "q": "avg:docker.net.bytes_sent{$scope} by {container_name}"
          }
        ]
      }
    },
    {
      "id": 4239216352380432,
      "definition": {
        "title": "Memory by container",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "heatmap",
        "requests": [
          {
            "q": "avg:docker.mem.rss{$scope} by {container_name}"
          }
        ]
      }
    }
  ],
  "template_variables": [
    {
      "name": "scope",
      "prefix": "short_image",
      "available_values": [],
      "default": "*"
    }
  ],
  "layout_type": "ordered",
  "is_read_only": false,
  "notify_list": [],
  "reflow_type": "auto",
  "id": "mcz-p7x-a92"
}
EOF
}
