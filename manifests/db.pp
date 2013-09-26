# == Class: puppet:db
#
# === Parameters:
#
# [*puppet_server*]
#   Puppet server.
#   Default: hiera('puppet_server')
#
# === Actions:
#
# Install and configure puppet db
#
# === Requires:
#
# Before install hiera, you need set the parameters to avoid missing default values.
#
# === Authors:
#
# Israel Calvete Talavera <icalvete@gmail.com>
#
class puppet::db (

  $puppet_server           = $puppet::params::puppet_server,

) inherits puppet::params {

  anchor {'puppet::db::begin':
    before  => Class['puppet::db::install']
  }

  class {'puppet::db::install':
    require => Anchor['puppet::db::end']
  }

  class {'puppet::db::config':
    require => Class['puppet::db::install']
  }

  class {'puppet::db::service':
    subscribe => Class['puppet::db::config']
  }

  anchor {'puppet::db::end':
    before  => Class['puppet::db::service']
  }
}
