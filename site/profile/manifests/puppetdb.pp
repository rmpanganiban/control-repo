class profile::puppetdb {
  class { 'puppetdb': }
  
  # Configure the Puppet master to use puppetdb
  class { 'puppetdb::master::config': }
}