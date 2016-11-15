class role::metrics_server {

  include ::profiles::collectd
  include ::profiles::grafana
  include ::profiles::graphite

  Class['::profiles::graphite'] -> Class['::profiles::grafana']
}
