FROM richardjkendall/ubuntu-pam-dynamo:latest

# install apache2 and mod_authnz_pam
RUN apt-get update -y
RUN apt-get install -y apache2 libapache2-mod-authnz-pam

# install pam config
COPY config/aws /aws.pam

# install apache config
COPY config/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY config/dav-lock-db.conf /etc/apache2/conf-available
RUN cd /etc/apache2/conf-enabled; ln -s ../conf-available/dav-lock-db.conf
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/dav.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/dav_lock.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/dav_fs.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/headers.load

# create folders needed for dav root and lockdb
RUN mkdir -p /dav/db
RUN mkdir -p /dav/root
RUN chown www-data:www-data /dav/root
RUN chown www-data:www-data /dav/db
RUN chmod 700 /dav/db
RUN chmod 700 /dav/root

# install docker-entrypoint (which sets up pam config with deployment specific variables)
RUN apt-get install -y gettext-base
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# expose apache2 port
EXPOSE 80

# run httpd in the foreground
CMD /usr/sbin/apache2ctl -D FOREGROUND
