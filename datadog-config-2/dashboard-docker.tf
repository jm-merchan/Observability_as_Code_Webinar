
resource "datadog_dashboard_json" "dashboard_json" {
  dashboard = <<EOF
{
  "title": "Docker - eCommerce Containers",
  "description": "For containers related to eCommerce service",
  "widgets": [
    {
      "id": 8273467504375765,
      "layout": {
        "x": 68,
        "y": 10,
        "width": 50,
        "height": 29
      },
      "definition": {
        "title": "Running containers by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "sum:docker.containers.running{$scope} by {docker_image}.fill(0)"
              }
            ],
            "display_type": "bars"
          }
        ]
      }
    },
    {
      "id": 8254198146866840,
      "layout": {
        "x": 52,
        "y": 98,
        "width": 51,
        "height": 15
      },
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
            "style": {
              "palette": "dog_classic"
            },
            "response_format": "scalar",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.mem.rss{$scope} by {container_name}",
                "aggregator": "max"
              }
            ],
            "formulas": [
              {
                "formula": "query1",
                "limit": {
                  "count": 5,
                  "order": "desc"
                }
              }
            ]
          }
        ]
      }
    },
    {
      "id": 8356009826858574,
      "layout": {
        "x": 0,
        "y": 82,
        "width": 51,
        "height": 15
      },
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
            "style": {
              "palette": "cool"
            },
            "response_format": "scalar",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.cpu.user{$scope} by {container_name}",
                "aggregator": "max"
              }
            ],
            "formulas": [
              {
                "formula": "query1",
                "limit": {
                  "count": 5,
                  "order": "desc"
                }
              }
            ]
          }
        ]
      }
    },
    {
      "id": 4239216352380432,
      "layout": {
        "x": 52,
        "y": 114,
        "width": 51,
        "height": 15
      },
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
    },
    {
      "id": 6160509653135078,
      "layout": {
        "x": 89,
        "y": 0,
        "width": 14,
        "height": 9
      },
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
                "data_source": "metrics",
                "name": "query1",
                "query": "sum:docker.containers.running{$scope}",
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
      "layout": {
        "x": 104,
        "y": 0,
        "width": 14,
        "height": 9
      },
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
                "data_source": "metrics",
                "name": "query1",
                "query": "sum:docker.containers.stopped{$scope}",
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
      "id": 1583703755329048,
      "layout": {
        "x": 0,
        "y": 98,
        "width": 51,
        "height": 15
      },
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
      "id": 7171317507927626,
      "layout": {
        "x": 0,
        "y": 50,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "CPU user by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.cpu.user{$scope} by {docker_image}.fill(0)"
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
      "layout": {
        "x": 52,
        "y": 50,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "RSS memory by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.mem.rss{$scope} by {docker_image}.fill(0)"
              }
            ],
            "display_type": "line"
          }
        ]
      }
    },
    {
      "id": 4305333092761746,
      "layout": {
        "x": 0,
        "y": 17,
        "width": 51,
        "height": 24
      },
      "definition": {
        "time": {
          "live_span": "1d"
        },
        "type": "event_stream",
        "query": "sources:docker",
        "event_size": "s"
      }
    },
    {
      "id": 7754421685521733,
      "layout": {
        "x": 0,
        "y": 8,
        "width": 51,
        "height": 9
      },
      "definition": {
        "time": {
          "live_span": "1d"
        },
        "type": "event_timeline",
        "query": "sources:docker"
      }
    },
    {
      "id": 7987792356635335,
      "layout": {
        "x": 68,
        "y": 0,
        "width": 20,
        "height": 9
      },
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
                "data_source": "metrics",
                "name": "query1",
                "query": "sum:docker.containers.running{$scope}",
                "aggregator": "last"
              }
            ],
            "formulas": [
              {
                "formula": "100 * (query1 / timeshift(query1, -300))"
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
      "id": 5389784174748563,
      "layout": {
        "x": 0,
        "y": 66,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "CPU system by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.cpu.system{$scope} by {docker_image}.fill(0)"
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
      "id": 7798658189808489,
      "layout": {
        "x": 52,
        "y": 0,
        "width": 14,
        "height": 39
      },
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
      "id": 447984644992128,
      "layout": {
        "x": 52,
        "y": 82,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "Cache memory by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "sum:docker.mem.cache{$scope} by {docker_image}"
              }
            ],
            "display_type": "line"
          }
        ]
      }
    },
    {
      "id": 2390210112217815,
      "layout": {
        "x": 0,
        "y": 0,
        "width": 51,
        "height": 8
      },
      "definition": {
        "type": "image",
        "url": "/static/images/screenboard/integrations/docker-logo-792x269.png",
        "sizing": "fit"
      }
    },
    {
      "id": 5970914899396258,
      "layout": {
        "x": 0,
        "y": 42,
        "width": 51,
        "height": 6
      },
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
      "layout": {
        "x": 52,
        "y": 42,
        "width": 51,
        "height": 6
      },
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
      "id": 1007345555385911,
      "layout": {
        "x": 52,
        "y": 66,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "Swap by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.mem.swap{$scope} by {docker_image}"
              }
            ],
            "display_type": "line"
          }
        ]
      }
    },
    {
      "id": 1208866483305317,
      "layout": {
        "x": 156,
        "y": 42,
        "width": 51,
        "height": 6
      },
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
      "id": 7666308852829264,
      "layout": {
        "x": 156,
        "y": 50,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "Avg. I/O bytes read by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.io.read_bytes{$scope} by {docker_image}"
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
      "id": 2790786991197888,
      "layout": {
        "x": 156,
        "y": 66,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "Avg. I/O bytes written by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.io.write_bytes{$scope} by {docker_image}"
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
      "id": 4915886418788714,
      "layout": {
        "x": 104,
        "y": 42,
        "width": 51,
        "height": 6
      },
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
      "id": 4520972285768804,
      "layout": {
        "x": 104,
        "y": 50,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "Avg. rx bytes by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.net.bytes_rcvd{$scope} by {docker_image}"
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
      "id": 5580052476004235,
      "layout": {
        "x": 104,
        "y": 66,
        "width": 51,
        "height": 15
      },
      "definition": {
        "title": "Avg. tx bytes by image",
        "title_size": "16",
        "title_align": "left",
        "show_legend": false,
        "time": {
          "live_span": "1h"
        },
        "type": "timeseries",
        "requests": [
          {
            "response_format": "timeseries",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.net.bytes_sent{$scope} by {docker_image}"
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
      "id": 1841199717359832,
      "layout": {
        "x": 104,
        "y": 82,
        "width": 51,
        "height": 15
      },
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
            "style": {
              "palette": "purple"
            },
            "response_format": "scalar",
            "queries": [
              {
                "data_source": "metrics",
                "name": "query1",
                "query": "avg:docker.net.bytes_sent{$scope} by {container_name}",
                "aggregator": "max"
              }
            ],
            "formulas": [
              {
                "formula": "query1",
                "limit": {
                  "count": 5,
                  "order": "desc"
                }
              }
            ]
          }
        ]
      }
    },
    {
      "id": 3704463519760724,
      "layout": {
        "x": 104,
        "y": 98,
        "width": 51,
        "height": 15
      },
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
      "id": 7863469139068599,
      "layout": {
        "x": 119,
        "y": 0,
        "width": 36,
        "height": 39
      },
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
  "layout_type": "free",
  "is_read_only": false,
  "notify_list": [],
  "id": "ktp-ui8-4w6"
}
EOF
}
