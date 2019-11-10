## Nginx

Installation et configuration de base

```bash
sudo apt install curl gnupg2 ca-certificates lsb-release
echo "deb http://nginx.org/packages/mainline/debian buster nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
sudo apt-key fingerprint ABF5BD827BD9BF62
sudo apt update
sudo apt install nginx
```

Dans le fichier /etc/nginx/nginx.conf

```nginx
# changer le user
user www-data;

# activer le gzip
gzip on;
gzip_vary on;
gzip_min_length 10240;
gzip_proxied expired no-cache no-store private auth;
gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml;
gzip_disable "MSIE [1-6]\.";

# Changer les logs pour syslog
error_log syslog:server=127.0.0.1,tag=nginx_main_error warn;
access_log syslog:server=127.0.0.1,tag=nginx_main_access main;
```

Pour créer un vhost

La premier fois il faut :

```bash
# La première fois
cd /etc/nginx/conf.d
sudo mv default.conf default.conf.save

sudo mkdir -p /etc/nginx/snippets
cd /etc/nginx/snippets
sudo vim ssl-global-params.conf
# voir le contenu du fichier

sudo apt install libnss3-tools
# download release https://github.com/FiloSottile/mkcert/releases
# déplacer et renommer le fichier dans /usr/bin
sudo mv /path/to/download/file /usr/bin/mkcert
sudo chmod +x /usr/bin/mkcert

mkcert -install
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

Fichier ssl-global-params.conf :
```nginx
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
ssl_ecdh_curve secp384r1;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;

resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;

#add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
add_header Strict-Transport-Security "max-age=63072000; includeSubdomains";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;

ssl_dhparam /etc/ssl/certs/dhparam.pem;
```

Pour du php :
```bash
# Exemple de site : choptaphoto.local (et tous les sous-domaines)
cd ~
mkcert 'choptaphoto.local' '*.choptaphoto.local'
sudo mv choptaphoto.local+1.pem /etc/nginx/snippets/choptaphoto.pem
sudo mv choptaphoto.local+1-key.pem /etc/nginx/snippets/choptaphoto_key.pem

sudo vim /etc/hosts
# ajout des lignes : 127.0.0.1 choptaphoto.local et 127.0.0.1 *.choptaphoto.local

cd /etc/nginx/conf.d
sudo vim <configname>.conf # choptaphoto.conf par exemple
```

Dans le fichier de config :
```nginx
server {
    listen 80;

    server_name choptaphoto.local;
    root /home/quentin/Projects/choptaphoto/public;

    error_log syslog:server=127.0.0.1,tag=http_choptaphoto_error warn;
    access_log syslog:server=127.0.0.1,tag=http_choptaphoto_access main;

    return 302 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    index index.php;

    server_name choptaphoto.local;
    root /home/quentin/Projects/choptaphoto/public;

    error_log syslog:server=127.0.0.1,tag=https_choptaphoto_error warn;
    access_log syslog:server=127.0.0.1,tag=https_choptaphoto_access main;

    # ssl
    ssl_certificate /etc/nginx/snippets/choptaphoto.pem;
    ssl_certificate_key /etc/nginx/snippets/choptaphoto_key.pem;
    include snippets/ssl-params.conf;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        try_files $uri /index.php =404;

        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```
