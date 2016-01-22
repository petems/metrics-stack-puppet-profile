  $collectd_conf_content = @(EOT)
FQDNLookup  true
BaseDir     "/var/lib/collectd"
PIDFile     "/var/run/collectd.pid"
PluginDir   "/usr/lib64/collectd"
TypesDB     "/usr/share/collectd/types.db"
LoadPlugin  syslog
LoadPlugin  interface
LoadPlugin  load
LoadPlugin  network
LoadPlugin  cpu
<Plugin interface>
    Interface "eth0"
    IgnoreSelected false
</Plugin>
<Plugin load>
    ReportRelative true
</Plugin>
<Plugin network>
    Server "127.0.0.1" "25826"
</Plugin>
   | EOT

$influxdb_conf = @(EOT)
### Welcome to the InfluxDB configuration file.

# Once every 24 hours InfluxDB will report anonymous data to m.influxdb.com
# The data includes raft id (random 8 bytes), os, arch, version, and metadata.
# We don't track ip addresses of servers reporting. This is only used
# to track the number of instances running and the versions, which
# is very helpful for us.
# Change this option to true to disable reporting.
reporting-disabled = false

###
### [meta]
###
### Controls the parameters for the Raft consensus group that stores metadata
### about the InfluxDB cluster.
###

[meta]
  dir = "/var/opt/influxdb/meta"
  hostname = "localhost"
  bind-address = ":8088"
  retention-autocreate = true
  election-timeout = "1s"
  heartbeat-timeout = "1s"
  leader-lease-timeout = "500ms"
  commit-timeout = "50ms"

###
### [data]
###
### Controls where the actual shard data for InfluxDB lives and how it is
### flushed from the WAL. "dir" may need to be changed to a suitable place
### for your system, but the WAL settings are an advanced configuration. The
### defaults should work for most systems.
###

[data]
  dir = "/var/opt/influxdb/data"

  # Controls the engine type for new shards.
  # engine ="bz1"

  # The following WAL settings are for the b1 storage engine used in 0.9.2. They won't
  # apply to any new shards created after upgrading to a version > 0.9.3.
  max-wal-size = 104857600 # Maximum size the WAL can reach before a flush. Defaults to 100MB.
  wal-flush-interval = "10m" # Maximum time data can sit in WAL before a flush.
  wal-partition-flush-delay = "2s" # The delay time between each WAL partition being flushed.

  # These are the WAL settings for the storage engine >= 0.9.3
  wal-dir = "/var/opt/influxdb/wal"
  wal-enable-logging = true

  # When a series in the WAL in-memory cache reaches this size in bytes it is marked as ready to
  # flush to the index
  # wal-ready-series-size = 25600

  # Flush and compact a partition once this ratio of series are over the ready size
  # wal-compaction-threshold = 0.6

  # Force a flush and compaction if any series in a partition gets above this size in bytes
  # wal-max-series-size = 2097152

  # Force a flush of all series and full compaction if there have been no writes in this
  # amount of time. This is useful for ensuring that shards that are cold for writes don't
  # keep a bunch of data cached in memory and in the WAL.
  # wal-flush-cold-interval = "10m"

  # Force a partition to flush its largest series if it reaches this approximate size in
  # bytes. Remember there are 5 partitions so you'll need at least 5x this amount of memory.
  # The more memory you have, the bigger this can be.
  # wal-partition-size-threshold = 20971520

###
### [cluster]
###
### Controls non-Raft cluster behavior, which generally includes how data is
### shared across shards.
###

[cluster]
  shard-writer-timeout = "5s" # The time within which a shard must respond to write.
  write-timeout = "5s" # The time within which a write operation must complete on the cluster.

###
### [retention]
###
### Controls the enforcement of retention policies for evicting old data.
###

[retention]
  enabled = true
  check-interval = "30m"

###
### Controls the system self-monitoring, statistics and diagnostics.
###
### The retention policy for this data is the default retention policy within
### the internal database. The internal database is created automatically if
### if it does not already exist, as is the default retention policy. If you
### want to use a non-default retention policy, it must be explicitly created.

[monitor]
  store-enabled = true # Whether to record statistics internally.
  store-database = "_internal" # The destination database for recorded statistics
  store-interval = "10s" # The interval at which to record statistics

