class puppet::master::service {

  service{ $puppet::params::puppet_master_service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
