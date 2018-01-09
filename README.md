# vagrant-archlinux
Archlinux development environment provided by Vagrantfile

## Requirements

* [vagrant](https://www.vagrantup.com/downloads.html)
* [virtualbox](https://www.virtualbox.org/wiki/Downloads)

## Run

Inside source directory

```shell
vagrant up
```

## Description

Provide a linux vm based on archlinux and kde with the following configuration :

* RAM : 4 GB
* Synced Folder : `/home/vagrant/source` -> `C:/source`

and the following tools :

* java 8 (openjdk)
* git
* docker
* docker-compose
* atom
* intelliJ (Community Edition)
* firefox
* gatling

## Configuration

* DOCKER_COMPOSE_VERSION : the version of docker-compose you want to install : [latest](https://github.com/docker/compose/releases/latest)
