class puppet::master::config (

  $puppet_env = $puppet::params::env,

) {

  file{ 'puppet_master_config':
    ensure  => present,
    path    => "${puppet::params::puppet_config_dir}/${puppet::params::puppet_config_file}",
    content => template("${module_name}/puppet_master.conf.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $puppet::master::puppet_db {
    $enable_db = 'present'
  } else {
    $enable_db = 'absent'
  }

  file{ 'puppet_db_config':
    ensure  => $enable_db,
    path    => "${puppet::params::puppet_config_dir}/${puppet::params::puppet_config_db_file}",
    content => template("${module_name}/puppet_db.conf.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file{ 'puppet_routes_db_config':
    ensure  => $enable_db,
    path    => "${puppet::params::puppet_config_dir}/${puppet::params::puppet_config_routes_db_file}",
    content => template("${module_name}/puppet_routes_db.conf.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $puppet::master::puppet_dashboard_db_host {

    file{ 'puppet_external_node_config':
      ensure  => $enable_db,
      path    => "${puppet::params::puppet_config_dir}//external_node",
      content => template("${module_name}/external_node.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
    }

  }
}
