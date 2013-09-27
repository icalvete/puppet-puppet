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

}
