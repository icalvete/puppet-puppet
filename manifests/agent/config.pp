class puppet::agent::config (

  $puppet_env = $puppet::params::puppet_env

) {

  file{ 'puppet_agent_config':
    ensure  => present,
    path    => "${puppet::params::puppet_config_dir}/${puppet::params::puppet_config_file}",
    content => template("${module_name}/puppet_agent.conf.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $puppet::agent::puppet_dashboard_db_host {

    file{ 'puppet_external_node_config':
      ensure  => present,
      path    => "${puppet::params::puppet_config_dir}/external_node",
      content => template("${module_name}/external_node.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0744',
    }

  }
}
