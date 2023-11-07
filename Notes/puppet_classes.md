## Classes
- Puppet classes help keep your code organized. This is a quick review of classes parameters and inheritance.
- Puppet class is a simple way of organizing code

## Basic class definition

```
# class definition
class motd {
  file {'Message of the day':
    path    => '/etc/motd',
    ensure  => file,
    content => 'This is a message of the day!',
  }
}

# class declaration
class { 'motd':
  ensure => present,
}
```

Classes are just a way of abstracting away a block of code. So this class declaration is roughly equivalent to copying and pasting the contents of the class definition, so that any resources that are in the class definition will be declared at that point.

## Another way of declaring a class - Parameterized class
```
class profile::motd (
  String $message = 'This is the default message',
) inherits profile::params {
  file {'Message of the day':
    path    => '/etc/motd',
    ensure  => file,
    content => $message,
  }
}
```
There's a word, profile, and then two colons, and then the word M-O-T-D. This means that the M-O-T-D class is under the scope of the profile module. In fact you'll sometimes hear the colon colon referred to as a scope character. It's possible to have multiple levels of this, so you could have profile, scope, system, scope, M-O-T-D.

## Params Class
```
class profile::params {
  case $::osfamily {
    'Windows': {
      $admin_user = 'Administrator'
    }
    'RedHat': {
      $admin_user = 'root'
    }
    default: {
      fail('Unsopported OS')
    }
  }
}
```
A params class is where you set default parameters that aren't configurable within the module. Quite often this relates to the operating system the module supports.