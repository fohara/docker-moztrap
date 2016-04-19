FROM ubuntu
MAINTAINER mccarrmb <mccarrmb@github.com>

#Persistent environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DB_ROOT_PASSWORD=moztrap
ENV MOZTRAP_ENV="/moztrap/.moztrap-env"

#Disables Upstart
RUN dpkg-divert --local --rename --add /sbin/initctl && \
    ln -sf /bin/true /sbin/initctl && \
    ln -sf /bin/false /usr/sbin/policy-rc.d

#Install required Ubuntu packages
RUN apt-get update --yes
RUN apt-get install --yes --quiet python-pip git python-dev \
 libmysqlclient-dev build-essential mysql-client supervisor \
 nginx memcached libxml2-dev libxslt1-dev && \
 apt-get clean

#Install required Python tools
RUN pip install virtualenv uwsgi

#Pull in the Moztrap repository and all sub-modules within
RUN git clone --recursive git://github.com/mozilla/moztrap

#Copy over dependency and main app configs
COPY moztrap moztrap/
COPY etc etc/

#Initializing Moztrap python environment
RUN virtualenv $MOZTRAP_ENV
RUN . $MOZTRAP_ENV/bin/activate && /moztrap/bin/install-reqs && \
    /moztrap/manage.py collectstatic --noinput
RUN chown -R www-data /moztrap
RUN mkdir -p /var/run/nginx

#Move Moztrap helpers over
ADD init /
ADD add-user /

EXPOSE 8000

#Runs supervisord in the foreground for debugging purposes
CMD ["/usr/bin/supervisord", "-n"]

