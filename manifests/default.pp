Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

exec { "apt_get_update":
    command => "apt-get update",
}

package { "python-software-properties":
    ensure => present,
    require => Exec["apt_get_update"],
}

include stdlib
include apt

apt::ppa { "ppa:ondrej/php5": }

exec { "apt_get_update_2":
    command => "apt-get update",
}

exec { "apt_get_upgrade":
    command => "apt-get -y upgrade",
    require => Exec["apt_get_update_2"],
}

exec { "apt_get_dist_upgrade":
    command => "apt-get -y dist-upgrade",
    require => Exec["apt_get_upgrade"],
}

package { "php5":
    ensure => present,
    require => [Exec["apt_get_update_2"], Exec["apt_get_upgrade"], Exec["apt_get_dist_upgrade"]],
}

package { "php5-dev":
    ensure => present,
    require => Package["php5"],
}

package { "php-pear":
    ensure => present,
    require => Package["php5"],
}

package { "re2c":
    ensure => present,
}

package { "make":
    ensure => present,
}


apt::source { "10gen":
  location          => "http://downloads-distro.mongodb.org/repo/ubuntu-upstart",
  release           => "dist",
  repos             => "10gen",
  required_packages => "debian-keyring debian-archive-keyring",
  key               => "7F0CEB10",
  key_server        => "keyserver.ubuntu.com",
  include_src       => false
}

package { "mongodb-10gen":
    ensure => present,
    require => Apt::Source["10gen"],
}

exec { "install_mongo_drivers":
    command => "pecl install mongo",
    require => [Package["php-pear"], Package["php5-dev"], Package["mongodb-10gen"]],
}

file { "/etc/php5/conf.d/mongo.ini":
    content => "extension=mongo.so",
    require => Exec["install_mongo_drivers"],
}