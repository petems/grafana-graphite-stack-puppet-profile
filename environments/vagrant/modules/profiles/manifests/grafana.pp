class profiles::grafana {

  class { '::grafana':
    version        => '5.1.0',
    install_method => 'repo',
  }

  file { '/etc/grafana/provisioning/datasources/graphite.yaml':
    ensure  => file,
    content => template('profiles/datasource_grafana.yaml.erb'),
  }
  ~> Service['grafana-server']

  grafana_dashboard { 'CollectD Stats from Graphite':
    ensure           => present,
    grafana_url      => 'http://127.0.0.1:3000',
    grafana_user     => 'admin',
    grafana_password => 'admin',
    content          => template('profiles/grafana_dashboard.json.erb'),
  }

}
