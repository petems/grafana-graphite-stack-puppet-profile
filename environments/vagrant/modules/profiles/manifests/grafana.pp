class profiles::grafana {

  class { '::grafana':
    version        => '5.1.0',
    install_method => 'repo',
  }

  Package['grafana']
  -> file { '/etc/grafana/provisioning/datasources/graphite.yaml':
    ensure  => file,
    content => template('profiles/datasource_grafana.yaml.erb'),
  }
  ~> Service['grafana-server']

  Package['grafana']
  -> file { '/etc/grafana/provisioning/dashboards/base_stats.yaml':
    ensure  => file,
    content => template('profiles/base_stats.yaml.erb'),
  }
  ~> Service['grafana-server']

  Package['grafana']
  -> file { '/etc/grafana/provisioning/dashboards/base_stas.json':
    ensure  => file,
    content => template('profiles/grafana_dashboard.json.erb'),
  }
  ~> Service['grafana-server']

}
