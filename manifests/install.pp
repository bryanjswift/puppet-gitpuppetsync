class gitpuppetsync::install {

  File {
    ensure  => directory,
    group   => "root",
    owner   => "root",
    mode    => 0755,
  }

  file { "/usr/local":
    path => "/usr/local",
  }

  file { "/usr/local/bin":
    path    => "/usr/local/bin",
    require => [File["/usr/local"]],
  }

  file { "Install puppet-sync":
    ensure  => present,
    group   => "root",
    mode    => 0755,
    owner   => "root",
    path    => "/usr/local/bin/puppet-sync",
    require => [File["/usr/local/bin"]],
    source  => "puppet:///modules/gitpuppetsync/puppet-sync",
  }

}
