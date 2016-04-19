# docker-moztrap

A lightweight test case management system based on Python/Django and provided by Mozilla.

## Installation

### Pull In and Run a MySQL Server Container

``` shell
$ docker pull orchardup/mysql
$ docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=qwerty --name mysql orchardup/mysql
```

### Build docker-moztrap

```shell
$ docker build -t docker-moztrap /path/to/Dockerfile
```

### Initiate docker-moztrap

``` shell
$ docker run -it --link=mysql:mysql -e MYSQL_ENV_MYSQL_PASS=qwerty docker-moztrap /moztrap-init.sh
```

This command will initiate the database for the Moztrap app.

### Running docker-moztrap

``` shell
$ docker run -d --link=mysql:mysql -p 8000:8000 docker-moztrap
```

### Adding a User to a docker-moztrap Container

``` shell
$ docker run -it --link=mysql:mysql docker-moztrap /moztrap-add-user.sh user user@localhost qwerty
```
This will add a basic user to the app with a username set to "user", an email address set to "user@localhost", and a password set to "qwerty".
