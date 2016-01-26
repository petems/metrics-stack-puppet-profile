class profiles::grafana {

  class { '::grafana':
    version => '2.5.0',
  }
  ->
  grafana_datasource { 'collectd':
    ensure           => present,
    type             => 'influxdb',
    url              => 'http://127.0.0.1:8086',
    user             => 'root',
    password         => 'root',
    database         => 'collectd',
    access_mode      => 'proxy',
    is_default       => true,
    grafana_url      => 'http://127.0.0.1:3000',
    grafana_user     => 'admin',
    grafana_password => 'admin',
  }
  ->
  grafana_dashboard { 'CollectD Stats':
    ensure           => present,
    grafana_url      => 'http://127.0.0.1:3000',
    grafana_user     => 'admin',
    grafana_password => 'admin',
    content          => template('profiles/grafana_dashboard.json.erb'),
  }

}
