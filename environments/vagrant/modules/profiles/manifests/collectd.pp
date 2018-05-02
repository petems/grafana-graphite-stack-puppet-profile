class profiles::collectd {

  include ::epel

  class { '::collectd':
    package_ensure => '5.8.0',
    typesdb        => [
      '/usr/share/collectd/types.db',
    ],
    require        => Class['::epel'],
  }

  class { '::collectd::plugin::logfile':
    log_level => 'debug',
    log_file  => '/var/log/collected.log',
  }

  if $ipaddress_enp0s8 {
    $interfaces_to_monitor = ['enp0s8','enp0s3']
  } else {
    $interfaces_to_monitor = ['eth0']
  }

  class { '::collectd::plugin::interface':
    interfaces     => $interfaces_to_monitor,
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
