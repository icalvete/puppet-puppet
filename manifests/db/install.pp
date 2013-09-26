class puppet::db::install {

  package{$puppet::params::puppet_terminus_package:
    ensure => present
  }

  package{$puppet::params::puppet_db_package:
    ensure => present
  }
}
