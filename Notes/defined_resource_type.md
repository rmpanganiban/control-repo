## Defined Resource Type
Often, you'll create a custom defined resource type when you have a class or a section of code that you wanna repeat multiple times.

## Defining types
The general form of a define statement is:
* The define keyword.
* The name of the defined type.
* An optional parameter list, which consists of:
  * An opening parenthesis.
    * A comma-separated list of parameters, such as: String $myparam = "default value". Each parameter consists of:
      * An optional data type, which restricts the allowed values for the parameter. If no data type is specified, values of any data type are permitted.
      * A variable name to represent the parameter, including the $ prefix, such as $parameter.
      * An optional equals = sign and default value, which must match the data type, if one was specified. If no default value is specified, the parameter is considered required and the user must specify a value.
  * An optional trailing comma after the last parameter.
  * A closing parenthesis.
  * An opening curly brace.
  * A block of arbitrary Puppet code, which generally contains at least one resource declaration
  * A closing curly brace
The definition does not cause the code in the block to be added to the catalog; it only makes it available. To add the code to the catalog, you must declare one or more resources of the defined type.

This example creates a new resource type called apache::vhost:
```
# /etc/puppetlabs/puppet/modules/apache/manifests/vhost.pp
define apache::vhost (
  Integer $port,
  String[1] $docroot,
  String[1] $servername = $title,
  String $vhost_name = '*',
) {
  include apache # contains package['httpd'] and service['httpd']
  include apache::params # contains common config settings

  $vhost_dir = $apache::params::vhost_dir

  # the template used below can access all of the parameters and variable from above.
  file { "${vhost_dir}/${servername}.conf":
    ensure  => file,
    owner   => 'www',
    group   => 'www',
    mode    => '0644',
    content => template('apache/vhost-default.conf.erb'),
    require  => Package['httpd'],
    notify    => Service['httpd'],
  }
}
```
## Declaring defined type resources
You can declare instances of a defined type—usually just called resources—the same way you declare any other resource: with a resource type, a title, and a set of attribute-value pairs. The parameters you added when defining the type, such as $port, become resource attributes, such as port, when you declare resources of the defined type.

Parameters that have a default value are considered optional parameters: if you don't specify them in the resource declaration, the default value is used. Parameters without defaults are required parameters, and you must specify a value for them when you declare the resource.

To declare a resource of the apache::vhost defined type from the example above:
```
apache::vhost {'homepages':
 port    => 8081,
 docroot => '/var/www-testhost', 
}
```