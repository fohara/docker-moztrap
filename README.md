# docker-moztrap

A lightweight test case management system based on Python/Django and provided by Mozilla.


## Installation


### Pull In and Run a MySQL Server Container

The docker-moztrap container is built assuming that the end user will link it with a MySQL container.  

``` shell
$ docker pull orchardup/mysql
$ docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=moztrap --name <name of mysql container> orchardup/mysql
```

Although any MySQL container will do, the root MySQL user's password must be set to 'moztrap'. Naming isn't required but it is much more helpful than using the random names assigned when containers are run.


### Build docker-moztrap

The docker build process should pull in all required packages and libraries in order to run Moztrap.

```shell
$ docker build -t docker-moztrap /path/to/Dockerfile
```

### Initialize docker-moztrap

Note that at this point docker-moztrap needs to be linked to the running MySQL container. Ensure that the name of the container in the --link option is aliased to 'db' as a few internal variables use this in order to resolve correctly.

``` shell
$ docker run -it --link=<name of mysql container>:db docker-moztrap /init
```

### Adding a User to a docker-moztrap Container

The add-user command is provided in order to make creating initial accounts simpler.  The command format is as follows:

```shell
$ add-user <username> <email> <password> [--staff] [--admin]
```

The --staff and --admin flags toggle the appropriate user permissions in the database.  A user that is set as staff can access Moztrap's Django backend (the /admin/ URI) and perform advanced functions.  A user flagged as an admin will always have the abilities of staff no matter what other group they are assigned to.  Users may have both or neither flag set if preferred.

Example usage within docker:

``` shell
$ docker run -it --link=mysql:mysql docker-moztrap /add-user admin admin@localhost.local AdminPassw0rd --staff --admin
```
The above example will provide an account named 'admin' that will have full access to the application.


### Running docker-moztrap

Finally, the container can be started by the following:

``` shell
$ docker run -d --link=<name of mysql container>:db -p 8000:8000 docker-moztrap
```

Moztrap should immediately become accessable on http://localhost:8000 once the above command is run.

