FROM redhat/ubi9:9.1.0

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
RUN dnf module reset -y php && dnf module install -y php:remi-8.0 \
    && dnf install -y php-gd php-mysqlnd php-pecl-zip mod_security composer httpd npm \
    && dnf upgrade -y

ADD entrypoint.sh /usr/sbin/entrypoint.sh
ADD vhost.conf /etc/httpd/conf.d/vhost.conf

RUN useradd -s /bin/bash -d /home/test_user -g users -G apache -m test_user \
    && ln -sf /usr/share/zoneinfo/Europe/Dublin /etc/localtime \
    && ln -sf /proc/1/fd/1 /var/log/php-fpm/error.log \
    && ln -sf /proc/1/fd/2 /var/log/php-fpm/www-error.log \
    && sed -i 's/^post_max_size = 8M/post_max_size = 20M/' /etc/php.ini \
    && sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 20M/' /etc/php.ini \
    && sed -i 's/^variables_order = "G/variables_order = "EG/' /etc/php.ini \
    && sed -i 's/^short_open_tag = Off/short_open_tag = On/' /etc/php.ini \
    && sed -i 's/^expose_php = On/expose_php = Off/' /etc/php.ini \
    && sed -i 's/^;clear_env/clear_env/' /etc/php-fpm.d/www.conf \
    && sed -i 's/^;catch_workers_output/catch_workers_output/' /etc/php-fpm.d/www.conf \
    && sed -i 's/^;pm.status_path = \//pm.status_path = \/fpm-/' /etc/php-fpm.d/www.conf \
    && sed -i '$aServerTokens Prod' /etc/httpd/conf/httpd.conf \
    && sed -i 's/^#LoadModule mpm_prefork_module/LoadModule mpm_prefork_module/' /etc/httpd/conf.modules.d/00-mpm.conf \
    && sed -i 's/^LoadModule mpm_event_module/#LoadModule mpm_event_module/' /etc/httpd/conf.modules.d/00-mpm.conf \
    && /bin/rm /etc/httpd/conf.modules.d/10-mod_security.conf \
    && /bin/rm /etc/httpd/conf.modules.d/00-brotli.conf \
    && /bin/rm /etc/httpd/conf.d/mod_security.conf \
    && chmod +x /usr/sbin/entrypoint.sh \
    && mkdir -p /run/php-fpm

ENTRYPOINT [ "/usr/sbin/entrypoint.sh" ]

EXPOSE 80
