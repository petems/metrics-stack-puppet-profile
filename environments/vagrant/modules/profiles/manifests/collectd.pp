class profiles::collectd {

  packagecloud::repo { "chriscowleyunix/monitoring":
    type => 'rpm',
  }
  ->
  # Requires fork of module where you can define content
  # TODO: Use proper seperated plugins for this
  class { '::collectd':
    package_ensure => '5.5.0',
    conf_content   => template('profiles/collectd.conf.erb'),
  }

  class { '::collectd::plugin::logfile':
    log_level => 'warning',
    log_file  => '/var/log/collected.log'
  }

  class { '::collectd::plugin::interface':
    interfaces     => ['eth0'],
    ignoreselected => false,
  }

  class { '::collectd::plugin::load':
  }

  collectd::plugin::network::server{'127.0.0.1':
    port => '25826',
  }

}