###
### [admin]
###
### Controls the availability of the built-in, web-based admin interface. If HTTPS is
### enabled for the admin interface, HTTPS must also be enabled on the [http] service.
###

[admin]
  enabled = true
  bind-address = ":8083"
  https-enabled = false
  https-certificate = "/etc/ssl/influxdb.pem"

###
### [http]
###
### Controls how the HTTP endpoints are configured. These are the primary
### mechanism for getting data into and out of InfluxDB.
###

[http]
  enabled = true
  bind-address = ":8086"
  auth-enabled = false
  log-enabled = true
  write-tracing = false
  pprof-enabled = false
  https-enabled = false
  https-certificate = "/etc/ssl/influxdb.pem"

###
### [[graphite]]
###
### Controls one or many listeners for Graphite data.
###

[[graphite]]
  enabled = false
  # bind-address = ":2003"
  # protocol = "tcp"
  # consistency-level = "one"
  # name-separator = "."

  # These next lines control how batching works. You should have this enabled
  # otherwise you could get dropped metrics or poor performance. Batching
  # will buffer points in memory if you have many coming in.

  # batch-size = 1000 # will flush if this many points get buffered
  # batch-pending = 5 # number of batches that may be pending in memory
  # batch-timeout = "1s" # will flush at least this often even if we haven't hit buffer limit

  ## "name-schema" configures tag names for parsing the metric name from graphite protocol;
  ## separated by `name-separator`.
  ## The "measurement" tag is special and the corresponding field will become
  ## the name of the metric.
  ## e.g. "type.host.measurement.device" will parse "server.localhost.cpu.cpu0" as
  ## {
  ##     measurement: "cpu",
  ##     tags: {
  ##         "type": "server",
  ##         "host": "localhost,
  ##         "device": "cpu0"
  ##     }
  ## }
  # name-schema = "type.host.measurement.device"

  ## If set to true, when the input metric name has more fields than `name-schema` specified,
  ## the extra fields will be ignored.
  ## Otherwise an error will be logged and the metric rejected.
  # ignore-unnamed = true

###
### [collectd]
###
### Controls the listener for collectd data.
###

[collectd]
    enabled = true
    bind-address = "127.0.0.1:25826"
    database = "collectd"
    typesdb = "/usr/share/collectd/types.db"

  # These next lines control how batching works. You should have this enabled
  # otherwise you could get dropped metrics or poor performance. Batching
  # will buffer points in memory if you have many coming in.

  # batch-size = 1000 # will flush if this many points get buffered
  # batch-pending = 5 # number of batches that may be pending in memory
  # batch-timeout = "1s" # will flush at least this often even if we haven't hit buffer limit

###
### [opentsdb]
###
### Controls the listener for OpenTSDB data.
###

[opentsdb]
  enabled = false
  # bind-address = ""
  # database = ""
  # retention-policy = ""

  # These next lines control how batching works. You should have this enabled
  # otherwise you could get dropped metrics or poor performance. Only points
  # metrics received over the telnet protocol undergo batching.

  # batch-size = 1000 # will flush if this many points get buffered
  # batch-pending = 5 # number of batches that may be pending in memory
  # batch-timeout = "1s" # will flush at least this often even if we haven't hit buffer limit

###
### [[udp]]
###
### Controls the listeners for InfluxDB line protocol data via UDP.
###

[[udp]]
  enabled = false
  # bind-address = ""
  # database = ""

  # These next lines control how batching works. You should have this enabled
  # otherwise you could get dropped metrics or poor performance. Batching
  # will buffer points in memory if you have many coming in.

  # batch-size = 1000 # will flush if this many points get buffered
  # batch-pending = 5 # number of batches that may be pending in memory
  # batch-timeout = "1s" # will flush at least this often even if we haven't hit buffer limit

###
### [continuous_queries]
###
### Controls how continuous queries are run within InfluxDB.
###

[continuous_queries]
  log-enabled = true
  enabled = true
  recompute-previous-n = 2
  recompute-no-older-than = "10m"
  compute-runs-per-interval = 10
  compute-no-more-than = "2m"

