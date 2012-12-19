# == Class: gitpuppetsync::postreceive
#
# Install the git post-receive hook in a specified repository. The post-receive
# hook includes a reference to where environments are stored and reference to
# where the repository lives.
#
# === Parameters
#
# [*repository_path*]
#   The path to the git repository where the post-receive hook should be
#   set up.
#
# === Examples
#
#  gitpuppetsync::postreceive { "hostname":
#    repository_path  => "/home/git/repositories/puppetrepo",
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
  $repository_path  = "",
) {

  if ($repository_path == "") {
    fail("repository_path must be set. The module needs to know what repository to effect")
  }

  validate_absolute_path($repository_path)

  $environments_dir = $gitpuppetsync::environments_dir

  file { "${repository_path}/hooks":
    ensure => directory,
    noop   => true,
  } ->

  file { "Install post-receive hook":
    content => template("gitpuppetsync/post-receive.erb"),
    ensure  => present,
    group   => $gitpuppetsync::repository_user,
    mode    => 0755,
    owner   => $gitpuppetsync::repository_user,
    path    => "${repository_path}/hooks/post-receive",
    require => [Class['gitpuppetsync::install'], Class['gitpuppetsync::environments']],
  }

}
