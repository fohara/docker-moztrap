# Moztrap

A lightweight test case management system based on Python/Django and provided by Mozilla.

## Installation

### Set Up and Run a MySQL Server

The easiest way to do this is to just pull in a MySQL container.

``` shell
$ docker pull orchardup/mysql
$ docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=qwerty --name mysql orchardup/mysql
```
### Build docker-Moztrap

```shell
$ docker build -t docker-moztrap /path/to/Dockerfile
```

### Initiate docker-Moztrap

``` shell
$ docker run -it --link=mysql:mysql -e MYSQL_ENV_MYSQL_PASS=qwerty docker-moztrap /moztrap-init.sh
```

This command will initiate the database for Moztrap.

### Running Moztrap

``` shell
$ docker run -d --link=mysql:mysql -p 8000:8000 docker-moztrap
```

### Adding a User to a Moztrap Container

``` shell
$ docker run -it --link=mysql:mysql docker-moztrap /moztrap-add-user.sh user user@localhost qwerty
```
This will add a basic user to the app with a username set to "user", an email address set to "user@localhost", and a password set to "qwerty".
