#puppet-puppet

Puppet manifest to install and configure puppet master or puppet agent 

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-puppet.png)](http://travis-ci.org/icalvete/puppet-puppet)

##Actions:

 - Install and configure puppet master
 - Install and configure puppet puppet agent
 - Install and configure [puppet db](http://docs.puppetlabs.com/puppetdb/latest/index.html)
 - Install and configure [puppet dashboard](http://docs.puppetlabs.com/dashboard/manual/1.2/)

##Requires:

Before install hiera, you need set the parameters to avoid missing default values.

* puppet and puppet master works in Debian|Ubuntu|RedHat|CentOS
* puppet db works in Debian|Ubuntu|RedHat|CentOS
* puppet dashboard works in Debian|Ubuntu|RedHat|CentOS (In RedHat|CentOS without apache2 + passenger. this use internal WEBrick)
* puppet db and puppet dashboard only works on Ubuntu
* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/icalvete/puppet-common

## Instalation:

To install the puppet master you can use puppet apply to applies manifest to the local system without a puppet master

See http://docs.puppetlabs.com/man/apply.html

##Example:

    node 'fag01.smartpurposes.com' inherits fourandgo {
      
      class {'puppet::p_master':
        puppet_config     => '/etc/puppet/puppet.conf',
        puppet_server     => 'puppet.smartpurposes.com',
        puppet_certname   => 'puppet.smartpurposes.com',
        puppet_modulepath => [ '$confdir/modules', '$confdir/modules_sp', '/usr/share/puppet/modules']
        puppet_env        => ['pro', 'pre', 'dev'],
      }
    }

    node 'fag02.smartpurposes.com' inherits fourandgo {
      
      class {'puppet::p_agent':
        puppet_config     => '/etc/puppet/puppet.conf',
        puppet_server     => 'puppet.smartpurposes.com',
        puppet_certname   => 'puppet.smartpurposes.com',
        puppet_env        => 'dev',
      }
    }

##Authors:

Israel Calvete Talavera <icalvete@gmail.com>
