class puppet::db::service {

  service{ $puppet::params::puppet_db_service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
