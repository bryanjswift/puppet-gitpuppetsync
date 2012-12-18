# == Class: gitpuppetsync
#
# Manage puppet environment by pushing changes to a git
# repository. This installs the [puppet-sync command][ps].
#
# Includes a definition to set up a post-receive hook in the specified
# repository. The post-receive hook can only be set up if the repository
# is on the node executing gitpuppetsync.
#
# [ps]: https://github.com/pdxcat/puppet-sync
#
# === Examples
#
#  include gitpuppetsync
#
# === Authors
#
# Bryan J Swift <bryan.j.swift@gmail.com>
#
# === Copyright
#
# Copyright 2012 Bryan J Swift
#
class gitpuppetsync(
  $environments_dir = "/etc/puppet/environments",
  $repository_user  = "git",
) {

  include gitpuppetsync::install
  include gitpuppetsync::environments

}
