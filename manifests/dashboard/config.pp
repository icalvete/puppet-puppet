class puppet::dashboard::config {

  file {$puppet::params::puppet_config_dashboard_dir:
    ensure => directory
  }

  file { 'puppet_dashboard_config':
    ensure  => present,
    path    => "${puppet::params::puppet_config_dashboard_dir}/database.yml",
    content => template("${module_name}/puppet_dashboard_database.yml.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File[$puppet::params::puppet_config_dashboard_dir]
  }

  exec {'db_puppet_dashboard_migrate':
    cwd         => $puppet::params::puppet_dashboard_home,
    command     => '/usr/bin/rake db:migrate',
    environment => 'RAILS_ENV=production',
    require     => File['puppet_dashboard_config']
  }

  exec {'puppet-dashboard-workers_default_start_config':
    cwd     => '/tmp',
    command => '/bin/echo START=yes >> /etc/default/puppet-dashboard-workers',
    require => File['puppet_dashboard_config'],
    unless  => '/bin/grep -e "^START=yes" /etc/default/puppet-dashboard-workers'
  }

  #concat {'puppet-dashboard-workers_default_config' :
  #  path    => '/etc/default/puppet-dashboard-workers',
  #  require => Exec['db_puppet_dashboard_migrate']
  #}

  #concat::fragment {'puppet-dashboard-workers_default_config_start':
  #  target  => '/etc/default/puppet-dashboard-workers',
  #  content => "START=yes",
  #  order   => 90,
  #}

  if $puppet::dashboard::web_server {

    htpasswd::user {$puppet::params::puppet_dashboard_htpasswd_user:
      file     => $puppet::params::puppet_dashboard_htpasswd_file,
      password => $puppet::params::puppet_dashboard_htpasswd_pass,
    }

    file{ 'puppet_dashboard_vhost':
      ensure  => present,
      path    => "${apache2::params::ensites}/puppet_dashboard.vhost.conf",
      content => template("${module_name}/puppet_dashboard.vhost.conf.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }

  } else {

    exec {'puppet-dashboard_default_start_config':
      cwd     => '/tmp',
      command => '/bin/echo START=yes >> /etc/default/puppet-dashboard',
      require => File['puppet_dashboard_config'],
      unless  => '/bin/grep -e "^START=yes" /etc/default/puppet-dashboard'
    }

    exec {'puppet-dashboard_default_port_config':
      cwd     => '/tmp',
      command => "/bin/sed -i \'s/3000/${puppet::dashboard::puppet_dashboard_port}/\' /etc/default/puppet-dashboard",
      require => File['puppet_dashboard_config'],
      unless  => "/bin/grep ${puppet::dashboard::puppet_dashboard_port} /etc/default/puppet-dashboard"
    }
  }
}
