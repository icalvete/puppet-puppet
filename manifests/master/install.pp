class puppet::master::install {

  package{$puppet::params::puppet_master_package:
    ensure => present
  }
  package{$puppet::params::puppet_agent_package:
    ensure => present
  }
}
