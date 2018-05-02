class profiles::grafana {

  class { '::grafana':
    version        => '5.1.0',
    install_method => 'repo',
  }
  ->
  grafana_datasource { 'Graphite':
    ensure           => present,
    type             => 'graphite',
    url              => 'http://127.0.0.1:80',
    access_mode      => 'proxy',
    is_default       => true,
    grafana_url      => 'http://127.0.0.1:3000',
    grafana_user     => 'admin',
    grafana_password => 'admin',
  }
  ->
  grafana_dashboard { 'CollectD Stats from Graphite':
    ensure           => present,
    grafana_url      => 'http://127.0.0.1:3000',
    grafana_user     => 'admin',
    grafana_password => 'admin',
    content          => template('profiles/grafana_dashboard.json.erb'),
  }

}