###
### [hinted-handoff]
###
### Controls the hinted handoff feature, which allows nodes to temporarily
### store queued data when one node of a cluster is down for a short period
### of time.
###

[hinted-handoff]
  enabled = true
  dir = "/var/opt/influxdb/hh"
  max-size = 1073741824
  max-age = "168h"
  retry-rate-limit = 0
  retry-interval = "1s"
   | EOT

$dashboard_json = @(EOT)
{
  "id": 2,
  "title": "Dashboard.json",
  "originalTitle": "Dashboard.json",
  "tags": [],
  "style": "dark",
  "timezone": "utc",
  "editable": true,
  "hideControls": false,
  "sharedCrosshair": false,
  "rows": [
    {
      "collapse": false,
      "editable": true,
      "height": "250px",
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "collectd",
          "editable": true,
          "error": false,
          "fill": 1,
          "grid": {
            "leftLogBase": 1,
            "leftMax": null,
            "leftMin": null,
            "rightLogBase": 1,
            "rightMax": null,
            "rightMin": null,
            "threshold1": null,
            "threshold1Color": "rgba(216, 200, 27, 0.27)",
            "threshold2": null,
            "threshold2Color": "rgba(234, 112, 112, 0.22)"
          },
          "id": 1,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "span": 12,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "LONG",
              "fields": [
                {
                  "func": "mean",
                  "name": "value"
                }
              ],
              "groupBy": [
                {
                  "interval": "auto",
                  "type": "time"
                }
              ],
              "measurement": "load_longterm",
              "query": "SELECT mean(\"value\") AS \"value\" FROM \"load_longterm\" WHERE \"host\" = 'metrics-stack-puppet-profile.vm' AND $timeFilter GROUP BY time($interval)",
              "refId": "A",
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "metrics-stack-puppet-profile.vm"
                }
              ]
            },
            {
              "alias": "MID",
              "fields": [
                {
                  "func": "mean",
                  "name": "value"
                }
              ],
              "groupBy": [
                {
                  "interval": "auto",
                  "type": "time"
                }
              ],
              "measurement": "load_midterm",
              "query": "SELECT mean(\"value\") AS \"value\" FROM \"load_midterm\" WHERE \"host\" = 'metrics-stack-puppet-profile.vm' AND $timeFilter GROUP BY time($interval)",
              "refId": "B",
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "metrics-stack-puppet-profile.vm"
                }
              ]
            },
            {
              "alias": "SHORT",
              "fields": [
                {
                  "func": "mean",
                  "name": "value"
                }
              ],
              "groupBy": [
                {
                  "interval": "auto",
                  "type": "time"
                }
              ],
              "measurement": "load_shortterm",
              "query": "SELECT mean(\"value\") AS \"value\" FROM \"load_shortterm\" WHERE \"host\" = 'metrics-stack-puppet-profile.vm' AND $timeFilter GROUP BY time($interval)",
              "refId": "C",
              "tags": [
                {
                  "key": "host",
                  "operator": "=",
                  "value": "metrics-stack-puppet-profile.vm"
                }
              ]
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "Load",
          "tooltip": {
            "shared": true,
            "value_type": "cumulative"
          },
          "type": "graph",
          "x-axis": true,
          "y-axis": true,
          "y_formats": [
            "short",
            "short"
          ]
        }
      ],
      "title": "Row"
    },
    {
      "collapse": false,
      "editable": true,
      "height": "250px",
      "panels": [
        {
          "aliasColors": {},
          "bars": false,
          "datasource": "collectd",
          "editable": true,
          "error": false,
          "fill": 1,
          "grid": {
            "leftLogBase": 1,
            "leftMax": null,
            "leftMin": null,
            "rightLogBase": 1,
            "rightMax": null,
            "rightMin": null,
            "threshold1": null,
            "threshold1Color": "rgba(216, 200, 27, 0.27)",
            "threshold2": null,
            "threshold2Color": "rgba(234, 112, 112, 0.22)"
          },
          "id": 2,
          "legend": {
            "avg": false,
            "current": false,
            "max": false,
            "min": false,
            "show": true,
            "total": false,
            "values": false
          },
          "lines": true,
          "linewidth": 2,
          "links": [],
          "nullPointMode": "connected",
          "percentage": false,
          "pointradius": 5,
          "points": false,
          "renderer": "flot",
          "seriesOverrides": [],
          "span": 12,
          "stack": false,
          "steppedLine": false,
          "targets": [
            {
              "alias": "Received",
              "fields": [
                {
                  "func": "mean",
                  "name": "value"
                }
              ],
              "groupBy": [
                {
                  "interval": "auto",
                  "type": "time"
                }
              ],
              "measurement": "interface_rx",
              "query": "SELECT mean(\"value\") AS \"value\" FROM \"interface_rx\" WHERE $timeFilter GROUP BY time($interval)",
              "rawQuery": false,
              "refId": "A",
              "tags": []
            },
            {
              "alias": "Transmitted",
              "fields": [
                {
                  "func": "mean",
                  "name": "value"
                }
              ],
              "groupBy": [
                {
                  "interval": "auto",
                  "type": "time"
                }
              ],
              "measurement": "interface_tx",
              "query": "SELECT mean(\"value\") AS \"value\" FROM \"interface_tx\" WHERE $timeFilter GROUP BY time($interval)",
              "rawQuery": false,
              "refId": "B",
              "tags": []
            }
          ],
          "timeFrom": null,
          "timeShift": null,
          "title": "eth0",
          "tooltip": {
            "shared": true,
            "value_type": "cumulative"
          },
          "type": "graph",
          "x-axis": true,
          "y-axis": true,
          "y_formats": [
            "Bps",
            "short"
          ]
        }
      ],
      "title": "New row"
    },
    {
      "collapse": false,
      "editable": true,
      "height": "250px",
      "panels": [],
      "title": "New row"
    }
  ],
  "time": {
    "from": "now-5m",
    "to": "now"
  },
  "timepicker": {
    "now": true,
    "refresh_intervals": [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d"
    ],
    "time_options": [
      "5m",
      "15m",
      "1h",
      "6h",
      "12h",
      "24h",
      "2d",
      "7d",
      "30d"
    ]
  },
  "templating": {
    "list": []
  },
  "annotations": {
    "list": []
  },
  "refresh": false,
  "schemaVersion": 7,
  "version": 2,
  "links": []
}
|EOT

  # TODO - Replace this with:
  # include packagecloud
  #
  # packagecloud::repo { "chriscowleyunix/monitoring":
  #  type => 'rpm',
  # }
  exec {'/usr/bin/yum install http://dl.marmotte.net/rpms/redhat/el6/x86_64/collectd-5.5.0-1.el6/collectd-5.5.0-1.el6.x86_64.rpm -y':
    unless => '/bin/rpm -qa | grep collectd | grep 5.5.0'
  }
  ->
  # Requires fork of module where you can define content
  class { '::collectd':
    conf_content => $collectd_conf_content,
  }
  ->
  # Replace with profile to install influxdb
  exec {'/usr/bin/yum install http://influxdb.s3.amazonaws.com/influxdb-0.9.4.2-1.x86_64.rpm -y':
    unless => '/bin/rpm -qa | grep influxdb | grep 0.9.4'
  }
  ->
  file { '/etc/opt/influxdb/influxdb.conf':
    ensure   => 'file',
    group    => '0',
    mode     => '0664',
    owner    => '0',
    content  => $influxdb_conf,
  }
  service {'influxdb':
    ensure  => running,
    enable  => true,
  }
  ->
  class { 'grafana':
    version => '2.5.0',
  }
  ->
  grafana_datasource { 'collectd':
    ensure           => present,
    type             => 'influxdb',
    url              => "http://127.0.0.1:8086",
    user             => 'root',
    password         => 'root',
    database         => 'collectd',
    access_mode      => 'proxy',
    is_default       => true,
    grafana_url      => "http://127.0.0.1:3000",
    grafana_user     => 'admin',
    grafana_password => 'admin',
  }
  ->
  grafana_dashboard { 'CollectD Stats':
    ensure           => present,
    grafana_url      => "http://127.0.0.1:3000",
    grafana_user     => 'admin',
    grafana_password => 'admin',
    content          => $dashboard_json,
  }

