class puppet::dashboard::service {

  if $puppet::dashboard::web_server {
    $ensure_puppet_dashboard_service = stopped
  } else {
    $ensure_puppet_dashboard_service = running
  }

  service{ $puppet::params::puppet_dashboard_service:
    ensure     => $ensure_puppet_dashboard_service,
    enable     => true,
    hasstatus  => true,
    hasrestart => false,
  }

  service{ $puppet::params::puppet_dashboard_workers_service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
