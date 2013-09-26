class puppet::dashboard::config {

  file{ 'puppet_dashboard_config':
    ensure  => present,
    path    => "${puppet::params::puppet_config_dashboard_dir}/database.yml",
    content => template("${module_name}/puppet_dashboard_database.yml.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
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
      path    => "${apache2::params::apache2_ensites}/puppet_dashboard.vhost",
      content => template("${module_name}/puppet_dashboard.vhost.erb"),
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
      command => '/bin/sed -i \'s/3000/3333/\' /etc/default/puppet-dashboard',
      require => File['puppet_dashboard_config'],
      unless  => '/bin/grep 3333 /etc/default/puppet-dashboard'
    }
  }
}