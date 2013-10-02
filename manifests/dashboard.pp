# == Class: puppet:dashboard
#
# === Parameters:
#
# [*web_server*]
#   Using a external webserver.
#   Default: false
#
# [*puppet_dashboard_port*]
#   Port where puppet dashboard runs.
#   Default: hiera('puppet_dashboard_port')
#
# === Actions:
#
# Install and configure puppet dashboard
#
# === Requires:
#
# Before install hiera, you need set the parameters to avoid missing default values.
#
# === Authors:
#
# Israel Calvete Talavera <icalvete@gmail.com>
#

class puppet::dashboard (

  $web_server            = false,
  $puppet_dashboard_port = $puppet::params::puppet_dashboard_port,

) inherits puppet::params {

  anchor {'puppet::dashboard::begin':
    before  => Class['puppet::dashboard::install']
  }

  class {'puppet::dashboard::install':
    require => Anchor['puppet::dashboard::end']
  }

  class {'puppet::dashboard::config':
    require => Class['puppet::dashboard::install']
  }

  class {'puppet::dashboard::service':
    subscribe => Class['puppet::dashboard::config']
  }

  anchor {'puppet::dashboard::end':
    before  => Class['puppet::dashboard::service']
  }
}
