include nubis_discovery

# XXX: This will need some post-bootup magic to include a project-specific tag, known only at bootup
# XXX: Environment too ?
nubis::discovery::service { 'jenkins':
  tags => [ 'jenkins' ],
  port => "8080",
  check => "/usr/bin/curl -is http://localhost:8080/cc.xml",
  interval => "30s",
}

class { 'jenkins':
  version => "1.644",
  configure_firewall => false,
  config_hash => {
    'JAVA_ARGS' => {
      'value' => '-Djava.awt.headless=true -Dhudson.diyChunking=false'
    },
  },
}

# Will eventually need to pull this from the registry
# jenkins::job { "nubis-ci":
#  enabled => 0,
#  config => template("/tmp/nubis-ci.xml.erb"),
# }

#XXX: Needs to be project-aware
#consul::service { 'jenkins':
#  tags           => ['nubis-ci'],
#  port           => 8080,
#  check_script   => '/usr/bin/wget -q -O- http://localhost:8080/cc.xml',
#  check_interval => '10s',
#}

## ADDITIONAL PLUGINS ##

jenkins::plugin { "git":
    version => "2.4.1"
}

jenkins::plugin { "github":
    version => "1.14.2"
}

jenkins::plugin { "github-api":
    version => "1.71"
}

jenkins::plugin { "github-oauth":
    version => "0.22.2"
}

jenkins::plugin { "multiple-scms":
    version => "0.5"
}

jenkins::plugin { "parameterized-trigger":
    version => "2.29"
}

jenkins::plugin { "jackson2-api":
    version => "2.5.4"
}

jenkins::plugin { "token-macro":
    version => "1.12.1"
}

jenkins::plugin { "s3":
    version => "0.8"
}

jenkins::plugin { "plain-credentials":
    version => "1.1"
}

jenkins::plugin { "aws-java-sdk":
    version => "1.10.42"
}

jenkins::plugin { "copyartifact":
    version => "1.37"
}

jenkins::plugin { "git-client" :
    version => "1.19.1"
}

jenkins::plugin { "scm-api" :
    version => "1.0"
}

jenkins::plugin { "rebuild" :
    version => "1.25"
}

jenkins::plugin { "promoted-builds":
    version => "2.24.1"
}

jenkins::plugin { "pegdown-formatter":
    version => "1.3"
}

jenkins::plugin { "thinBackup":
    version => "1.7.4"
}

# This is for librarian-puppet, below, and somewhat ugly
package { "ruby-dev":
  ensure => "1:1.9.3.4",
}

package { "librarian-puppet":
  ensure => "2.2.1",
  provider => "gem",
  require => [
    Package["ruby-dev"],
  ],
}

# These are Ubuntu specific versions, needs fixing, but not with/without latest ?
package { "unzip":
    ensure => "6.0-9ubuntu1.5",
}

package { "git":
    ensure => "1:1.9.1-1ubuntu0.2",
}

package { "make":
    ensure => "3.81-8.2ubuntu3",
}
