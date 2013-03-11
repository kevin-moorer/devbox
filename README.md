# LAMP Setup based on CentOS 6.3 with Vagrant / Puppet

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

Clone this repo

```bash

git clone https://github.com/pdaether/LAMP-CentOS-with-Vagrant.git .

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
