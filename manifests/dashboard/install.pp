class puppet::dashboard::install {

  package{$puppet::params::puppet_dashboard_package:
    ensure => present
  }
}
