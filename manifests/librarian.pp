#
# === Parameters
#
# [*ruby_version*]
#   The version of ruby to install. This is required by librarian-puppet.
#
class gitpuppetsync::librarian(
  $ruby_version = '1.9.1',
) {

  $ruby_version = $gitpuppetsync::ruby_version

  package { 'build-essential':
    ensure => latest,
    name   => 'build-essential',
  }

  package { 'ruby-dev':
    ensure  => latest,
    name    => "ruby${ruby_version}-dev",
    require => [Package['build-essential']],
  }

  exec { 'Install librarian-puppet':
    command => 'gem install librarian-puppet --no-ri --no-rdoc',
    creates => '/usr/local/bin/librarian-puppet',
    path    => ['/usr/local/bin', '/usr/bin', '/bin'],
    require => [Package['ruby-dev']],
    user    => 'root',
  }

}
