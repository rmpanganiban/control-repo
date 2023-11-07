## Relationship Metaparameters
```
# require metaparameter
file {'/etc/nginx/nginx.conf':
  ensure  => file,
  source  => 'puppet:///modules/dag_example/nginx.conf',
  require => Package['nginx'],
}
service {'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/nginx.conf'],
}
package{'nginx':
  ensure => present,
}
```
Require just means that the resource reference has to happen before this one. Instead of `require`, we could've used `subscribe`. This sets up the same relationship but adds one difference. When using `subscribe`, it means that every time one resource changes, anything that's subscribed to it will be triggered when Puppet runs. In our example, it would make sense to use `subscribe` for the service. That way any time we update the config file with Puppet, the service will also restart to pick up the changes. You can also define these relationships the other way around. Instead of saying that a resource requires another, you can say a resource is before another. So in our example, we would set the `before` parameter on the package so that it happens before the file, and instead of subscribe, we would use the `notify` parameter. In this case, we'd set the file to notify the service any time it changes. So even though there are four keywords for defining relationships, there are really only two types of relationships that can be defined. A `before slash` require type and a `notify slash` subscribe type. The keywords just let you approach it from a different perspective. It makes no difference to Puppet which perspective you use, although sometimes using one over the other might save you a lot of typing. 

```
# before and notify metaparameter
file {'/etc/nginx/nginx.conf':
  ensure  => file,
  source  => 'puppet:///modules/dag_example/nginx.conf',
  notify => Service['nginx'],
}
service {'nginx':
  ensure  => running,
  enable  => true,
}
package{'nginx':
  ensure => present,
  before => [File['/etc/nginx/nginx.conf'],Service['nginx']],
}
```