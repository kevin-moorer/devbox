# DEVBOX - Centos 6.3

## Overview

This configuration is a full LAMP stack based on CentOS.
The following items are included:

* Apache
* MySQL
* PHP
* phpMyAdmin
* ImageMagick
* PHP Imagick
* MongoDB
* SQLite3
* Memcached
* Drush
* APC


**Attention:** This is just a quick vagrant based VM for some of my local development and testing.
DON'T use this VM in a production environment.


## Installation

Before you start: 
I am using a 64 bit version of CentOS as base box. So make sure that you can virtualize a 64 bit system.

1. Download and install the following (facter must be installed before puppet)

VirtualBox
http://virtualbox.org

Vagrant (on mac) 
gem install vagrant

Facter, Hiera, Puppet  
http://docs.puppetlabs.com/guides/installation.html#mac-os-x
http://docs.puppetlabs.com/guides/installation.html#with-launchd



Clone this repo

```bash
git clone https://github.com/kevin-moorer/devbox.git .
```

or just download the source code as Zip file.

Start the VM:

```bash
vagrant up
```

## Usage

Now, you can reach the webroot with `http://localhost:8081`.
Also you can find a working installation of PhpMyAdmin under `http://localhost:8081/phpMyAdmin/`.

local.aetv.com is setup and ready to use with the DocumentRoot using /webroot (mapped to share dir webroot)


The Mysql password for root is empty.

To login into the VM type
```bash
vagrant ssh
```

To halt the VM:
```bash
vagrant halt
```

Other useful vagrant commands:

Suspend the VM
```bash
vagrant suspend 
```

Resume the VM from the suspended state
```bash
vagrant resume
```

While the VM is still in the 'up' state, Re-run the puppet script (lamp.pp)
```bash
vagrant provision
```

Fully reload the VM
```bash
vagrant reload
```

Show the current state of the VM
```bash
vagrant status
```


## Centos Tips

Services

Services can be accessed thru the command 'service SERVICENAME command'.
For example, to restart apache: service httpd restart

Some of the key services around development are:
MongoDB (mongod)
Apache (httpd)
Memcached (memcached2)
Network Services (network) - for the whole OS
MySQL (mysqld)


Some operations (installing stuff, changing the status of a service, etc.) will require you to be 
the root user. To switch to the root user, use 'su -' and the password is 'vagrant'





















