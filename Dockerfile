FROM richardjkendall/ubuntu-pam-dynamo:630e9ca9

# install apache2 and mod_authnz_pam
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y apache2 libapache2-mod-authnz-pam

# install pam config
COPY config/aws /aws.pam

# install apache config
COPY config/000-default.conf /apache.conf
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/proxy.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/proxy_wstunnel.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/rewrite.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/proxy_http.load
RUN cd /etc/apache2/mods-enabled; ln -s ../mods-available/headers.load


# install docker-entrypoint (which sets up pam config with deployment specific variables)
RUN apt-get install -y gettext-base
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# expose apache2 port
EXPOSE 80

# run httpd in the foreground
CMD /usr/sbin/apache2ctl -D FOREGROUND
