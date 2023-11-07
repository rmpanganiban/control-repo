node puppet.localdomain {
  include role::master
  file {'secret_password':
    path    => /etc/secret_password.txt,
    ensure  => file,
    content => lookup('secret_password'),
  }
}