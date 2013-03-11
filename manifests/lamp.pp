class iptables {
  package { "iptables": 
    ensure => present;
  }

  service { "iptables":
    require => Package["iptables"],
    hasstatus => true,
    status => "true",
    # hasrestart => false,
  }

	file { "/etc/sysconfig/iptables":
		owner   => "root",
		group   => "root",
		mode    => 600,
		replace => true,
		ensure  => present,
		# source  => "puppet:///files/iptables.txt",
		source  => "/vagrant/files/iptables.txt",
		# content => template("puppet:///templates/iptables.txt"),
		require => Package["iptables"],
		notify  => Service["iptables"],
		;
	}
}

class drush {
  exec { "download-drush":
	  cwd => "/root",
		command => "/usr/bin/wget http://ftp.drupal.org/files/projects/drush-7.x-5.8.tar.gz",
		creates => "/root/drush-7.x-5.8.tar.gz",
	}
	
	exec { "install-drush":
	  cwd => "/var/www/drupal",
		command => "/bin/tar xvzf /root/drush-7.x-5.8.tar.gz",
		creates => "/var/www/drupal/drush",
		require => [ Exec["download-drush"], File["/var/www/drupal"] ]
	}

	file { "/etc/profile.d/drush.sh":
	  owner => "root",
		group => "root",
		mode => 775,
		replace => true,
		ensure => present,
		source => "/vagrant/files/drush.txt",
    require => [ Exec["install-drush"], File["/var/www/drupal"] ]
  }

#	exec { "pecl-uploadprogress":
#	  cwd => "/root",
#		command => "/usr/bin/pecl install uploadprogress"
#  }

	file { "/etc/php.d/uploadprogress.ini":
	  ensure => present,
		source => "/vagrant/files/uploadprogress.txt",
		replace => true,
#		require => Exec["pecl-uploadprogress"]
	}
}

#note - currently the mongo stuff does not get downloaded from here, but i'll add it anyway
class 10gen {
  file { "/etc/yum.repos.d/10gen.repo":
    owner   => "root",
	  group   => "root",
	  mode    => 644,
		replace => true,
		ensure  => present,
		source  => "/vagrant/files/10g_repo.txt",
  }
}

class misc {
	exec { "grab-epel":
		command => "/bin/rpm -Uvh http://mirror.overthewire.com.au/pub/epel/6/i386/epel-release-6-8.noarch.rpm",
		creates => "/etc/yum.repos.d/epel.repo",
		alias   => "grab-epel",
	}

  package { "bind-utils":
	  ensure => present
	}

	package { "emacs":
	  ensure => present
	}

	package { "ImageMagick":
	  ensure => present
	}

	package { "mongodb-server":
	  ensure => present,
    #source => "http://mirror.overthewire.com.au/pub/epel/6/i386/epel-release-6-8.noarch.rpm",
		#provider => rpm
	  require => Exec["grab-epel"]
	}

	service { "mongod":
	  ensure => running,
		enable => true,
		require => Package["mongodb-server"]
  }

	package { "subversion":
	  ensure => present
	}

  package { "unzip":
	  ensure => present
	}

	file { "/var/www":
	  ensure => "directory",
		owner => "root",
		group => "root",
		mode => 775
	}

	file { "/var/www/drupal":
	  ensure => "directory",
		owner => "root",
		group => "root",
		mode => 775
	}
}

class git {
  package { "git":
	  ensure => present
	}
}

class memcache {
	package { "memcached":
	  ensure => present,
	}

	file { "/etc/rc.d/rc.local":
		owner   => "root",
		group   => "root",
		mode    => 644,
		replace => true,
		ensure  => present,
		source  => "/vagrant/files/rclocal.txt",
		require => File["/usr/local/bin/startMemcached.sh"]
	}

	file { "/usr/local/bin/startMemcached.sh":
		owner   => "root",
		group   => "root",
		mode    => 775,
		replace => true,
		ensure  => present,
		source  => "/vagrant/files/startMemcached.sh",
	}

	file { "/usr/local/bin/stopMemcached.sh":
		owner   => "root",
		group   => "root",
		mode    => 775,
		replace => true,
		ensure  => present,
		source  => "/vagrant/files/stopMemcached.sh",
	}
}

class httpd {
  #exec { 'yum-update':
  #  command => '/usr/bin/yum -y update'
  #}

	package { "httpd":
	  ensure => present
	}

