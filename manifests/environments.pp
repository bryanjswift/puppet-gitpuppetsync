class gitpuppetsync::environments {

  file { "Puppet Environments":
    ensure => directory,
    mode   => 'a=rx,u+w',
    owner  => $gitpuppetsync::repository_user,
    path   => $gitpuppetsync::environments_dir,
  }

}
