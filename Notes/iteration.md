## Each
```
$user = ['carol','bob','alice']

$user.each | $username | {
  user { $username:
    ensure     => present,
    home       => "/var/www/${username}",
    managehome => true,
  }
}
```

## Each with a Hash
```
{
  'carol' => '/var/www/carols_website',
  'bob'   => '/var/www/the_bob_wide_web',
  'alice' => '/var/www/unicorn_central',
}.each | $username, $homedir | {
  user { $username:
    home       => $homedir,
    managehome => true,
  }
}
```