	package { "httpd-devel":
	  ensure  => present
	}

	service { 'httpd':
		name      => 'httpd',
		require   => Package["httpd"],
		ensure    => running,
		enable    => true
	}

	file { "/etc/httpd/conf.d/vhost.conf":
		owner   => "root",
		group   => "root",
		mode    => 644,
		replace => true,
		ensure  => present,
		source  => "/vagrant/files/vhost.conf",
		require => Package["httpd"],
		notify  => Service["httpd"]
	}
}

class phpdev {
	package { "libxml2-devel":
	  ensure  => present,
	}


	package { "libXpm-devel":
	  ensure  => present,
	}

	package { "gmp-devel":
	  ensure  => present,
	}

	package { "libicu-devel":
	  ensure  => present,
	}

	package { "t1lib-devel":
	  ensure  => present,
	}

	package { "aspell-devel":
	  ensure  => present,
	}

	package { "openssl-devel":
	  ensure  => present,
	}

	package { "bzip2-devel":
	  ensure  => present,
	}

	package { "libcurl-devel":
	  ensure  => present,
	}

	#package { "libjpeg-devel":
	#  ensure  => present,
	#}

	package { "libvpx-devel":
	  ensure  => present,
	}

	package { "libpng-devel":
	  ensure  => present,
	}

	package { "freetype-devel":
	  ensure  => present,
	}

	package { "readline-devel":
	  ensure  => present,
	}

	package { "libtidy-devel":
	  ensure  => present,
	}

	package { "libxslt-devel":
	  ensure  => present,
	}
}

class mysql {
	package { "mysql-server":
	ensure  => present,
	}

	package { "mysql":
	ensure  => present,
	}

	service { "mysqld":
	ensure => running, 
	require => Package["mysql-server"]
	}
}

class php {
  package { "php":
    ensure  => present,
  }

	package { "php-cli":
	  ensure  => present,
	}

	package { "php-common":
	  ensure  => present,
	}

	package { "php-devel":
	  ensure  => present,
	}

	package { "php-gd":
	  ensure  => present,
	}

	package { "php-mcrypt":
	  ensure  => present,
	}

	package { "php-intl":
	  ensure  => present,
	}

	package { "php-ldap":
	  ensure  => present,
	}

	package { "php-mbstring":
	  ensure  => present,
	}

	package { "php-mysql":
	  ensure  => present,
	}

	package { "php-pdo":
	  ensure  => present,
	}

	package { "php-pear":
	  ensure  => present,
	}

	package { "php-pecl-apc":
	  ensure  => present,
	}

	package { "php-pecl-memcache":
	  ensure => present,
	}

	package { "php-soap":
	  ensure  => present,
	}

	package { "php-xml":
	  ensure  => present,
	}

	package { "uuid-php":
	  ensure  => present,
	}

	package { "php-pecl-imagick":
	  ensure  => present,
	  require => Exec["grab-epel"]
	}

	package { "php-pecl-mongo":
	  ensure => present,
	  require => Exec["grab-epel"]
	}
}

class phpmyadmin {
  package { "phpMyAdmin":
    ensure  => present,
  }

	file { "/etc/httpd/conf.d/phpMyAdmin.conf":
		owner   => "root",
		group   => "root",
		mode    => 644,
		replace => true,
		ensure  => present,
		source  => "/vagrant/files/phpMyAdmin.conf",
		require => Package["httpd"],
		notify  => Service["httpd"],
		;
	}

	file { "/etc/phpMyAdmin/config.inc.php":
		owner   => "root",
		group   => "root",
		mode    => 644,
		replace => true,
		ensure  => present,
		source  => "/vagrant/files/phpmy_admin_config.inc.php",
		require => Package["phpMyAdmin"]
	}
}

class rpmforge {
  exec {
    "/usr/bin/wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm":
    alias   => "grab-rpmforge",
  }

  exec {
    "/bin/rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt":
    alias   => "import-key",
    require => Exec["grab-rpmforge"],
  }

  exec {
    "/bin/rpm -i rpmforge-release-0.5.2-2.el6.rf.*.rpm":
    alias   => "install-rpmforge",
    require => Exec["import-key"],
  }

	package { "libmcrypt-devel":
	  ensure  => present,
	  require => Exec["install-rpmforge"]
	}
}


include iptables
#include rpmforge
#include 10gen
include misc
include git
include httpd
include phpdev
include mysql
include php
include memcache
include phpmyadmin
include drush
