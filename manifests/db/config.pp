class puppet::db::config {

  file{ 'puppet_jetty_db_config':
    ensure  => present,
    path    => "${puppet::params::puppet_config_db_dir}/conf.d/jetty.ini",
    content => template("${module_name}/puppet_db_jetty.ini.erb"),
    owner   => 'puppetdb',
    group   => 'puppetdb',
    mode    => '0640',
  }
}
