class puppet::params {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/:{

      $puppet_master_package = 'puppetmaster'

    }
    /^(Redhat|CentOS)$/: {

      $puppet_master_package = 'puppet-server'

    }
    default:{
      fail("${::operatingsystem} not supported")
    }
  }

  $puppet_agent_package             = 'puppet'
  $puppet_db_package                = 'puppetdb'
  $puppet_dashboard_package         = 'puppet-dashboard'
  $puppet_terminus_package          = 'puppetdb-terminus'
  $puppet_hiera_package             = 'hiera-puppet'
  $puppet_master_service            = 'puppetmaster'
  $puppet_agent_service             = 'puppet'
  $puppet_db_service                = 'puppetdb'
  $puppet_dashboard_service         = 'puppet-dashboard'
  $puppet_dashboard_workers_service = 'puppet-dashboard-workers'

  $puppet_config_dir                = hiera('puppet_config_dir')
  $puppet_config_file               = hiera('puppet_config_file')
  $puppet_config_db_dir             = hiera('puppet_config_db_dir')
  $puppet_config_db_file            = hiera('puppet_config_db_file')
  $puppet_config_routes_db_file     = hiera('puppet_config_routes_db_file')
  $puppet_config_dashboard_dir      = hiera('puppet_config_dashboard_dir')
  $puppet_server                    = hiera('puppet_server')
  $puppet_certname                  = hiera('puppet_certname')
  $puppet_db                        = hiera('puppet_db')
  $puppet_modulepath                = hiera('puppet_modulepath')
  $puppet_dashboard                 = hiera('puppet_dashboard')
  $puppet_dashboard_db              = hiera('puppet_dashboard_db')
  $puppet_dashboard_db_host         = hiera('puppet_dashboard_db_host')
  $puppet_dashboard_db_user         = hiera('puppet_dashboard_db_user')
  $puppet_dashboard_db_pass         = hiera('puppet_dashboard_db_pass')
  $puppet_dashboard_home            = '/usr/share/puppet-dashboard'

  $puppet_dashboard_htpasswd_file   = hiera('htpasswd_file')
  $puppet_dashboard_htpasswd_user   = 'dashboard'
  $puppet_dashboard_htpasswd_pass   = 'd4shb04rd'

}
