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

}
