class profiles::influxdb {

  class {'::influxdb::server':
    version       => '0.9.6.1-1',
    # Using template until https://github.com/n1tr0g/golja-influxdb/issues/23 resolved
    conf_template => 'profiles/influxdb.conf.erb',
  }

  file {'/var/opt/influxdb/':
    ensure  => directory,
    owner   => 'influxdb',
    group   => 'influxdb',
    recurse => true,
  }

  File['/var/opt/influxdb/'] ~> Service['influxdb']

}
