class role::metrics_server {

  include ::profiles::collectd
  include ::profiles::grafana
  include ::profiles::influxdb

  Class['::profiles::collectd'] -> Class['::profiles::influxdb']

}
