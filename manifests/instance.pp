# == Define: slackin::instance
#
# Configures an instance of slackin
#
# === Parameters
#
# The following parameters are required:
# 
# [*api_token*]
#  The API token for your slack instance, can be generated
#  here: https://api.slack.com/web
#
# [*team_id*]
#   The team ID for your slack instance. This is the subdomain of
#   slack.com that your slack team runs on, e.g example.slack.com
#   should be set to "example".
#
# The following parameters are optional:
#
# [*channels*]
#   An array of channels that single-channel guests may choose from.
#   Requires a paid version of slack. Currently unimplemented
#
# [*css*]
#   The path to a custom css file to use. You are responsible for
#   supplying this file. Currently unimplemented
#
# [*hostname*]
#   The IP Address to bind to.
#
# [*interval*]
#   The number of milliseconds to wait between querying for
#   the number of registered/active users. 
#
# [*port*]
#   The port to bind to. Each instance must use a unique port
#
# [*silent*]
#   How noisy to be.
# === Authors
#
# Jordan Evans <jevans@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2016 The Linux Foundation

define slackin::instance (
  $api_token = undef,
  Array[String] $channels = [],
  $css = undef,
  String $ensure = 'present',
  String $hostname = '0.0.0.0',
  Integer $interval = 5000,
  Integer $port = 8080,
  Boolean $silent = true,
  $team_id = undef,
) {
  
  if ($api_token == undef or $team_id == undef) {
    fail("slackin::instance \$api_token and \$team_id must be specified")
  }

  case $ensure {
    'present': {
      user { "slackin-${name}":
        ensure => present,
        shell  => '/sbin/nologin',
      }

      file { "/usr/local/bin/slackin-${name}":
        ensure  => file,
        owner   => "slackin-${name}",
        group   => "slackin-${name}",
        mode    => '0750',
        content => template('slackin/slackin.erb'),
        require => User["slackin-${name}"],
      }

      file { '/etc/systemd/system/slackin@.service':
        ensure  => file,
        source  => 'puppet:///modules/slackin/slackin@.service',
        require => [User["slackin-${name}"],
                    File["/usr/local/bin/slackin-${name}"]],
      }

      service {"slackin@${name}":
        ensure  => true,
        enable  => true,
        require => File['/etc/systemd/system/slackin@.service'],
      }
    }
    'absent': {
    }
    default: {
    }
  }
}
