class puppet::agent::install {

  package{$puppet::params::puppet_agent_package:
    ensure => present
  }
}
