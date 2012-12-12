# == Class: gitpuppetsync::postreceive
#
# Install the git post-receive hook in a specified repository. The post-receive
# hook includes a reference to where environments are stored and reference to
# where the repository lives.
#
# === Parameters
#
# [*environments_dir*]
#   The location where environments are stored. This directory will be
#   created if it doesn't exist. It must be owned by *repository_user*.
#
# [*repository_path*]
#   The path to the git repository where the post-receive hook should be
#   set up.
#
# [*repository_user*]
#   The name of the user owning the repository at *repository_path*.
#
# === Examples
#
#  gitpuppetsync::postreceive { "hostname":
#    environments_dir => "/etc/puppet/environments",
#    repository_path  => "/home/git/repositories/puppetrepo",
#    repository_user  => "git",
#  }
#
# === Authors
#
# Bryan J Swift <bryan.j.swift@gmail.com>
#
# === Copyright
#
# Copyright 2012 Bryan J Swift
#
define gitpuppetsync::postreceive(
  $environments_dir = "/etc/puppet/environments",
  $repository_path  = "",
  $repository_user  = "git",
) {

  if ($environments_dir == "") {
    fail("environments_dir must be set. The hook needs to know where to put environments")
  }

  if ($repository_path == "") {
    fail("repository_path must be set. The module needs to know what repository to effect")
  }

  file { "Puppet Environments":
    ensure => directory,
    mode   => 'a=rx,u+w',
    owner  => $repository_user,
    path   => $environments_dir,
  }

  file { "Install post-receive hook":
    content => template("gitpuppetsync/post-receive.erb"),
    ensure  => present,
    group   => $repository_user,
    mode    => 0755,
    owner   => $repository_user,
    path    => "${repository_path}/hooks/post-receive",
  }

}
