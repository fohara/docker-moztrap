# Moztrap

A lightweight test case management system based on Python/Django

## Installation

### Setup and Run a MySQL Server

``` shell
$ docker pull orchardup/mysql
$ docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=qwerty --name mysql orchardup/mysql
```

### Initiate Moztrap

``` shell
$ docker run -it --link=mysql:mysql -e MYSQL_ENV_MYSQL_PASS=qwerty docker-moztrap /moztrap-init.sh
```

This command will initiate database for Moztrap.

### Run Moztrap

``` shell
$ docker run -d --link=mysql:mysql -p 8000:8000 docker-moztrap
```

### Adding a User to Moztrap Container

``` shell
$ docker run -it --link=mysql:mysql docker-moztrap /moztrap-add-user.sh user user@localhost qwerty
```
This will add a basic user to the app with a username set to "user", an email address set to "user@localhost", and a password set to "qwerty".
