class profiles::collectd {

  packagecloud::repo { 'chriscowleyunix/monitoring':
    type => 'rpm',
  }
  ->
  class { '::collectd':
    package_ensure => '5.5.0',
    typesdb        => [
      '/usr/share/collectd/types.db',
    ],
  }

  class { '::collectd::plugin::logfile':
    log_level => 'warning',
    log_file  => '/var/log/collected.log',
  }

  class { '::collectd::plugin::interface':
    interfaces     => ['eth0'],
    ignoreselected => false,
  }

  class { '::collectd::plugin::load':
  }

  collectd::plugin::write_graphite::carbon {'my_graphite':
    graphitehost   => 'grafana-graphite-stack-puppet-profile.vm',
    graphiteport   => '2003',
    graphiteprefix => '',
    protocol       => 'tcp',
  }

}
