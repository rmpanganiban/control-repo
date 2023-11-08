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
