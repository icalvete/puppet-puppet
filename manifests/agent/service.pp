class puppet::agent::service {

  service{ $puppet::params::puppet_agent_service:
    ensure     => stopped,
    enable     => false,
    hasstatus  => true,
    hasrestart => true,
  }

}
