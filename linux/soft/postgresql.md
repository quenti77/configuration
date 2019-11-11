## PostgreSQL

Installation et connection sur le compte de postgresql

```bash
sudo apt install postgresql postgresql-contrib
sudo -i -u postgres
```

Commande pour créer un utilisateur et une base de données associé

```sql
create user <username> with encrypted password '<password>';

-- A faire pour chaque base de données
create database <dbname>;
grant all privileges on database <dbname> to <username>;
flush privileges

create extension if not exists "uuid-ossp"; -- uuid functions
```

### Configuration

```bash
sudo vim /etc/postgresql/{version_number}/main/pg_hba.conf
```

```conf
# TYPE  DATABASE        USER            ADDRESS             METHOD
local   all             postgres                            peer
host    all             all             127.0.0.1/32        md5
```

```sql
\du                     -- => Liste les rôles
\l                      -- => List des bases de données
\c db                   -- => Connection sur une autre bdd
SET ROLE <username>     -- => Change l'utilisateur actif
```

### PgAdmin4

Lien de téléchargement pour python : [python version](https://www.pgadmin.org/download/pgadmin-4-python-wheel/)

```bash
sudo apt install python3-dev python3-venv wget python3-setuptools python3-pip

# Créer un dossier pour le download
mkdir -p ~/Documents
cd ~/Documents

wget https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v4.14/pip/pgadmin4-4.14-py2.py3-none-any.whl

# Création d'un environement
bash # si différent de bash pour le shell
python3.7 -m venv pgadmin4 && source pgadmin4/bin/activate

# création d'un service
pip3 install wheel
pip3 install pgadmin4-4.14-py2.py3-none-any.whl

cd pgadmin4/lib64/python3.7/site-packages/pgadmin4/
vim config_local.py # voir contenu ci-dessous

cd ~/Documents
python3.7 pgadmin4/lib64/python3.7/site-packages/pgadmin4/setup.py

# test de lancement
python3.7 pgadmin4/lib64/python3.7/site-packages/pgadmin4/pgAdmin4.py
```

```ini
SERVER_MODE = False
LOG_FILE = '/home/quentin/.pgadmin/pgadmin4.log'
SQLITE_PATH = '/home/quentin/.pgadmin/pgadmin4.db'
SESSION_DB_PATH = '/home/quentin/.pgadmin/sessions'
STORAGE_DIR = '/home/quentin/.pgadmin/storage'
```

Création du service :

```bash
# Plus besoin d'être sur bash ici
sudo vim /etc/systemd/system/pgadmin4.service

sudo systemctl daemon-reload
sudo systemctl enable pgadmin4.service
sudo systemctl start pgadmin4.service
sudo systemctl status pgadmin4.service
```

```ini
[Unit]
Description=Pgadmin4 Service
After=network.target

[Service]
User=quentin
Group=quentin
WorkingDirectory=/home/quentin/Documents/pgadmin4/
Environment="PATH=/home/quentin/Documents/pgadmin4/bin"
ExecStart=/home/quentin/Documents/pgadmin4/bin/python /home/quentin/Documents/pgadmin4/lib64/python3.7/site-packages/pgadmin4/pgAdmin4.py
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

### Nginx proxy (pour simplifier)

```
# Dans le fichier /etc/hosts
# 127.0.0.1 pgadmin

sudo vim /etc/nginx/conf.d/pgadmin.conf
sudo systemctl restart nginx.service
```

```nginx
server {
    listen 80;
    server_name pgadmin;

    location / {
        proxy_pass http://127.0.0.1:5050;
    }
}
```
