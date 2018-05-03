class profiles::graphite {

  file { '/usr/bin/pip-python':
    ensure => 'link',
    target => '/usr/bin/pip',
  }
  -> class { '::graphite':
    gr_web_cors_allow_from_all => true,
  }

}
