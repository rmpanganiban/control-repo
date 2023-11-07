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

## Creating an encrypted file
```
eyaml edit common.yaml

# the password has to be enclosed with DEC::PKCS7[]!
# example from common.yaml file

---
secret_password: DEC(1)::PKCS7[this_password_is_very_long]!
```