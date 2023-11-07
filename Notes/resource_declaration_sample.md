## Simplifying resource declaration

## Resource Defaults
```
File {
  owner => 'root',
  group => 'root',
  mode  => '0644',
}
file { '/etc/motd':
  ensure => file,
  source => 'puppet:///modules/defaults/motd',
}
file { '/etc/profile':
  ensure => file,
  source => 'puppet:///modules/defaults/profile',
}
```
Resource defaults are another nice language feature. If you're defining multiple resources in a class, and you want them all to have the same setting for one of the perimeters, you don't need to type it multiple times. Instead, you can use a capital letter for the start of the resource type name and it will apply to all resources within the local scope.

## Advanced resource syntax: defaults
```
file {
  default:
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    ensure => file
  ;
  '/etc/motd':
    source => 'puppet:///modules/defaults/motd',
  ;
  '/etc/profile':
    source => 'puppet:///modules/defaults/profile',
  ;
}
```

## Exercise: Simplify the below manifest
```
class big_ugly_mess {
  user { 'bob':
    ensure     => present,
    home       => '/var/www/bob_wide_web',
    managehome => true,
  }
  file { '/var/www/bob_wide_web/index.html':
    ensure => file,
    source => 'puppet:///big_ugly_mess/bob_wide_web/index.html'
  }
  user { 'carol':
    ensure     => present,
    home       => '/var/www/unicorn_central',
    managehome => true,
  }
  file { '/var/www/unicorn_central/index.html':
    ensure => file,
    source => 'puppet:///big_ugly_mess/unicorn_central/index.html'
  }
  user { 'alice':
    ensure     => present,
    home       => '/var/www/alice',
    managehome => true,
  }  
  file { '/var/www/alice/index.html':
    ensure => file,
    source => 'puppet:///big_ugly_mess/alice/index.html'
  }
}
```

# Solutions
```

# solution 1: Defaults
class nice_clean_defaults {
  user {
    default:
      ensure     => present,
      managehome => true
    ;
    'bob':
      home => '/var/www/bob_wide_web'
    ;
    'carol':
      home => '/var/www/unicorn_central'
    ;
    'alice':
      home => '/var/www/alice'
    ;
  }
  file {
    default:
      ensure => file
    ;
    '/var/www/bob_wide_web/index.html':
      source => 'puppet:///big_ugly_mess/bob_wide_web/index.html'
    ;
    '/var/www/unicorn_central/index.html':
      source => 'puppet:///big_ugly_mess/unicorn_central/index.html'
    ;
    '/var/www/alice/index.html':
      source => 'puppet:///big_ugly_mess/alice/index.html'
    ;
  }
}

# solution 2: each
class nice_clean_iterator {
  $web_devs = [
    {'username' => 'bob', 'site_name' => 'bob_wide_web'},
    {'username' => 'carol', 'site_name' => 'unicorn_central'},
    {'username' => 'alice', 'site_name' => 'alice'}
  ]

  $web_devs.each | $web_dev | {
    user { $web_dev['username']:
      ensure     => present,
      managehome => true,
      home       => "/var/www/${web_dev['site_name']},
    }
    file { "/var/www/${web_dev['site_name']}/index.html":
      ensure => present,
      source => "puppet:///big_ugly_mess/${web_dev['site_name']}/index.html",
    }
  }
}

# solution 3: define

# **site.pp**
class nice_clean_type {
  $web_devs = [
    {'username' => 'bob', 'site_name' => 'bob_wide_web'},
    {'username' => 'carol', 'site_name' => 'unicorn_central'},
    {'username' => 'alice', 'site_name' => 'alice'}
  ]
  nice_clean_type::web_user { $web_devs:
    ensure => present,
  }
}

# **web_user.pp**
define nice_clean_type (
  $developer
){
  user { $developer['username']:
    ensure => present,
    managehome => true,
    homedir => "/var/www/${developer['site_name']}",
  }
  file { "/var/www/${developer['site_name']}/index.html":
    ensure => file,
    source => "puppet:///big_ugly_mess/${web_dev['site_name']}/index.html",
  }
}
```