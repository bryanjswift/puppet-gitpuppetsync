class gitpuppetsync::librarian {

  $ruby_version = $gitpuppetsync::ruby_version

  package { "build-essential":
    ensure => latest,
    name   => "build-essential",
  }

  package { "ruby-dev":
    ensure  => latest,
    name    => "ruby${ruby_version}-dev",
    require => [Package["build-essential"]],
  }

  exec { "Install librarian-puppet":
    command => "gem install librarian-puppet",
    creates => "/usr/local/bin/librarian-puppet",
    path    => ["/usr/local/bin", "/usr/bin", "/bin"],
    require => [Package["ruby-dev"]],
    user    => "root",
  }

}
