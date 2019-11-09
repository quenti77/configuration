## PHP

Installation avec les différents package en plus

```bash
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php

# Liste les packages de php 7 (ou plus précis)
sudo apt-cache search php7

# Installation de php 7.4
# (liste des packages en plus en fonctin du besoin)
sudo apt install php7.4-cli php7.4-common php7.4-curl php7.4-dev php7.4-fpm php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-opcache php7.4-pgsql php7.4-readline php7.4-xml php7.4-zip php-xdebug

# Installation de Redis pour les session
sudo add-apt-repository ppa:chris-lea/redis-server
sudo apt install redis-server

sudo apt-get -y install gcc make autoconf libc-dev pkg-config
sudo pecl install redis

# Accept default answer

sudo bash -c "echo extension=redis.so > /etc/php/7.4/mods-available/redis.ini"
sudo ln -s /etc/php/7.4/mods-available/redis.ini /etc/php/7.4/cli/conf.d/90-redis.ini
sudo ln -s /etc/php/7.4/mods-available/redis.ini /etc/php/7.4/fpm/conf.d/90-redis.ini
sudo service php7.4-fpm restart

sudo vim /etc/php/7.4/mods-available/xdebug.ini

# Configuration du fichier xdebug (voir contenu plus bas) ...
```

### Configuration de php

fichier php.ini dans le dossier cli de /etc/php

```ini
output_buffering = Off
expose_php = Off
max_execution_time = 0 # Hardcoded for CLI
error_reporting = E_ALL
display_errors = On # Dev only (false else)
display_startup_errors = On # Dev only (false else)
error_log = syslog
syslog.ident = php-cli
date.timezone = Europe/Paris
session.save_handler = redis
session.save_path = "tcp://127.0.0.1:6379"
```

fichier php.ini dans le dossier fpm de /etc/php

```ini
output_buffering = Off
error_reporting = E_ALL
display_errors = On # Dev only (false else)
display_startup_errors = On # Dev only (false else)
error_log = syslog
syslog.ident = php-fpm
date.timezone = Europe/Paris
session.save_handler = redis
session.save_path = "tcp://127.0.0.1:6379"
```

Fichier xdebug.ini
```ini
zend_extension=xdebug.so
xdebug.remote_enable=on
xdebug.remote_host=127.0.0.1
xdebug.remote_port=9000
xdebug.remote_handler=dbgp
```

### Autre package à installer

composer :

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/bin --filename=composer
php -r "unlink('composer-setup.php');"
```
