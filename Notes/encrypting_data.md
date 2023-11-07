## Install EYAML or Encrypted YAML

```gem install hiera-eyaml```

## Create encrypted keys

```
eyaml createkeys
mv keys/ /etc/puppetlabs/puppet/eyaml
chown -R puppet:puppet /etc/puppetlabs/puppet/eyaml
chmod -R 0500 /etc/puppetlabs/puppet/eyaml
chmod -R 0400 /etc/puppetlabs/puppet/eyaml/*.pem
```