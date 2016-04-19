FROM ubuntu
MAINTAINER mccarrmb <mccarrmb@github.com>

#Disables Upstart
RUN dpkg-divert --local --rename --add /sbin/initctl &&        \
    ln -sf /bin/true /sbin/initctl &&                          \
    ln -sf /bin/false /usr/sbin/policy-rc.d

#Install required packages
RUN apt-get update --yes
RUN apt-get install --yes --quiet python-pip git python-dev    \
    libmysqlclient-dev build-essential mysql-client supervisor \ 
    nginx memcached &&                                         \
    apt-get clean

#Persistent environment variables
ENV MOZTRAP_ENV="/moztrap/.venv"

RUN pip install virtualenv
RUN pip install uwsgi

#Pull in the Moztrap repository and all sub-modules within 
#(Moztrap 1.5.4 is the stable release as of this script creation)
RUN git clone --recursive git://github.com/mozilla/moztrap
RUN cd /moztrap && git checkout 1.5.4

COPY moztrap moztrap/
WORKDIR /moztrap

#Initializing Moztrap python environment
RUN virtualenv .venv
RUN ./with_venv.sh ./bin/install-reqs
RUN ./with_venv.sh ./manage.py collectstatic --noinput
RUN chown -R www-data /moztrap

WORKDIR /

ADD moztrap-init.sh /
ADD moztrap-nginx /etc/nginx/sites-enabled/
ADD moztrap-supervisor.conf /etc/supervisor/conf.d/
ADD moztrap-add-user.sh /
ADD moztrap-uwsgi.ini /

#I don't think this is required - uses python dev web server
ADD run.sh /

EXPOSE 8000
#Runs supervisord in the foreground for debugging purposes
CMD ["/usr/bin/supervisord", "-n"]

