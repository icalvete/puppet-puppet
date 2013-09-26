# == Class: puppet:agent
#
# === Parameters:
#
# [*puppet_config*]
#   Puppet configuration file (with path).
#   Default: hiera('puppet_config')
#
# [*puppet_server*]
#   Puppet server.
#   Default: hiera('puppet_server')
#
# [*puppet_certname*]
#   Puppet CA.
#   Default: hiera('puppet_certname')
#
# [*puppet_db*]
#   Puppet DB.
#   Default: hiera('puppet_db')
#   false to disable
#
# [*puppet_dashboard_db_host*]
#   Puppet dashboard.
#   Default: hiera('dashboard_db_host')
#   false to disable
#
# [*puppet_env*]
#   Puppets environment for this node.
#   Default: undef (So master)
#   See: http://docs.puppetlabs.com/guides/environment.html#configuring-environments-for-agent-nodes
#
# === Actions:
#
# Install and configure puppet agent
#
# === Requires:
#
# Before install hiera, you need set the parameters to avoid missing default values.
#
# === Authors:
#
# Israel Calvete Talavera <icalvete@gmail.com>
#
class puppet::agent (

  $puppet_config            = $puppet::params::puppet_config,
  $puppet_server            = $puppet::params::puppet_server,
  $puppet_certname          = $puppet::params::puppet_certname,
  $puppet_dashboard_db_host = $puppet::params::puppet_dashboard_db_host,
  $puppet_env               = undef,

) inherits puppet::params {

  anchor {'puppet::agent::begin':
    before  => Class['puppet::agent::install']
  }

  class {'puppet::agent::install':
    require => Anchor['puppet::agent::end']
  }

  class {'puppet::agent::config':
    require => Class['puppet::agent::install']
  }

  class {'puppet::agent::service':
    require => Class['puppet::agent::config']
  }

  anchor {'puppet::agent::end':
    before  => Class['puppet::agent::service']
  }
}
