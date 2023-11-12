## Levels of Testing
* Linting and syntax testing: puppet-lint
* Unit and integration testing: puppet-rspec
* Acceptance and manual testing: beaker

## Setting up the base level
* puppet parser validate example.pp # doesnt require any additional setup. it comes with puppet
* gem install puppet-lint # commonly used testing
```
puppet-lint example.pp
```
* gem install rspec-puppet puppetlabs_spec_helper rspec-puppet-facts

## generating modules and classes using pdk
```
sudo rpm -Uvh https://yum.puppet.com/puppet-tools-release-el-8.noarch.rpm
sudo yum install pdk -y

pdk new module rspec_example
cd rspec_example/
pdk new class rspec_example

rspec ## test the puppet files inside rspec_example directory
```