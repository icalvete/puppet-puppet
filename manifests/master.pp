# == Class: puppet:master
#
# === Parameters:
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
# [*puppet_modulepath*]
#   Puppet modules path.
#   Default: hiera('puppet_modulepath') (Can be an array)
#
# [*puppet_env*]
#   Extra puppets environments. (preproduction, development...)
#   Default: undef (Can be an array)
#   See: http://docs.puppetlabs.com/guides/environment.html#configuring-environments-on-the-puppet-master
#
# === Actions:
#
# Install and configure puppet master
#
# === Requires:
#
# Before install hiera, you need set the parameters to avoid missing default values.
#
# === Authors:
#
# Israel Calvete Talavera <icalvete@gmail.com>
#
class puppet::master (

  $puppet_server            = $puppet::params::puppet_server,
  $puppet_certname          = $puppet::params::puppet_certname,
  $puppet_db                = $puppet::params::puppet_db,
  $puppet_dashboard_db_host = $puppet::params::puppet_dashboard_db_host,
  $puppet_modulepath        = $puppet::params::puppet_modulepath,
  $puppet_env               = undef

) inherits puppet::params {

  anchor {'puppet::master::begin':
    before  => Class['puppet::master::install']
  }

  class {'puppet::master::install':
    require => Anchor['puppet::master::end']
  }

  class {'puppet::master::config':
    require => Class['puppet::master::install']
  }

  class {'puppet::master::service':
    subscribe => Class['puppet::master::config']
  }

  anchor {'puppet::master::end':
    before  => Class['puppet::master::service']
  }
}
